--[[
 return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end
}
]]

return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "moon", -- auto, main, moon, or dawn
    })

    vim.cmd("colorscheme rose-pine-moon")
  end,
}

--[[
return {
  "atmosuwiryo/vim-winteriscoming",
  config = function()
    vim.cmd("colorscheme WinterIsComing-dark-blue-color-theme")
  end,
}
]]
