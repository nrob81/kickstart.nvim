return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  config = function()
    -- Get the lspconfig module
    local lspconfig = require 'lspconfig'

    -- Configure Intelephense
    lspconfig.intelephense.setup {
      settings = {
        intelephense = {
          stubs = {
            'apache',
            'bcmath',
            'bz2',
            'calendar',
            'composer',
            'curl',
            'date',
            'dba',
            'dom',
            'enchant',
            'fileinfo',
            'filter',
            'ftp',
            'gd',
            'gettext',
            'hash',
            'iconv',
            'imap',
            'intl',
            'json',
            'ldap',
            'libxml',
            'mbstring',
            'mcrypt',
            'mysql',
            'mysqli',
            'password',
            'pcntl',
            'pdo',
            'pgsql',
            'phar',
            'readline',
            'recode',
            'reflection',
            'session',
            'simplexml',
            'soap',
            'sockets',
            'sodium',
            'sqlite3',
            'standard',
            'superglobals',
            'symfony',
            'tidy',
            'tokenizer',
            'xml',
            'xmlreader',
            'xmlrpc',
            'xmlwriter',
            'xsl',
            'zip',
            'zlib',
          },
          environment = {
            phpVersion = '8.2',
          },
          files = {
            maxSize = 5000000,
          },
        },
      },
      on_attach = function(client, bufnr)
        -- Define keybindings when LSP attaches to a buffer
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'PHP: Show Documentation' }))

        vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'PHP: Go to Implementation' }))

        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'PHP: Find References' }))

        vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'PHP: Show Signature' }))

        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, vim.tbl_extend('force', opts, { desc = 'PHP: Format' }))

        vim.keymap.set('n', '<leader>lo', '<cmd>Outline<cr>', vim.tbl_extend('force', opts, { desc = 'PHP: Toggle Outline' }))

        vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'PHP: Rename Symbol' }))

        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'PHP: Code Action' }))

        -- Print a message when LSP attaches
        print('Intelephense attached to buffer', bufnr)
      end,
    }
  end,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
}
