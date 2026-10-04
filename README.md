# anbernic-mangowm

A [mango](https://github.com/mangowm/mango) Wayland desktop for Anbernic
handhelds, driven by the built-in gamepad and touchscreen - no keyboard
needed.

| Device | SoC | Config |
| --- | --- | --- |
| RG DS | RK3568 | [anbernic-rg-ds](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-ds) |
| RG Vita Pro | RK3576 | [anbernic-rg-vita-pro](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-vita-pro) |
| RG Rotate | T618 | [anbernic-rg-rotate](https://github.com/crackerjacques/mango-config/tree/anbernic-rg-rotate) |

Runs on Armbian with Ubuntu 26.04, or Debian forky (testing) / sid.
Debian 13 (trixie) is too old for the wlroots mango needs.

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

## Controls and updates

Each device's README, linked in the table above, lists its buttons and how to
update. On the device, R2 opens a cheat sheet of the controls.
