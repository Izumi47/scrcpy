# scrcpy CLI Options

A comprehensive reference for all `scrcpy` CLI options and shortcuts.

> This document mirrors the options exposed by `scrcpy 3.3.3` (see `scrcpy --help`). It groups related options for easier discovery and adds defaults and usage examples.

---

## Table of contents

- [scrcpy CLI Options](#scrcpy-cli-options)
  - [Table of contents](#table-of-contents)
  - [Usage](#usage)
  - [Quick cheat sheet ✅](#quick-cheat-sheet-)
  - [Table-driven reference 🔧](#table-driven-reference-)
    - [General](#general)
    - [Video](#video)
    - [Audio](#audio)
    - [Input \& devices](#input--devices)
    - [Network](#network)
    - [Recording \& display](#recording--display)
    - [Window \& UI](#window--ui)
  - [General options](#general-options)
  - [Video options](#video-options)
  - [Audio options](#audio-options)
  - [Camera options](#camera-options)
  - [Display \& orientation options](#display--orientation-options)
  - [Input \& control options](#input--control-options)
  - [Mouse / keyboard / gamepad options](#mouse--keyboard--gamepad-options)
  - [Recording](#recording)
  - [Virtual display](#virtual-display)
  - [Window \& UI options](#window--ui-options)
  - [Network / TCP/IP / Tunnel options](#network--tcpip--tunnel-options)
  - [Diagnostics \& Info](#diagnostics--info)
  - [Exit status](#exit-status)
  - [Shortcuts](#shortcuts)
  - [Environment variables](#environment-variables)
  - [Examples](#examples)
  - [Notes \& references](#notes--references)

---

## Usage

```
scrcpy [options]
```

When launching, `scrcpy` prints a short usage synopsis and supports many options to control video, audio, input devices, recording, and networking.

Refer to each option's description below for defaults and notes.

---

## Quick cheat sheet ✅

A short list of frequently-used commands and flags.

| Task | Command |
|---|---|
| Start mirroring (USB) | `scrcpy` |
| Start fullscreen | `scrcpy --fullscreen` or `scrcpy -f` |
| Limit resolution | `scrcpy -m 1024` |
| Set video bitrate | `scrcpy -b 2M` |
| Record to file | `scrcpy --record=screen.mp4` |
| Connect over TCP/IP | `scrcpy --tcpip` |
| Enable audio capture | `scrcpy --audio-source=output` |
| Start virtual display | `scrcpy --new-display=1920x1080/420` |
| Use HID keyboard | `scrcpy --keyboard=uhid` |

**Tip:** `MOD` refers to your shortcut modifier (left-Alt or left-Super); use the Shortcuts section for quick keys (e.g. `MOD+f` to toggle fullscreen).

---

## Table-driven reference 🔧

Below are concise tables grouping the most used options. For the full option details, see the sections below.

### General

| Option | Description | Default | Example |
|---|---|---:|---|
| `-h`, `--help` | Print help | — | `scrcpy -h` |
| `-V`, `--verbosity` | Set log level (`verbose`, `debug`, `info`, `warn`, `error`) | `info` | `scrcpy -V debug` |
| `--disable-screensaver` | Disable screensaver while running | — | `scrcpy --disable-screensaver` |
| `--pause-on-exit` | Pause terminal on exit (`true`/`false`/`if-error`) | `false` | `scrcpy --pause-on-exit=if-error` |

### Video

| Option | Description | Default | Example |
|---|---|---:|---|
| `-b, --video-bit-rate` | Video bit rate (e.g. `2M`) | `8M` | `scrcpy -b 2M` |
| `-m, --max-size` | Max width/height (px) | `0` (unlimited) | `scrcpy -m 1024` |
| `--video-codec` | Video codec (`h264`, `h265`, `av1`) | `h264` | `scrcpy --video-codec=h265` |
| `--max-fps` | Limit capture frame rate | — | `scrcpy --max-fps=30` |

### Audio

| Option | Description | Default | Example |
|---|---|---:|---|
| `--no-audio` | Disable audio forwarding | — | `scrcpy --no-audio` |
| `--audio-source` | Capture source (`output`, `mic`, ...) | `output` | `scrcpy --audio-source=mic` |
| `--audio-bit-rate` | Audio bitrate (`128K`, `256K`) | `128K` | `scrcpy --audio-bit-rate=256K` |
| `--audio-dup` | Duplicate capture on device (playback source) | — | `scrcpy --audio-source=playback --audio-dup` || `--lock-aspect` | Lock the window aspect ratio while resizing | `false` | `scrcpy --lock-aspect` |
### Input & devices

| Option | Description | Default | Example |
|---|---|---:|---|
| `-n, --no-control` | Read-only (no device control) | — | `scrcpy -n` |
| `--push-target` | Drag & drop target directory on device | `/sdcard/Download/` | `scrcpy --push-target=/sdcard/MyFiles/` |
| `--start-app` | Start an app by package name (`?` search, `+` force-stop) | — | `scrcpy --start-app=+?firefox` |

### Network

| Option | Description | Default | Example |
|---|---|---:|---|
| `--tcpip` | Configure & connect over TCP/IP | — | `scrcpy --tcpip` |
| `-p, --port` | Client listening port or range | `27183:27199` | `scrcpy -p 27190:27190` |
| `--tunnel-host` | Host for adb tunnel (implies forward) | `localhost` | `scrcpy --tunnel-host=10.0.0.2 --tunnel-port=8022` |

### Recording & display

| Option | Description | Default | Example |
|---|---|---:|---|
| `-r, --record` | Record screen to file | — | `scrcpy -r demo.mkv` |
| `--record-format` | Force recording container/format | — | `scrcpy --record-format=mkv` |
| `--new-display` | Create a virtual display (`WxH[/dpi]`) | — | `scrcpy --new-display=1280x720/240` |

### Window & UI

| Option | Description | Default | Example |
|---|---|---:|---|
| `-f, --fullscreen` | Start in fullscreen mode | — | `scrcpy -f` |
| `--window-borderless` | Disable window decorations | — | `scrcpy --window-borderless` |
| `--window-title` | Set a custom window title | — | `scrcpy --window-title="My Device"` |
| `--window-x`, `--window-y` | Set initial window position | `auto` | `scrcpy --window-x=100 --window-y=100` |
| `--window-width`, `--window-height` | Set initial window size | `0` (automatic) | `scrcpy --window-width=1280` |
| `--always-on-top` | Keep scrcpy window above others | — | `scrcpy --always-on-top` |
| `--lock-aspect` | Lock the window aspect ratio while resizing (enforce device aspect ratio) | `false` | `scrcpy --lock-aspect` |

> These tables cover the most commonly used options — the rest of this document contains the full, grouped reference.

---

## General options

- `-h`, `--help`
  - Print the help and exit.

- `-v`, `--version`
  - Print the `scrcpy` version and exit.

- `-V`, `--verbosity=value`
  - Set the log level: `verbose`, `debug`, `info`, `warn`, or `error`.
  - Default: `info`.

- `--disable-screensaver`
  - Disable the screensaver while `scrcpy` runs.

- `--pause-on-exit[=mode]`
  - Pause the terminal on exit. `mode` can be `true` (always pause), `false` (never), or `if-error` (pause only if an error occurred).
  - Passing the option without an argument is equivalent to `true`.
  - Default: `false`.

- `--print-fps`
  - Start an FPS counter and print framerate logs to the console. Can be toggled at runtime with `MOD+i`.

---

## Video options

- `-b, --video-bit-rate=value`
  - Encode the video at the given bit rate expressed in bits/s. Unit suffixes supported: `K` (x1000), `M` (x1000000).
  - Default: `8M` (8000000).

- `--video-codec=name`
  - Select a video codec: `h264`, `h265`, or `av1`.
  - Default: `h264`.

- `--video-encoder=name`
  - Force a specific MediaCodec video encoder (device dependent). Use with `--list-encoders` on device to list available encoders.

- `--video-codec-options=key[:type]=value[,...]`
  - Set codec-specific `MediaFormat` options where `type` may be `int`, `long`, `float`, or `string`.

- `--max-fps=value`
  - Limit the capture frame rate.

- `-m, --max-size=value`
  - Limit both width and height to `value` (keeps aspect ratio). Default: `0` (unlimited).

- `--no-video`
  - Disable video forwarding.

- `--no-video-playback`
  - Disable video playback on the computer (video frames are not rendered locally).

- `--render-driver=name`
  - Hint to SDL for the render driver (e.g. `direct3d`, `opengl`, `opengles2`, `opengles`, `metal`, `software`).

- `--no-mipmaps`
  - Disable automatic mipmap generation (which improves downscaling quality when enabled).

- `--video-buffer=ms`
  - Add buffering before displaying video frames (in milliseconds). Default: `0`.

- `--v4l2-sink=/dev/videoN` (Linux only)
  - Output to a V4L2 loopback device.

- `--v4l2-buffer=ms` (Linux only)
  - Buffering delay for the V4L2 sink. Default: `0`.

---

## Audio options

- `--no-audio`
  - Disable audio forwarding entirely.

- `--no-audio-playback`
  - Disable audio playback on the computer (audio still may be forwarded).

- `--audio-codec=name`
  - Choose audio codec: `opus`, `aac`, `flac`, or `raw`.
  - Default: `opus`.

- `--audio-encoder=name`
  - Force a specific MediaCodec audio encoder (device dependent).

- `--audio-codec-options=key[:type]=value[,...]`
  - Like video codec options but for audio encoder settings.

- `--audio-source=source`
  - Select audio capture source. Options include: `output`, `playback`, `mic`, `mic-unprocessed`, `mic-camcorder`, `mic-voice-recognition`, `mic-voice-communication`, `voice-call`, `voice-call-uplink`, `voice-call-downlink`, `voice-performance`.
  - Default: `output`.

- `--audio-bit-rate=value`
  - Encode audio at the given bit rate. Unit suffixes `K` and `M` supported.
  - Default: `128K` (128000).

- `--audio-buffer=ms`
  - Configure audio buffering delay (ms). Lower values reduce latency but increase underrun risk.
  - Default: `50`.

- `--audio-output-buffer=ms`
  - Size of SDL audio output buffer (ms). If playback sounds robotic, increase this value. Default: `5`.

- `--audio-dup`
  - Duplicate device audio (both capture and play on device). Only available when `--audio-source=playback`.

- `--require-audio`
  - Make `scrcpy` fail if audio is enabled but cannot be captured on the device.

---

## Camera options

- `--camera-id=id`
  - Mirror a specific device camera. Use `--list-cameras` to list available IDs.

- `--camera-size=<width>x<height>`
  - Explicit camera capture size.

- `--camera-fps=value`
  - Set camera capture frame rate.

- `--camera-ar=ar`
  - Select camera size by aspect ratio (`sensor`, `<num>:<den>` like `4:3`, or decimal like `1.6`).

- `--camera-facing=facing`
  - Choose camera by facing: `front`, `back`, or `external`.

- `--camera-high-speed`
  - Enable high-speed camera capture mode (restricted to specific resolutions & fps listed by `--list-camera-sizes`).

- `--list-cameras`
  - List device cameras.

- `--list-camera-sizes`
  - List valid camera capture sizes supported by the device.

---

## Display & orientation options

- `--display-id=id`
  - Mirror a specific device display. Use `--list-displays` to list IDs. Default: `0`.

- `--display-orientation=value`
  - Set initial display orientation. Values: `0`, `90`, `180`, `270`, `flip0`, `flip90`, `flip180`, `flip270`.
  - Default: `0`.

- `--capture-orientation=value`
  - Set capture orientation. Same values as `--display-orientation`. If prefixed with `@`, rotation is locked relative to natural orientation (for display capture). `@` alone locks to initial device orientation.
  - Default: `0`.

- `--orientation=value`
  - Same as `--display-orientation=value --record-orientation=value`.

- `--rotation/flip` shortcuts: several keyboard shortcuts exist to rotate/flip the displayed content at runtime.

---

## Input & control options

- `-n, --no-control`
  - Disable device control (read-only mirroring).

- `--no-key-repeat`
  - Do not forward repeated key events when a key is held down.

- `--no-mouse-hover`
  - Do not forward mouse hover events.

- `--no-power-on`
  - Do not power on the device screen on start.

- `--kill-adb-on-close`
  - Kill the `adb` process when `scrcpy` quits.

- `--legacy-paste`
  - Inject computer clipboard text via a sequence of key events on `Ctrl+v` (workaround for some devices that behave oddly when setting clipboard programmatically).

- `--raw-key-events`
  - Inject raw key events for all keys and ignore text events.

- `--push-target=path`
  - Set the directory used when dragging & dropping files to the device (passed to `adb push`). Default: `/sdcard/Download/`.

- `--start-app=name`
  - Start an app by exact package name. Prefix `?` to search by name (case-insensitive, may be slower). Prefix `+` to force-stop before starting. Both can be combined: `+?firefox`.

- `-S, --turn-screen-off`
  - Turn the device screen off immediately.

- `--screen-off-timeout=seconds`
  - Set the screen off timeout while `scrcpy` runs (the original value is restored on exit).

---

## Mouse / keyboard / gamepad options

- `--keyboard=mode`
  - Mode: `disabled`, `sdk`, `uhid`, `aoa`.
  - `sdk` uses Android system API for input. `uhid` simulates a physical HID keyboard using the device's UHID kernel module. `aoa` uses AOAv2 protocol (may work only over USB).
  - For `uhid` and `aoa`, keyboard layout must be configured on the device once.

- `--mouse=mode`
  - Mode: `disabled`, `sdk`, `uhid`, `aoa`.
  - In `uhid`/`aoa` modes, the computer mouse is captured as a relative input device. LAlt/LSuper/RSuper toggle mouse capture.

- `--gamepad=mode`
  - Mode: `disabled`, `uhid`, `aoa`.
  - `G` (upper-case) flag is a shortcut for `--gamepad=uhid` (or `--gamepad=aoa` when `--otg` is set).

- `--mouse-bind=xxxx[:xxxx]`
  - Configure secondary click bindings: sequences of 4 chars (right, middle, 4th, 5th clicks). Characters: `+` (forward), `-` (ignore), `b` (BACK), `h` (HOME), `s` (APP_SWITCH), `n` (expand notification). If second sequence is omitted, it duplicates the first. Default: `bhsn:++++` for SDK mouse, and `++++:bhsn` for AOA/UHID.

- `-K`
  - Shortcut: same as `--keyboard=uhid` (or `aoa` if `--otg` is set).

- `-M`
  - Shortcut: same as `--mouse=uhid` (or `aoa` if `--otg` is set).

- `-G`
  - Shortcut: same as `--gamepad=uhid` (or `aoa` if `--otg` is set).

- `--otg`
  - Run in OTG mode: simulate physical HID devices (keyboard/mouse/gamepad) as if connected via OTG cable. In OTG mode, `adb` is not necessary and mirroring is disabled.

---

## Recording

- `-r, --record=file.mp4`
  - Record device screen to a file. The format is inferred by `--record-format` or the file extension.

- `--record-format=format`
  - Force recording format: `mp4`, `mkv`, `m4a`, `mka`, `opus`, `aac`, `flac`, or `wav`.

- `--record-orientation=value`
  - Set the recorded orientation: `0`, `90`, `180`, or `270`. Default: `0`.

---

## Virtual display

- `--new-display[=[<width>x<height>][/<dpi>]]`
  - Create a new virtual display with optional resolution and DPI.
  - Examples: `--new-display=1920x1080`, `--new-display=1920x1080/420`, `--new-display` (defaults to main display size), `--new-display=/240` (main size, DPI 240).

- `--no-vd-destroy-content`
  - Disable `destroy content on removal` flag: when the virtual display is closed, running apps are moved to the main display instead of being destroyed.

- `--no-vd-system-decorations`
  - Disable system decorations for the virtual display.

---

## Window & UI options

- `-f, --fullscreen`
  - Start `scrcpy` in fullscreen mode.

- `--window-borderless`
  - Disable window decorations.

- `--window-title=text`
  - Set a custom window title.

- `--window-x=value`, `--window-y=value`
  - Set the initial window position. Defaults: `auto`.

- `--window-width=value`, `--window-height=value`
  - Set the initial window size. Default: `0` (automatic).

- `--always-on-top`
  - Keep the `scrcpy` window above other windows.

- `--lock-aspect`
  - Lock the window aspect ratio while resizing. When enabled, the window will keep the device/video aspect ratio and adjust one dimension automatically during user resizes. This allows resizing while ensuring the content is never distorted.

---

## Network / TCP/IP / Tunnel options

- `--tcpip[=[+]ip[:port]]`
  - Configure and connect the device over TCP/IP.
    - If `ip` is given, `scrcpy` connects to it directly.
    - If no destination is provided, `scrcpy` tries to find the IP of the current device (typically over USB), enables TCP/IP mode, and connects.
    - Prefix with `+` to force reconnection.
  - Default device TCP port: `5555`.

- `-p, --port=port[:port]`
  - Set the TCP port (range) used by the client to listen. Default: `27183:27199`.

- `--tunnel-host=ip`
  - IP address of an `adb` tunnel to reach the `scrcpy` server. This option implies `--force-adb-forward`. Default: `localhost`.

- `--tunnel-port=port`
  - TCP port of the `adb` tunnel to reach the server. Also implies `--force-adb-forward`. Default: `0` (not forced) — a local port will be chosen automatically.

- `--force-adb-forward`
  - Do not attempt to use `adb reverse`; instead use `adb forward`.

- `--tunnel-host` / `--tunnel-port` are primarily useful when an `adb` forwarding tunnel is required to connect to the remote server.

---

## Diagnostics & Info

- `--list-displays`
  - List displays available on the device.

- `--list-encoders`
  - List available video and audio encoders on the device.

- `--list-apps`
  - List installed Android apps on the device.

---

## Exit status

- `0` Normal program termination
- `1` Start failure
- `2` Device disconnected while running

---

## Shortcuts

By default, `MOD` is `left-Alt` or `left-Super` (configurable via `--shortcut-mod`).

- `MOD+f` — Switch fullscreen mode ✅
- `MOD+Left` / `MOD+Right` — Rotate display left/right ↩️
- `MOD+Shift+Left` / `MOD+Shift+Right` — Flip display horizontally ↔️
- `MOD+Shift+Up` / `MOD+Shift+Down` — Flip display vertically ↕️
- `MOD+z` — Pause/re-pause display ⏸️
- `MOD+Shift+z` — Unpause display ▶️
- `MOD+Shift+r` — Reset video capture/encoding
- `MOD+g` — Resize window to 1:1 (pixel-perfect)
- `MOD+w` or double-click on black borders — Remove black borders (fit)
- `MOD+h`, Middle-click — HOME
- `MOD+b` / `MOD+Backspace` / Right-click (screen on) — BACK
- `MOD+s` / 4th-click — APP_SWITCH
- `MOD+m` — MENU
- `MOD+Up` / `MOD+Down` — VOLUME_UP / VOLUME_DOWN
- `MOD+p` — POWER (toggle)
- Right-click (screen off) — Power on
- `MOD+o` — Turn device screen off (keep mirroring)
- `MOD+Shift+o` — Turn device screen on
- `MOD+r` — Rotate device screen
- `MOD+n` / 5th-click — Expand notification panel
- `MOD+Shift+n` — Collapse notification panel
- `MOD+c` — Copy to clipboard (Android >= 7)
- `MOD+x` — Cut to clipboard (Android >= 7)
- `MOD+v` — Copy computer clipboard to device and paste
- `MOD+Shift+v` — Inject computer clipboard text as key events
- `MOD+k` — Open keyboard settings (for HID keyboard only)
- `MOD+i` — Enable/disable FPS counter
- `Ctrl+click-and-move` — Pinch-to-zoom and rotate
- `Shift+click-and-move` — Tilt vertically (2-finger slide)
- `Ctrl+Shift+click-and-move` — Tilt horizontally (2-finger slide)
- Drag & drop APK — Install APK from computer
- Drag & drop non-APK — Push file to device (uses `--push-target`)

**Note:** `G`, `K`, `M` are short-form options for gamepad/keyboard/mouse UHID or AOAv2 (with `--otg` altering behavior).

---

## Environment variables

- `ADB`
  - Path to `adb` executable (if you want to override the bundled or system `adb`).

- `ANDROID_SERIAL`
  - The device serial to use if no selector is provided (`-s`, `-d`, `-e`, or `--tcpip`).

- `SCRCPY_ICON_PATH`
  - Path to the program icon used for the window.

- `SCRCPY_SERVER_PATH`
  - Path to the server binary (on device side) to use instead of the bundled server.

---

## Examples

- Mirror device over USB using 2M bit rate and max size 1024px:

```bash
scrcpy -b 2M -m 1024
```

- Start mirroring and record to `screen.mp4`:

```bash
scrcpy --record=screen.mp4
```

- Connect device over TCP (automatic detection and enable):

```bash
scrcpy --tcpip
```

- Force reconnection to `192.168.0.42:5555` and start fullscreen:

```bash
scrcpy --tcpip=+192.168.0.42:5555 --fullscreen
```

- Start mirroring with audio duplicated and a lower audio buffer:

```bash
scrcpy --audio-source=playback --audio-dup --audio-buffer=20
```

---

## Notes & references

- For device-specific encoders, camera sizes, displays and other hardware-dependent features, use the `--list-*` options.
- For HID (UHID/AOA) modes, some features require initial setup on the Android device (e.g., physical keyboard layout configuration).

---

If you'd like this added to the project README or expanded with a table of commonly used commands and recommended defaults, tell me where and I will add it.
