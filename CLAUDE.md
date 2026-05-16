# CLAUDE.md

This repo backs up dev-environment settings (shell, terminal, VS Code) so they can be shared across machines. It is not an application — there is no build, test, or run step.

## Working in this repo

- Treat files here as canonical config snapshots. Edits should reflect intentional changes the user wants mirrored to their machines.
- When adding a new tool's config, create a top-level directory named for the tool (e.g. `git/`, `tmux/`) and place the dotfiles inside.
- Never commit secrets. The `.gitignore` blocks common credential files — do not loosen those rules without explicit confirmation.
- System files (`.DS_Store`, `Thumbs.db`, editor swap files) must not be tracked. If one appears, remove it from the index.

## Attribution

Always add agent attribution to commits and PRs made in this repo. For commits, include a `Co-Authored-By:` trailer naming the Claude model (e.g. `Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>`). For PR descriptions, include the `🤖 Generated with [Claude Code](https://claude.com/claude-code)` footer.
