#!/usr/bin/env sh
#
# Window-focus helper that self-heals when no window is focused.
#
# After switching spaces or displays, macOS sometimes leaves no window focused
# even though windows are visible. In that state `yabai -m window --focus <dir>`
# has no reference window and silently does nothing. This wrapper first grabs a
# sensible window, then applies the requested direction.
#
#   focus.sh west|south|north|east   directional focus, recovering first if needed
#   focus.sh                         recover focus only (used by space/display signals)

dir=$1

focused=$(yabai -m query --windows --window 2>/dev/null | jq -r '.id // empty')

if [ -z "$focused" ]; then
  # nothing focused: take the top-left visible, non-minimised window on the
  # space that is now active
  focused=$(yabai -m query --windows --space 2>/dev/null \
    | jq -r 'map(select(.["is-visible"] and (.["is-minimized"] | not)))
             | sort_by(.frame.x, .frame.y) | .[0].id // empty')
  [ -n "$focused" ] && yabai -m window --focus "$focused"
fi

# a window is now focused (if the space had any) -- apply the direction
if [ -n "$dir" ] && [ -n "$focused" ]; then
  yabai -m window --focus "$dir"
fi

exit 0
