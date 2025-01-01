return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- First, we initialize dap-ui with our preferred settings
    dapui.setup {
      -- This controls the UI configuration
      -- Setting auto_open to true means the UI will open automatically when debugging starts
      icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
      mappings = {
        -- Feel free to adjust these mappings to your preferences
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      element_mappings = {},
      expand_lines = false,
      force_buffers = true,
      controls = {
        enabled = vim.fn.exists '+winbar' == 1,
        element = 'repl',
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
          disconnect = '',
        },
      },
      layouts = {
        {
          -- You can customize the layout positioning and sizes
          elements = {
            -- Elements can be strings or table with id and size keys
            { id = 'scopes', size = 0.25 },
            'breakpoints',
            'stacks',
            'watches',
          },
          size = 40, -- 40 columns
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 0.25, -- 25% of total lines
          position = 'bottom',
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        indent = 4,
        max_type_length = nil,
        max_value_lines = 100,
      },
    }

    -- Now we set up listeners to automatically open and close the UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Keymappings matching your LunarVim config
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', function()
      dap.disconnect { terminateDebuggee = true }
    end, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<F7>', dapui.close, { desc = 'Debug: Close UI' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })

    -- PHP Debug Adapter configuration
    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        hostname = '172.17.0.1',
        port = 9003,
        serverSourceRoot = '/var/www/html',
        localSourceRoot = vim.fn.getcwd(),
      },
    }
  end,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
  },
}
