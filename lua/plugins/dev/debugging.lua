-- plugins/dev/debugging.lua
-- Debugging with nvim-dap

return {
  {
    "mfussenegger/nvim-dap",
    ft = { "c", "cpp", "rust", "python", "javascript", "typescript" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      
      -- Virtual text
      require("nvim-dap-virtual-text").setup()
      
      -- C/C++ debugger configuration
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = 'codelldb',
          args = {"--port", "${port}"},
        }
      }
      
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }
      
      dap.configurations.c = {
        {
          name = "Launch (CodeLLDB)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
      
      dap.configurations.cpp = dap.configurations.c
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Debugging keybindings
      local keymap = vim.keymap
      keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Conditional Breakpoint" })
      keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
      keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
      keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
    end,
  },
}
