local node_modules = os.getenv("NODE_HOME") .. "/lib/node_modules"

local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

cmp.setup({
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping(function() cmp.select_next_item() end, {"i", "s"}),
        ["<C-k>"] = cmp.mapping(function() cmp.select_prev_item() end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4)

    }),
    sources = cmp.config.sources({
        {name = "nvim_lsp"} --
        -- {name = "ultisnips"} --
    }, {
        {name = "buffer"} --

    })
})

cmp.setup.cmdline({"/", "?"},
                  {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})

local servers = {
    "pyright", "lua_ls", "cssls", "html", "jsonls", "bashls", "dockerls", "lemminx", "eslint",
    "texlab", "arduino_language_server", "rust_analyzer", "clangd", "phpactor",
    "kotlin_language_server", "angularls", "emmet_ls", "yamlls", "groovyls", "ts_ls", "volar"
}
for _, server in ipairs(servers) do
    local setup = {capabilities = capabilities}

    if server == "ts_ls" then
        setup.init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = node_modules .. "/@vue/typescript-plugin",
                    languages = {"javascript", "typescript", "vue"}
                }
            }
        }
        setup.filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
            "typescript.tsx", "vue"
        }
    elseif server == "emmet_ls" then
        setup.filetypes = {
            "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass",
            "svelte", "typescriptreact", "vue", "htmlangular"
        }
    elseif server == "jsonls" then
        setup.settings = {
            json = {schemas = require("schemastore").json.schemas(), validate = {enable = true}}
        }
    elseif server == "volar" then
        setup.init_options = {typescript = {tsdk = node_modules .. "/typescript/lib"}}
    elseif server == "angularls" then
        local cmd = {
            "ngserver", "--stdio", "--tsProbeLocations", node_modules, "--ngProbeLocations",
            node_modules
        }
        setup.cmd = cmd
        setup.on_new_config = function(new_config) new_config.cmd = cmd end
    elseif server == "groovyls" then
        setup.cmd = {
            "java", "-jar",
            "/home/felipe/Documents/groovy-language-server/build/libs/groovy-language-server-all.jar"
        }
    end

    lspconfig[server].setup(setup)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = true})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = true})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = true})
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = true})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {buffer = true})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = true})
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer = true})
        vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {buffer = true})
    end
})
