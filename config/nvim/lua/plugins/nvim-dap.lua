local load = require

local module = {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "nicholasmata/nvim-dap-cs",
    },
    config = function()
      local dap = load("dap")
      local dapui = load("dapui")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "/home/vbox/.vscode-server/extensions/vadimcn.vscode-lldb-1.11.4/adapter/codelldb",
          args = { "--port", "${port}" },
        }
      }
      dap.configurations.zig = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        }
      }
      load("dap-cs").setup({
        netcoredbg = {
          path = "/home/vbox/.local/opt/netcoredbg/netcoredbg",
        }
      })

      dapui.setup()

      -- vim.keymap.set("n", "<leader>duo", dapui.open, {})
      -- vim.keymap.set("n", "<leader>duc", dapui.close, {})
      vim.keymap.set("n", "<leader>dt", dapui.toggle, {})

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<leader>dc", dap.continue, {})
      -- vim.keymap.set("n", "<leader>dso", dap.step_over, {})
      -- vim.keymap.set("n", "<leader>dsi", dap.step_into, {})

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
}

return module
