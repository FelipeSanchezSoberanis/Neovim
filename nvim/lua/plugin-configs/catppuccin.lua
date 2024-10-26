require("catppuccin").setup({
    flavor = "mocha",
    transparent_background = true,
    integrations = {treesitter = true, cmp = true}
});

vim.cmd.colorscheme("catppuccin")

