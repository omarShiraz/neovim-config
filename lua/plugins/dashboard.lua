return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local db = require('dashboard')

    db.setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
        },
        project = { enable = true, limit = 8, icon = ' ', label = 'Recent Projects', action = 'Telescope find_files cwd=' },
        mru = { limit = 10, icon = ' ', label = 'Recent Files', cwd_only = false },
        footer = { 'Neovim Loaded', 'Enjoy Coding!' },
      }
    })

    -- Key mapping to open the dashboard
    vim.api.nvim_set_keymap('n', '<C-b>', ':Dashboard<CR>', { noremap = true, silent = true })
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}


