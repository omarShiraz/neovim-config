return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "Cliffback/netcoredbg-macOS-arm64.nvim"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Function to find the default DLL path
      local function get_default_dll()
        local cwd = vim.fn.getcwd()
        -- Extract the directory name that matches the project
        local project_name = nil
        for _, file in ipairs(vim.fn.readdir(cwd)) do
          if file:match("%.csproj$") then
            project_name = file:gsub("%.csproj$", "")
            break
          end
        end

        if project_name then
          local dll_path = cwd .. "/bin/Debug/net8.0/" .. project_name .. ".dll"
          print("Checking DLL path: " .. dll_path)
          if vim.fn.filereadable(dll_path) == 1 then
            return dll_path
          else
            print("DLL not found at: " .. dll_path)
            return ""
          end
        else
          print("Project name could not be determined.")
          return ""
        end
      end

      -- Configuration for netcoredbg adapter
      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.expand('$HOME/local/netcoredbg'),  -- Adjust the path if different
        args = {'--interpreter=vscode', '--engineLogging=' .. vim.fn.expand('~/netcoredbg.log')}
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            local default_dll = get_default_dll()
            if default_dll ~= "" then
              return default_dll
            else
              return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
            end
          end,
        },
      }

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Key mappings for dap
      vim.api.nvim_set_keymap('n', '<C-d>', [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-S-d>', [[<Cmd>lua require'dap'.continue()<CR>]], { noremap = true, silent = true })
    end,
  }
}
