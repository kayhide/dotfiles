#!/usr/bin/env sh
#
# Keep a fixed set of 10 labelled spaces (s1..s10) and pin them to displays:
#
#   1 display  : s1..s10  -> built-in
#   2+ displays: s1..s5   -> built-in
#                s6..s10  -> first external display
#
# Invoked from yabairc on load and from display_added / display_removed signals.
# macOS renumbers spaces whenever a display is (un)plugged; labels are stable, so
# all addressing here is by label, never by index.
#
# The "primary" display (the s1..s5 side) is detected at runtime:
#   1. $YABAI_PRIMARY_UUID env var, or a uuid in ~/.config/yabai/primary-uuid
#   2. a uuid cached from a previous run with only one display attached
#   3. system_profiler's internal panel (MacBooks), matched to yabai by display id
#   4. else fall back to arrangement index 1 (leftmost display)
# On a Mac with no built-in display, step 3 finds nothing; use step 1 or 2.

WANT=10                       # total number of managed spaces
SPLIT=5                       # s1..s5 stay on built-in, the rest go external

STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/yabai"
BUILTIN_FILE="$STATE_DIR/builtin-uuid"
mkdir -p "$STATE_DIR"

# macOS is still settling right after a display event.
sleep 1

ndisp=$(yabai -m query --displays | jq 'length')

# When the laptop is running solo, the sole display is by definition the
# built-in one; remember it for later multi-display runs.
if [ "$ndisp" -eq 1 ]; then
  yabai -m query --displays | jq -r '.[0].uuid' > "$BUILTIN_FILE"
fi

builtin_uuid() {
  override=${YABAI_PRIMARY_UUID:-$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/yabai/primary-uuid" 2>/dev/null)}
  if [ -n "$override" ]; then
    printf '%s\n' "$override"
    return
  fi

  cached=$(cat "$BUILTIN_FILE" 2>/dev/null)
  if [ -n "$cached" ] \
     && yabai -m query --displays | jq -e --arg u "$cached" 'any(.[]; .uuid == $u)' >/dev/null; then
    printf '%s\n' "$cached"
    return
  fi

  internal_id=$(system_profiler SPDisplaysDataType -json 2>/dev/null \
    | jq -r 'first(.SPDisplaysDataType[].spdisplays_ndrvs[]?
              | select(.spdisplays_connection_type == "spdisplays_internal")
              | ._spdisplays_displayID) // empty')
  if [ -n "$internal_id" ]; then
    uuid=$(yabai -m query --displays \
      | jq -r --arg id "$internal_id" 'first(.[] | select((.id | tostring) == $id) | .uuid) // empty')
    if [ -n "$uuid" ]; then
      printf '%s\n' "$uuid"
      return
    fi
  fi

  yabai -m query --displays | jq -r 'first(.[] | select(.index == 1) | .uuid)'
}

BUILTIN_UUID=$(builtin_uuid)

# --- 1. ensure at least $WANT spaces exist -----------------------------------
count() { yabai -m query --spaces | jq 'length'; }
while [ "$(count)" -lt "$WANT" ]; do
  yabai -m space --create || break
done

# --- 2. make sure labels s1..s10 all exist ---------------------------------
n=1
while [ "$n" -le "$WANT" ]; do
  if ! yabai -m query --spaces | jq -e --arg l "s$n" 'any(.[]; .label == $l)' >/dev/null; then
    target=$(yabai -m query --spaces | jq -r 'first(.[] | select(.label == "") | .index) // empty')
    [ -n "$target" ] && yabai -m space "$target" --label "s$n"
  fi
  n=$((n + 1))
done

# --- 3. resolve display arrangement indices --------------------------------
builtin_idx=$(yabai -m query --displays \
  | jq -r --arg u "$BUILTIN_UUID" 'first(.[] | select(.uuid == $u) | .index) // 1')
external_idx=$(yabai -m query --displays \
  | jq -r --arg u "$BUILTIN_UUID" 'first(.[] | select(.uuid != $u) | .index) // empty')

# move space $1 (label) to display $2 (index), unless it is already there
move() {
  cur=$(yabai -m query --spaces --space "$1" 2>/dev/null | jq -r '.display')
  [ "$cur" = "$2" ] && return 0
  yabai -m space "$1" --display "$2" 2>/dev/null || true
}

# --- 4. arrange --------------------------------------------------------------
if [ "$ndisp" -ge 2 ] && [ -n "$external_idx" ]; then
  # interleave so neither display is ever emptied mid-shuffle
  i=1
  while [ "$i" -le "$SPLIT" ]; do
    move "s$((SPLIT + i))" "$external_idx"
    move "s$i" "$builtin_idx"
    i=$((i + 1))
  done
else
  i=1
  while [ "$i" -le "$WANT" ]; do
    move "s$i" "$builtin_idx"
    i=$((i + 1))
  done
fi

# --- 5. drop surplus spaces macOS auto-created (one per new display) --------
while [ "$(count)" -gt "$WANT" ]; do
  surplus=$(yabai -m query --spaces \
    | jq -r 'first(.[] | select(.label == "") | select((.windows | length) == 0) | .index) // empty')
  [ -z "$surplus" ] && break
  yabai -m space --destroy "$surplus" 2>/dev/null || break
done
