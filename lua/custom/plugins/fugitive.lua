-- Fugitive — Git power in Neovim
-- vim-fugitive is a Git wrapper so awesome, it should be illegal
-- https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { '<leader>gs', '<cmd>Git<cr>', desc = 'Git status' },
    { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git commit' },
    { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git push' },
    { '<leader>gl', '<cmd>Git log --oneline --decorate --graph<cr>', desc = 'Git log' },
    { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Git diff split' },
    { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git blame' },
  },
}
