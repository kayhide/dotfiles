var tolerance = 20;
var grid_points = [0, 1/4, 2/4, 3/4, 1];


function points(length, offset) {
  return _.map(grid_points, function(r) { return r * length + offset });
}


var Director = {
  create(director) {
    if (director.horizontal) {
      director.origin = function(rect) { return rect.x };
      director.length = function(rect) { return rect.width };
    } else {
      director.origin = function(rect) { return rect.y };
      director.length = function(rect) { return rect.height };
    }

    if (director.forwarding) {
      director.is_touched = function(win) {
        var rect = win.rect();
        var bounds = win.screen().visibleRect();
        return this.origin(rect) + this.length(rect) > this.origin(bounds) + this.length(bounds) - tolerance;
      };

      director.push_point = function(win) {
        var bounds = win.screen().visibleRect();
        var current = this.origin(win.rect());
        return _.find(points(this.length(bounds), this.origin(bounds)).slice(0, -1), function(p) {
          return p > current + tolerance;
        });
      };

      director.pull_point = function(win) {
        var bounds = win.screen().visibleRect();
        var current = this.origin(win.rect()) + this.length(win.rect());
        return _.find(points(this.length(bounds), this.origin(bounds)), function(p) {
          return p > current + tolerance;
        });
      };
    } else {
      director.is_touched = function(win) {
        var rect = win.rect();
        var bounds = win.screen().visibleRect();
        return this.origin(rect) < this.origin(bounds) + tolerance;
      };

      director.push_point = function(win) {
        var bounds = win.screen().visibleRect();
        var current = this.origin(win.rect()) + this.length(win.rect());
        return _.find(points(this.length(bounds), this.origin(bounds)).reverse().slice(0, -1), function(p) {
          return p < current - tolerance;
        });
      };

      director.pull_point = function(win) {
        var bounds = win.screen().visibleRect();
        var current = this.origin(win.rect());
        return _.find(points(this.length(bounds), this.origin(bounds)).reverse(), function(p) {
          return p < current - tolerance;
        });
      };
    }
    return director;
  },

  get(direction) {
    switch (direction) {
    case 'right': return Director.right;
    case 'left': return Director.left;
    case 'up': return Director.up;
    case 'down': return Director.down;
    }
    return null;
  }
};

Director.left = Director.create({ forwarding: false, horizontal: true });
Director.right = Director.create({ forwarding: true, horizontal: true });
Director.up = Director.create({ forwarding: false, horizontal: false });
Director.down = Director.create({ forwarding: true, horizontal: false });


var is_fullscreen = function(win) {
  return Director.left.is_touched(win) &&
    Director.right.is_touched(win) &&
    Director.up.is_touched(win) &&
    Director.down.is_touched(win);
}

var push = function(win, director) {
  var v = director.push_point(win);
  if (v === undefined) return false;

  var rect = win.rect();
  var bounds = win.screen().visibleRect();
  slate.operation('move', {
    x: director.horizontal ? (director.forwarding ? v : bounds.x) : rect.x,
    y: !director.horizontal ? (director.forwarding ? v : bounds.y) : rect.y,
    width: director.horizontal ? (director.forwarding ? bounds.width - (v - bounds.x) : v - bounds.x) : rect.width,
    height: !director.horizontal ? (director.forwarding ? bounds.height - (v - bounds.y) : v - bounds.y) : rect.height,
  }).run();
  return true;
}

var pull = function(win, director) {
  var v = director.pull_point(win);
  if (v === undefined) return false;

  var rect = win.rect();
  var bounds = win.screen().visibleRect();
  slate.operation('move', {
    x: director.horizontal ? (director.forwarding ? bounds.x : v) : rect.x,
    y: !director.horizontal ? (director.forwarding ? bounds.y : v) : rect.y,
    width: director.horizontal ? (director.forwarding ? (v - bounds.x) : (bounds.width - (v - bounds.x))) : rect.width,
    height: !director.horizontal ? (director.forwarding ? (v - bounds.y) : (bounds.height - (v - bounds.y))) : rect.height,
  }).run();
  return true;
}

var cross = function(win, director) {
  return false;
  var rect = win.screen().rect();
  var pt = null;
  if (direction == 'left') pt = {x: rect.x - tolerance, y: (rect.y + rect.width) / 2};
  if (direction == 'right') pt = {x: rect.x + rect.width + tolerance, y: (rect.y + rect.width) / 2};
  if (!slate.isPointOffScreen(pt)) {
    var screen = slate.screenUnderPoint(pt);
    slate.operation('move', screen.rect()).run();
  }
}

slate.bindAll({
  'left:shift,cmd,ctrl,alt': function(win) {
    var dir = Director.left;
    !win || pull(win, dir) || push(win, dir) || cross(win, dir);
  },
  'right:shift,cmd,ctrl,alt': function(win) {
    var dir = Director.right;
    !win || pull(win, dir) || push(win, dir) || cross(win, dir);
  },
  'up:shift,cmd,ctrl,alt': function(win) {
    var dir = Director.up;
    !win || pull(win, dir) || push(win, dir);
  },
  'down:shift,cmd,ctrl,alt': function(win) {
    var dir = Director.down;
    !win || pull(win, dir) || push(win, dir);
  }
});
