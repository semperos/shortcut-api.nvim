# Shortcut API Plugin for Neovim

⚠️ You must have a `SHORTCUT_API_TOKEN` environment variable defined for this plugin to work.

Install this plugin as you do other Neovim plugins.

Neovim commands this plugin provides:

- `:ShortcutBranch`—Create a local Git branch using the naming convention found in Shortcut's story dialog: `<your-mention-name>/sc-<story-id>/<story-name>`
  - When invoked, this queries Shortcut for stories that:
    - Are owned by the user affiliated with the `SHORTCUT_API_TOKEN`
    - Are in an unstarted or started state
    - Have been updated in the last 30 days
