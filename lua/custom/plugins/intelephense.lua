-- lua/custom/plugins/intelephense.lua
return {
  'neovim/nvim-lspconfig',
  ft = { 'php', 'phtml', 'inc', 'module', 'theme' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  config = function()
    local lspconfig = require 'lspconfig'
    local telescope_builtin = require 'telescope.builtin'

    lspconfig.intelephense.setup {
      -- Specify filetypes for Intelephense
      filetypes = { 'php', 'phtml', 'inc', 'module', 'theme' },
      
      settings = {
        intelephense = {
          stubs = {
            'apache',
            'bcmath',
            'bz2',
            'calendar',
            'composer',
            'curl',
            'Core',
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
            'random',
            'rdkafka',
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
            phpVersion = '8.3',
          },
          files = {
            maxSize = 5000000,
            associations = { '*.php', '*.phtml', '*.inc', '.php', '*.module', '*.theme' },
            exclude = {
              '**/.git/**',
              '**/.svn/**',
              '**/.hg/**',
              '**/CVS/**',
              '**/.DS_Store/**',
              '**/node_modules/**',
              '**/bower_components/**',
              '**/vendor/**/{Tests,tests}/**',
            },
          },
        },
      },
      on_attach = function(client, bufnr)
        -- Helper function for setting keymaps
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            noremap = true,
            silent = true,
            desc = desc,
          })
        end

        -- Standard LSP keybindings from kickstart
        map('n', 'gd', telescope_builtin.lsp_definitions, 'LSP: Go to Definition')
        map('n', 'gr', telescope_builtin.lsp_references, 'LSP: Go to References')
        map('n', 'gI', telescope_builtin.lsp_implementations, 'LSP: Go to Implementation')
        map('n', '<leader>D', telescope_builtin.lsp_type_definitions, 'LSP: Type Definition')
        map('n', '<leader>ds', telescope_builtin.lsp_document_symbols, 'LSP: Document Symbols')
        map('n', '<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, 'LSP: Workspace Symbols')
        map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
        map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to Declaration')

        -- PHP specific keybindings
        map('n', '<leader>lh', vim.lsp.buf.hover, 'PHP: Show Documentation')
        map('n', '<leader>li', vim.lsp.buf.implementation, 'PHP: Go to Implementation')
        map('n', '<leader>lr', vim.lsp.buf.references, 'PHP: Find References')
        map('n', '<leader>ls', vim.lsp.buf.signature_help, 'PHP: Show Signature')
        map('n', '<leader>lf', vim.lsp.buf.format, 'PHP: Format')
        map('n', '<leader>lo', '<cmd>Outline<cr>', 'PHP: Toggle Outline')
        map('n', '<leader>ln', vim.lsp.buf.rename, 'PHP: Rename Symbol')
        map('n', '<leader>la', vim.lsp.buf.code_action, 'PHP: Code Action')

        -- Document highlight on hover
        if client.supports_method 'textDocument/documentHighlight' then
          local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Print debug message
        print('Intelephense attached to buffer', bufnr)
      end,
    }
  end,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
