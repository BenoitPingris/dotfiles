local nvim_lsp = require('lspconfig')
local k = require "astronauta.keymap"

local nnoremap = k.nnoremap
local inoremap = k.inoremap
local snoremap = k.snoremap

local on_attach = function(_client, bufnr)
    print("lsp enabled")
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    nnoremap{'gD', ':lua vim.lsp.buf.declaration()<CR>'}
    nnoremap{'gd', ':lua vim.lsp.buf.definition()<CR>'}
    nnoremap{'gh', ':lua vim.lsp.buf.hover()<CR>'}
    nnoremap{'gi', ':lua vim.lsp.buf.implementation()<CR>'}
    nnoremap{'gn', ':lua vim.lsp.buf.rename()<CR>'}
    nnoremap{'gr', ':lua vim.lsp.buf.references()<CR>'}
    nnoremap{'<C-k>', ':lua vim.lsp.buf.signature_help()<CR>'}
    nnoremap{'<leader>D', ':lua vim.lsp.buf.type_definition()<CR>'}
    nnoremap{'<leader>a', ':lua vim.lsp.buf.code_action()<CR>'}
    nnoremap{'<leader>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'}
    nnoremap{'d[', ':lua vim.lsp.diagnostic.goto_prev()<CR>'}
    nnoremap{'d]', ':lua vim.lsp.diagnostic.goto_next()<CR>'}
end

local servers = {'pyright', 'tsserver', 'rust_analyzer', 'gopls', 'svelte'}

for _, server in ipairs(servers) do
    nvim_lsp[server].setup { on_attach=on_attach }
end

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Compe setup
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = false;
        calc = true;
        vsnip = false;
        nvim_lsp = true;
        nvim_lua = true;
        spell = true;
        tags = false;
        snippets_nvim = true;
        treesitter = true;
    };
}

vim.api.nvim_set_keymap("i", "<C-space>", "compe#complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<Tab>", "compe#confirm('<Tab>')", {expr = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", {expr = true})


function goimports(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

vim.cmd("autocmd BufWritePre *.go lua goimports(1000)")

require("flutter-tools").setup{
    lsp = {
        on_attach=on_attach
    }
}
