-- GitHub Copilot Chat — Interactive AI chat in Neovim
-- This plugin provides an interactive chat interface for GitHub Copilot.
-- It allows you to have conversations with Copilot, ask questions about code,
-- and get help with coding tasks directly in Neovim.
--
-- Prerequisites:
--  1. You need a GitHub Copilot subscription (individual, business, or enterprise)
--  2. You need copilot.lua or copilot.vim already configured and authenticated
--  3. First time setup: Make sure `:Copilot auth` is complete
--
-- Usage:
--  - `<leader>cc` - Open Copilot Chat with a question
--  - `<leader>ce` - Explain the selected code
--  - `<leader>cr` - Review the selected code
--  - `<leader>cf` - Fix the selected code
--  - `<leader>co` - Optimize the selected code
--  - `<leader>cd` - Generate documentation for the selected code
--  - `<leader>ct` - Generate tests for the selected code
--  - `<leader>cq` - Quick chat with selected code as context
--
-- Commands:
--  - `:CopilotChat` - Open chat interface
--  - `:CopilotChatExplain` - Explain selected code
--  - `:CopilotChatReview` - Review selected code
--  - `:CopilotChatFix` - Fix issues in selected code
--  - `:CopilotChatOptimize` - Optimize selected code
--  - `:CopilotChatDocs` - Generate documentation
--  - `:CopilotChatTests` - Generate tests
--  - `:CopilotChatToggle` - Toggle chat window
--
-- See https://github.com/CopilotC-Nvim/CopilotChat.nvim for more information

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or 'github/copilot.vim'
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    -- See Configuration section for options
    model = 'gpt-4o', -- Default model to use
    auto_follow_cursor = true, -- Auto-scroll to the latest message
    show_help = true, -- Show help actions
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
      height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
    },
    mappings = {
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = '<C-l>',
        insert = '<C-l>',
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-s>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
    },
  },
  keys = {
    -- Chat keymaps
    {
      '<leader>cc',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end,
      desc = '[C]opilot [C]hat',
    },
    {
      '<leader>cq',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').visual })
        end
      end,
      mode = 'v',
      desc = '[C]opilot [Q]uick Chat (Visual)',
    },
    -- Prompt keymaps
    { '<leader>ce', '<cmd>CopilotChatExplain<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [E]xplain' },
    { '<leader>cr', '<cmd>CopilotChatReview<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [R]eview' },
    { '<leader>cf', '<cmd>CopilotChatFix<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [F]ix' },
    { '<leader>co', '<cmd>CopilotChatOptimize<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [O]ptimize' },
    { '<leader>cd', '<cmd>CopilotChatDocs<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [D]ocs' },
    { '<leader>ct', '<cmd>CopilotChatTests<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [T]ests' },
    -- Toggle chat window
    { '<leader>cv', '<cmd>CopilotChatToggle<cr>', desc = '[C]opilot Chat Toggle' },
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'
    chat.setup(opts)

    -- Create user command to quickly select prompts with Telescope
    vim.api.nvim_create_user_command('CopilotChatPrompts', function()
      local actions = require 'CopilotChat.actions'
      local prompts = actions.prompt_actions()
      if prompts then
        -- Try to use Telescope if available
        local ok, telescope = pcall(require, 'telescope')
        if ok then
          require('CopilotChat.integrations.telescope').pick(prompts)
        else
          -- Fallback to vim.ui.select
          vim.ui.select(vim.tbl_keys(prompts), {
            prompt = 'Copilot Chat Prompts:',
          }, function(selected)
            if selected then
              prompts[selected]()
            end
          end)
        end
      end
    end, {})

    -- Optional: Add keymap for prompts picker
    vim.keymap.set({ 'n', 'v' }, '<leader>cp', '<cmd>CopilotChatPrompts<cr>', { desc = '[C]opilot [P]rompts' })
  end,
}
