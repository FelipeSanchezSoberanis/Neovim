local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    ui = {border = "rounded"},
    spec = {
        {"neovim/nvim-lspconfig"}, --
        {"hrsh7th/cmp-nvim-lsp"}, --
        {"hrsh7th/cmp-buffer"}, --
        {"hrsh7th/cmp-path"}, --
        {"hrsh7th/cmp-cmdline"}, --
        {"hrsh7th/nvim-cmp"}, --
        {"SirVer/ultisnips"}, --
        {"honza/vim-snippets"}, --
        {"quangnguyen30192/cmp-nvim-ultisnips"}, --
        {"b0o/schemastore.nvim"}, --
        {"nvim-treesitter/nvim-treesitter"}, --
        {"nvim-treesitter/nvim-treesitter-context"}, --
        {"windwp/nvim-autopairs", event = "InsertEnter", config = true}, --
        {"junegunn/fzf"}, -- ,
        {"junegunn/fzf.vim"}, -- ,
        {"preservim/nerdtree"}, -- ,
        {"ryanoasis/vim-devicons"}, -- ,
        {"lewis6991/gitsigns.nvim"}, -- ,
        {"catppuccin/nvim", name = "catppuccin", priority = 1000}, --
        {"vim-airline/vim-airline"}, --
        {"tpope/vim-surround"}, --
        {"tpope/vim-fugitive"}, --
        {"mfussenegger/nvim-jdtls"} --
    },
    checker = {enabled = true}
})

