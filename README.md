# settings

Backup of dev-environment settings, kept in git so they can be shared across machines.

## Layout

- `terminal/` — shell and terminal emulator config
  - `.zshrc` — zsh shell config
  - `config.ghostty.txt` — Ghostty terminal config
- `vscode/` — VS Code config
  - `.vscode/settings.json`, `.vscode/extensions.json` — workspace settings and recommended extensions
  - `.devcontainer/devcontainer.json` — dev container definition

## Usage

Clone the repo, then symlink or copy individual files into the locations your tools expect (e.g. `~/.zshrc`, `~/.config/ghostty/config`, a project's `.vscode/`).

No automated install script — copy what you need.

## Setup docs

- [docs/ssh-signing.md](docs/ssh-signing.md) — sign git commits with your SSH key so they show Verified on GitHub
