local gitsigns = require("gitsigns")

vim.keymap.set("n", " ", function() end)
vim.keymap.set("n", "<c-p>", ":Files<CR>")
vim.keymap.set("n", "<c-b>", ":Buffers<CR>")
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
vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
        vim.cmd.normal({"]c", bang = true})
    else
        gitsigns.nav_hunk("next")
    end
end)
vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
        vim.cmd.normal({"[c", bang = true})
    else
        gitsigns.nav_hunk("prev")
    end
end)
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
vim.keymap.set("v", "<leader>hs",
               function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set("v", "<leader>hr",
               function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line {full = true} end)
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)
vim.keymap.set("n", "<leader>hD", function() gitsigns.diffthis("~") end)
vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted)
vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
