-- plugins/autotag.lua
return {
  -- 5× faster, uses Tree-sitter, works perfectly in 2025
  {
    'altermo/ultimate-autotag.nvim',
    event = 'InsertEnter',
    opts = {
      extensions = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'astro', 'php', 'blade' },
    },
  },

  -- Optional but highly recommended: auto-close HTML/JSX tags on </
  {
    'windwp/nvim-ts-autotag',
    opts = {
      enable_close_on_slash = true, -- closes when you type </div>
    },
  },
}
