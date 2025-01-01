return {
  'ray-x/lsp_signature.nvim',
  event = 'BufRead',
  config = function()
    require('lsp_signature').on_attach {
      bind = true,
      floating_window = true,
      hint_prefix = '🗨️',
    }
  end,
}
