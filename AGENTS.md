# Agents

ZMK config for a Corne (nice!nano v2, ZMK v0.3). Keymap lives in `config/corne.keymap`.

## Workflow

After any change:

1. Build locally (Docker must be running; `open -a Docker` on macOS):
   ```bash
   ./build.sh
   ```
   Firmware lands in `firmware/corne_left.uf2` and `firmware/corne_right.uf2` (gitignored). First run is slow; later runs reuse the `zmk-ws` Docker volume.
2. Fix any build errors before committing.
3. Commit with a short imperative message (e.g. `Make math layer right thumbs transparent`).
4. Push to `master`:
   ```bash
   git push origin master
   ```
   GitHub Actions rebuilds the firmware on push.
