# Shortcut Integration for Neovim

This Neovim plugin integrates [Shortcut's](https://shortcut.com) [v3 REST API](https://developer.shortcut.com/api/rest/v3) with Neovim. No key mappings are configured by this plugin.

⚠️ You must have a `SHORTCUT_API_TOKEN` environment variable defined for this plugin to work.

Install this plugin as you do other Neovim plugins.

This plugin provides the following commands:

- `:ShortcutBranch`—Create a local Git branch using the naming convention found in Shortcut's story dialog: `<your-mention-name>/sc-<story-id>/<story-name>`
  - When invoked, this command provides a select list of Shortcut stories for you to pick from. These stories:
    - Are owned by the user affiliated with the `SHORTCUT_API_TOKEN`
    - Are in an unstarted or started state
    - Have been updated in the last 30 days

## License

Copyright 2025 Daniel Gregoire

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
