var tolerance = 20;
var anchors = [0, 1/4, 2/4, 3/4, 1];
var opposite_direction = { right: 'left', left: 'right' };

var is_fullscreen = function(win) {
    var rect = win.rect();
    var bounds = win.screen().visibleRect();
    return rect.x < bounds.x + tolerance &&
        rect.y < bounds.y + tolerance &&
        rect.x + rect.width > bounds.x + bounds.width - tolerance &&
        rect.y + rect.height > bounds.y + bounds.height - tolerance;
}

var is_touched = function(win, direction) {
    var rect = win.rect();
    var bounds = win.screen().visibleRect();
    if (direction === 'right') {
        return rect.y < bounds.y + tolerance &&
            rect.x + rect.width > bounds.x + bounds.width - tolerance &&
            rect.y + rect.height > bounds.y + bounds.height - tolerance;
    }
    else if (direction === 'left') {
        return rect.x < bounds.x + tolerance &&
            rect.y < bounds.y + tolerance &&
            rect.y + rect.height > bounds.y + bounds.height - tolerance;
    }
}

var get_push_anchor = function(win) {
    var rect = win.rect();
    var bounds = win.screen().visibleRect();
    var pair = _.find(_.zip(anchors, _.rest(anchors)), function(a) {
        return bounds.width * a[0] < rect.width && rect.width <= bounds.width * a[1];
    });
    return (pair && pair[0] > 0) ? pair[0] : null;
}

var get_pull_anchor = function(win) {
    var rect = win.rect();
    var bounds = win.screen().visibleRect();
    var pair = _.find(_.zip(anchors, _.rest(anchors)), function(a) {
        return bounds.width * a[0] <= rect.width && rect.width < bounds.width * a[1];
    });
    return (pair && pair[1] < 1) ? pair[1] : null;
}

var push = function(win, direction) {
    var anchor = is_touched(win, direction) ? get_push_anchor(win) : _.last(anchors);
    if (anchor == null) return false;

    slate.operation('push', {
        direction: direction,
        style: 'bar-resize:screenSizeX*' + anchor
    }).run();
    return true;
}

var pull = function(win, direction) {
    if (!is_touched(win, opposite_direction[direction])) return false;

    var anchor = get_pull_anchor(win);
    if (anchor == null) return false;

    slate.operation('push', {
        direction: opposite_direction[direction],
        style: 'bar-resize:screenSizeX*' + anchor
    }).run();
    return true;
}

var cross = function(win, direction) {
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
        var dir = 'left';
        !win || pull(win, dir) || push(win, dir) || cross(win, dir);
    },
    'right:shift,cmd,ctrl,alt': function(win) {
        var dir = 'right';
        !win || pull(win, dir) || push(win, dir) || cross(win, dir);
    }
});
