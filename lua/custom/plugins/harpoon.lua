-- Harpoon 2 — Quick file navigation
-- Harpoon allows you to quickly mark files and jump between them.
-- This is especially useful when working on a project with multiple files you frequently access.
--
-- Usage:
--  1. In a file you want to mark, press `<leader>a` to add it to Harpoon
--  2. Press `<C-e>` to view all your marked files in a quick menu
--  3. Use `<leader>1-4` to instantly jump to your first 4 marked files
--  4. Use `<leader>[` and `<leader>]` to cycle through marked files
--
-- See `:help harpoon` for more information

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: [A]dd file' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle menu' })

    -- Set up keymaps for quick access to files 1-4
    for i = 1, 4 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon: Go to file ' .. i })
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>[', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Previous' })
    vim.keymap.set('n', '<leader>]', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next' })
  end,
}
