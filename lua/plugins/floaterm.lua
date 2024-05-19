-- ~/.config/nvim/lua/plugins/floaterm.lua
return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_wintype = 'split'  -- Use a split window instead of floating
    vim.g.floaterm_position = 'bottom'  -- Position at the bottom
    vim.g.floaterm_height = 0.3  -- Set the height to 30% of the Neovim window
    vim.g.floaterm_keymap_toggle = '<C-t>'  -- Key mapping to toggle the terminal
    vim.g.floaterm_title = ''
    -- Custom key mappings
    vim.api.nvim_set_keymap('n', '<C-t>', ':FloatermToggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })
  end,
}

