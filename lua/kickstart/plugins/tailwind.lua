-- plugins/tailwind.lua
return {
  -- Tailwind LSP extras + class sorting + hover preview + outline
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      document_color = { enabled = true }, -- <--- shows colors in the buffer
      conceal = { enabled = true, symbol = '󰔫' }, -- hides class quotes in JSX
    },
  },

  -- Shows actual Tailwind colors inside cmp menu and completion
  { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },

  -- Optional but amazing: sort classes with <leader>ct
  -- Already included in tailwind-tools.nvim above
}
