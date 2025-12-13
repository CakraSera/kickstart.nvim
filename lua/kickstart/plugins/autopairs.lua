-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    ts_config = {
      javascript = { 'template_string' },
      typescript = { 'template_string' },
    },
    disable_filetype = { 'TelescopePrompt' },
    enable_check_bracket_line = false,
    fast_wrap = {},
  },
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    npairs.setup(opts)

    local cmp_status_ok, cmp = pcall(require, 'cmp')
    if cmp_status_ok then
      local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
      if cmp_autopairs_status_ok then
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end
  end,
}
