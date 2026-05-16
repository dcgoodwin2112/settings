# SSH commit signing

Sign git commits with your existing SSH key so they show as **Verified** on GitHub. Reuses the key you already use for auth — no separate signing key needed.

## Prerequisites

- An ed25519 SSH key (e.g. `~/.ssh/id_ed25519`) already registered with GitHub as an **Authentication Key**.
- Your git `user.email` matches a verified email on your GitHub account. Without this, GitHub can't link the signature to your account and will show **Unverified**.

## 1. Register the key as a Signing Key on GitHub

The same SSH key has to be registered **twice** on GitHub — once for auth, once for signing. They're separate entries even though the key material is identical.

1. github.com → Settings → **SSH and GPG keys** → **New SSH key**
2. **Key type:** Signing Key
3. Paste the contents of your pubkey (e.g. `~/.ssh/id_ed25519.pub`)

## 2. Configure git

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.email "your-github-verified-email@example.com"
```

## 3. Load the key into the SSH agent (macOS Keychain)

Store the passphrase in the macOS Keychain so the agent unlocks the key automatically on every login — you type the passphrase once, ever.

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Add to `~/.ssh/config` so the agent pulls from Keychain on first use:

```
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
```

Verify the agent has the key:

```bash
ssh-add -l
```

## 4. Use SSH (not HTTPS) for the remote

HTTPS remotes prompt for username + token on every push. SSH remotes use the key silently.

For new clones, use the `git@github.com:...` URL. For existing repos:

```bash
git remote set-url origin git@github.com:<user>/<repo>.git
```

## 5. Verify it works

Make a commit, then check the raw object — a signed commit has a `gpgsig` block:

```bash
git cat-file commit HEAD | head
```

Push, then check the commit on github.com — it should show a green **Verified** badge.

## Optional: local signature verification

`git log --show-signature` needs an allowed signers file to verify SSH signatures locally. (GitHub's verification works without this — it's purely for your own machine.)

```bash
echo "your-email@example.com $(cat ~/.ssh/id_ed25519.pub)" > ~/.ssh/allowed_signers
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
```

## Troubleshooting

- **Push prompts for username/password** — remote is HTTPS, not SSH. See step 4.
- **Commit shows "Unverified" on GitHub** — most likely the pubkey isn't registered as a **Signing Key** (separate from Authentication Key). Re-check step 1.
- **Commit hangs on creation** — agent doesn't have the key. Run `ssh-add -l`; if empty, run `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`.
- **`No signature` from `git log --show-signature`** — either the commit really is unsigned (check `git cat-file commit <sha>` for a `gpgsig` line) or you just need the allowed signers file from the optional section above.
