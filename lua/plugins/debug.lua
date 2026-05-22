-- Debugging stack for Go:
--   nvim-dap        : the debug adapter protocol client (the engine)
--   nvim-dap-ui     : UI with variables, watches, call stack, breakpoints
--   nvim-dap-go     : Go-specific glue (uses Delve, gives us debug_test())
--   nvim-nio        : async library required by dap-ui
--
-- Requires `delve` on PATH (mason installs it; see lsp.lua).

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue / start",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run last debug session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate debug session",
      },
      {
        "<leader>dus",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle debug UI",
      },
      -- Go-specific helpers (from nvim-dap-go)
      {
        "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug Go test under cursor",
        ft = "go",
      },
      {
        "<leader>dgl",
        function()
          require("dap-go").debug_last()
        end,
        desc = "Debug last Go test",
        ft = "go",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.5 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "watches", size = 0.1 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      require("dap-go").setup()

      -- Auto-open/close the debug UI when sessions start/end
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

      -- Breakpoint signs and colors
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ed8796" })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f5a97f" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#a6da95" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#363a4f" })
    end,
  },
}
