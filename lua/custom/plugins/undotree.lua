-- Undotree — Visualize undo history
-- The undo history visualizer for Neovim
-- https://github.com/mbbill/undotree

return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Undotree: Toggle' },
  },
}
