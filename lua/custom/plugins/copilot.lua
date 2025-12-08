-- GitHub Copilot — AI pair programmer
-- GitHub Copilot provides AI-powered code suggestions and completions directly in Neovim.
-- This configuration uses copilot.lua, a pure Lua implementation of GitHub Copilot.
--
-- Prerequisites:
--  1. You need a GitHub Copilot subscription (individual, business, or enterprise)
--  2. First time setup: After installation, run `:Copilot auth` to authenticate
--
-- Usage:
--  - Copilot will automatically provide suggestions as you type
--  - Use `<Tab>` to accept the entire suggestion
--  - Use `<M-]>` (Alt+]) to cycle to the next suggestion
--  - Use `<M-[>` (Alt+[) to cycle to the previous suggestion
--  - Use `<M-\>` (Alt+\) to explicitly request a suggestion
--  - Use `<C-]>` to dismiss the current suggestion
--  - Note: accept_word and accept_line can be configured to accept partial suggestions
--
-- Commands:
--  - `:Copilot auth` - Authenticate with GitHub Copilot
--  - `:Copilot status` - Check Copilot status
--  - `:Copilot panel` - Open Copilot solution panel with multiple suggestions
--
-- See https://github.com/zbirenbaum/copilot.lua for more information

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>', -- Alt+Enter
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    }
  end,
}
