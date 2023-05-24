local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'clangd',
    'bashls',
    'dockerls',
    'lua_ls',
    'tsserver',
    'rust_analyzer'
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    -- ["<C-Space>"] = cmp.mapping.complete(),
    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
})

-- cmp.setup({
--     sources = {
--         -- {
--         --     name = 'spell',
--         --     option = {
--         --         keep_all_entries = false,
--         --         enable_in_context = function()
--         --             return true
--         --         end,
--         --     },
--         -- },
--         { name = 'path' }
--     },
-- })

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = ' ',
        warn = ' ',
        hint = ' ',
        info = ' '
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- Diagnostic signs
local diagnostic_signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn",  text = " " },
    { name = "DiagnosticSignHint",  text = " " },
    { name = "DiagnosticSignInfo",  text = " " },
}

for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- Rust tools

--local rt = require("rust-tools")

--rt.setup({
-- server = {
--   on_attach = function(_, bufnr)
--     -- local opts = {buffer = bufnr, remap = false}

--     -- -- Hover actions
--     -- vim.keymap.set("n", "K", rt.hover_actions.hover_actions, opts)
--     -- -- Code action groups
--     -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, opts)

--     -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--   end,
-- },
--})

require('lspconfig').rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                allTargets = false,
                -- extraArgs = { "--bins" },
            },
        }
    }
})

require("nlspsettings").setup({
    local_settings_dir = ".nvim",
    local_settings_root_markers_fallback = { '.git', 'Cargo.toml' },
})
