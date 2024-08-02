vim.keymap.set("n", " ", function() end)
vim.keymap.set("n", "<c-p>", ":GFilesCwd<CR>")
vim.keymap.set("n", "<c-b>", ":Buffers<CR>")
vim.keymap.set("n", "<leader>a<c-p>", ":Files<CR>")
vim.keymap.set("n", "<c-f>", ":Ag<CR>")
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "<leader>ww", function() vim.cmd([[set wrap!]]) end)
vim.keymap.set("v", "<leader>ss", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])
