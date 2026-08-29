# yabai setup on a new machine

Tiling + fixed spaces `s1..s10`, with `s6..s10` pinned to an external display.
Config: `.config/yabai/{yabairc,arrange-spaces.sh,focus.sh}`, `.config/skhd/skhdrc`.

Order matters. Settle permissions **before** anything touches Spaces, or the Dock
wedges (black wallpaper, frozen UI, dead Mission Control).

## Checklist

1. **Install** (use the fork — stock `koekeishiya/yabai` breaks the Dock on macOS 26):
   ```
   brew uninstall yabai 2>/dev/null; rm -f ~/Library/LaunchAgents/com.koekeishiya.yabai.plist
   brew install asmvik/formulae/yabai
   brew install koekeishiya/formulae/skhd jq
   ```

2. **macOS settings** — System Settings → Desktop & Dock → Mission Control:
   - "Displays have separate Spaces" → **ON** (log out to apply)
   - "Automatically rearrange Spaces based on most recent use" → **OFF**
   - Set an actual wallpaper.

3. **Accessibility** — `yabai --start-service`, grant Accessibility to **yabai and
   skhd** when prompted (System Settings → Privacy & Security → Accessibility),
   then `yabai --restart-service`.

4. **Verify safe mode** — focus/move windows with the keybinds. Works without the
   scripting addition. Do not proceed until this is fine.

5. **Partial SIP** — Recovery (shut down → hold power → Options → Terminal):
   ```
   csrutil enable --without fs --without debug --without nvram
   ```
   Reboot. `csrutil status` must show Filesystem / Debugging / NVRAM
   Protections = disabled. (Verified on 26.5.2 / 25F84.)

6. **Scripting addition**:
   ```
   make yabai-sa                    # writes /etc/sudoers.d/yabai with this binary's hash
   sudo yabai --load-sa; echo $?    # MUST be 0
   ```

7. **Prove space ops** before trusting the config:
   ```
   yabai --start-service && sleep 2
   n=$(yabai -m query --spaces | jq length); yabai -m space --create; sleep 1
   n2=$(yabai -m query --spaces | jq length); echo "$n -> $n2"   # must increment
   ```

8. **Wire it up**:
   ```
   make dotconfig
   yabai --restart-service && skhd --restart-service
   ```

## Notes

- Re-run `make yabai-sa` after every `brew upgrade yabai` (hash-pinned sudoers).
- Desktop Mac (no built-in panel): put the primary display's UUID in
  `~/.config/yabai/primary-uuid` (`yabai -m query --displays | jq -r '.[].uuid'`).
- If `arrange-spaces.sh` can't reach the scripting addition it labels spaces only
  and logs to `~/.cache/yabai/arrange.log` — it will not thrash the Dock.

## Recovery (black wallpaper / frozen Spaces)

```
yabai --stop-service
killall Dock
```
Still broken → log out and back in (rebuilds `com.apple.spaces.plist`), or reboot.
Cause is always space create/destroy/move without a working scripting addition.
