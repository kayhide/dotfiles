var tolerance = 20;

var is_fullscreen = function(win) {
    var rect = win.rect();
    var bounds = win.screen().visibleRect();
    return rect.x < bounds.x + tolerance &&
        rect.y < bounds.y + tolerance &&
        rect.x + rect.width > bounds.x + bounds.width - tolerance &&
        rect.y + rect.height > bounds.y + bounds.height - tolerance;
}

var is_pushed = function(win, direction) {
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

var push = function(win, direction, screen) {
    if (is_fullscreen(win) || !is_pushed(win, direction)) {
        if (screen) {
            slate.operation('push', {
                direction: direction,
                style: 'bar-resize:screenSizeX/2',
                screen: screen.id()
            }).run();
        }
        else {
            slate.operation('push', {
                direction: direction,
                style: 'bar-resize:screenSizeX/2'
            }).run();
        }
        return true;
    }
    return false;
}

slate.bindAll({
    'left:shift,cmd,ctrl,alt': function(win) {
        if (!win) return;
        if (push(win, 'left')) {
        }
        else {
            var rect = win.rect();
            var pt = {x: rect.x - rect.width - tolerance, y: (rect.y + rect.width) / 2};
            if (!slate.isPointOffScreen(pt)) {
                var screen = slate.screenUnderPoint(pt);
                push(win, 'right', screen);
            }
        }
    },
    'right:shift,cmd,ctrl,alt': function(win) {
        if (!win) return;
        if (push(win, 'right')) {
        }
        else {
            var rect = win.rect();
            var pt = {x: rect.x + rect.width + tolerance, y: (rect.y + rect.width) / 2};
            if (!slate.isPointOffScreen(pt)) {
                var screen = slate.screenUnderPoint(pt);
                push(win, 'left', screen);
            }
        }
    }
});
