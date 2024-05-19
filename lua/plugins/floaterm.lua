return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_wintype = "split"     -- Use a split window instead of floating
    vim.g.floaterm_position = "bottom"   -- Position at the bottom
    vim.g.floaterm_height = 0.3          -- Set the height to 30% of the Neovim window
    vim.g.floaterm_keymap_toggle = "<C-t>" -- Key mapping to toggle the terminal
    vim.g.floaterm_title = ""

    -- Custom key mappings
    vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })

    -- Key mappings to build and run C# projects using zsh
    -- Build: keep terminal open only if the build fails
    vim.api.nvim_set_keymap(
      "n",
      "<leader>cb",
      ":FloatermNew --height=0.3 --position=bottom --wintype=split zsh -c 'dotnet build || { echo; echo Build failed; read; }'<CR>",
      { noremap = true, silent = true }
    )

    -- Run: always keep the terminal open after running
    vim.api.nvim_set_keymap(
      "n",
      "<leader>cr",
      ":FloatermNew --height=0.3 --position=bottom --wintype=split zsh -c 'dotnet run; read'<CR>",
      { noremap = true, silent = true }
    )
  end,
}
