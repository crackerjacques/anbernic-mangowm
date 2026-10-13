# anbernic-mangowm

A [mango](https://github.com/mangowm/mango) Wayland desktop for Anbernic
handhelds, driven by the built-in gamepad and touchscreen - no keyboard
needed. The Raspberry Pi gets the same desktop, set up for a keyboard, a
mouse and touch.

| Device | SoC | Config |
| --- | --- | --- |
| RG DS | RK3568 | [anbernic-rg-ds](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-ds) |
| RG Vita Pro | RK3576 | [anbernic-rg-vita-pro](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-vita-pro) |
| RG Rotate | T618 | [anbernic-rg-rotate](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-rotate) |
| Raspberry Pi 4 / 400 / 5 / 500 / CM5 | BCM2711 / BCM2712 | [rpi](https://github.com/crackerjacques/mango-config/tree/rpi) |

Runs on Armbian with Ubuntu 26.04, or Debian forky (testing) / sid.
Debian 13 (trixie), and so Raspberry Pi OS, is too old for the wlroots mango
needs.

## Install

On the device, as your normal user (not root):

```bash
sudo apt install git
git clone https://github.com/crackerjacques/anbernic-mangowm
bash anbernic-mangowm/setup.sh
```

Pick your device (the one detected is the default), then the input method
and whether to log straight into mango. The setup then:

1. installs the packages it needs with apt
2. builds wlroots, scenefx, mango, foot, mangobar and a few tools from source
   into `/usr/local` (this takes a while)
3. puts the device's mango config in `~/.config/mango`
4. installs the device's helpers (gamepad keys, power menu, cheat sheet, ...)

The device's config is cloned into `anbernic-mangowm/<device>/` and the build
sources go in there too. At the end the setup offers to delete the sources;
once you are done with them, delete the whole `anbernic-mangowm` folder.

To re-run only some steps, pass them on, for example
`bash anbernic-mangowm/setup.sh foot extras`.
Steps: `deps wlroots scenefx mango foot extras rust config ime board autologin`.

## What you get

| | RG DS | RG Vita Pro | RG Rotate | Raspberry Pi |
| --- | :-: | :-: | :-: | :-: |
| Gamepad buttons drive the desktop | ✓ | ✓ | ✓ | |
| Cheat sheet of the controls (tap a row to run it) | R2 | R2 | R2 | Super + F1 |
| On-screen keyboard | ✓ | ✓ | ✓ | ✓ |
| Sticks as a mouse (pointer, scroll, clicks) with Stick Mouse settings | ✓ | ✓ | | |
| Game Mode: every button and stick back to games, hold HOME 2 s to return | ✓ | ✓ | | |
| Screenshot (SELECT + L1) and screen recording (SELECT + R1) | ✓ | ✓ | ✓ | area screenshot |
| Power menu, screen off until the next press | ✓ | ✓ | ✓ | ✓ |
| Desktop scale (and rotation on the Pi) | ✓ | ✓ | ✓ | ✓ |
| mangobar themes, shape and contents | ✓ | ✓ | ✓ | ✓ |
| Wallpaper, brightness, Wi-Fi / Bluetooth off (airplane mode) | ✓ | ✓ | ✓ | ✓ |
| Input method: Japanese, Chinese, Korean, Vietnamese (fcitx5) | ✓ | ✓ | ✓ | ✓ |
| Windows sent between the two screens, touch on each | ✓ | | | |
| Stick rings as a charging / battery light | | ✓ | | |
| Lid: nothing, screen off, sleep, or your own script | | | ✓ | |

## Controls and updates

On the device, the cheat sheet shows every control. The RG Vita Pro and
Raspberry Pi READMEs, linked in the table above, list them too.

To update later, pull the config, reinstall the helpers and reload mango.
This is for the RG Vita Pro; on the others the helper folder is `rgds`,
`rotate` or `rpi` instead of `vita`:

```bash
git -C ~/.config/mango pull
sudo sh ~/.config/mango/vita/install.sh
mmsg dispatch reload_config
```
