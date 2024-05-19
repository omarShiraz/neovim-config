return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Function to toggle Neo-tree
    local function toggle_neotree()
      -- Check if Neo-tree window is open
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft == "neo-tree" then
          vim.cmd(':Neotree close')
          return
        end
      end
      vim.cmd(':Neotree filesystem reveal left')
    end

    -- Set keymap for toggling Neo-tree
    vim.keymap.set('n', '<C-n>', toggle_neotree, { noremap = true, silent = true })

    -- Other key mappings
    vim.keymap.set('n', '<leader>bf', ':Neotree buffers reveal float<CR>', { noremap = true, silent = true })
  end,
}

