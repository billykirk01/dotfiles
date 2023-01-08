-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.o.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'

-- hard mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- move with ctrl + <left,right,up,down>
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')

-- Space as leader key
vim.g.mapleader = ';'

-- Shortcuts
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<leader>o', 'o<esc>k')
vim.keymap.set('n', '<leader>O', 'O<esc>j')

-- Snippets
vim.keymap.set({ 'n', 's' }, '<leader><tab>', '<cmd>lua require"luasnip".jump(1)<CR>')
vim.keymap.set({ 'n', 's' }, '<leader><s-tab>', '<cmd>lua require"luasnip".jump(-1)<CR>')
vim.keymap.set('s', '<leader>r', '<esc>viw"+p')

-- Move in windows, buffers, and tabs
vim.keymap.set('n', '<c-H>', '<c-w>h')
vim.keymap.set('t', '<c-H>', '<c-\\><c-n><c-w>h') -- move from terminal back to editor window
vim.keymap.set('n', '<c-L>', '<c-w>l')
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<leader>h', ':BufferLineMovePrev<CR>')
vim.keymap.set('n', '<leader>l', ':BufferLineMoveNext<CR>')
vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>')

-- escape terminal mode
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'x' }, '<leader>r', 'viw"+p')
vim.keymap.set('v', '<leader>r', '"+p')
vim.keymap.set({ 'v' }, '<leader>gr', 'y:%s@<c-r>"@@g|\'\'<left><left><left><left><left>')

-- Delete text
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')


-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = group,
    pattern = vim.fn.expand '$MYVIMRC',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'man' },
    group = group,
    command = 'nnoremap <buffer> q <cmd>quit<cr>'
})


-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing packer...')
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    vim.fn.system({ 'git', 'clone', '--depth', '1', packer_url, install_path })
    print('Done.')

    vim.cmd [[packadd packer.nvim]]
    install_plugins = true
end

require('packer').startup(function(use)
    -- Plugin manager
    use { 'wbthomason/packer.nvim' }

    -- Theming
    use { 'navarasu/onedark.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'akinsho/bufferline.nvim' }

    -- File explorer
    use { 'kyazdani42/nvim-tree.lua' }

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Git
    use { 'lewis6991/gitsigns.nvim' }
    use { 'tpope/vim-fugitive' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }


    -- Utilities
    use { 'akinsho/toggleterm.nvim' }
    use { 'numToStr/Comment.nvim' } -- "gc" to comment visual regions/lines
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'wellle/targets.vim' }
    use { 'moll/vim-bbye' }

    -- LSP support
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',

            -- handlebars support
            'mustache/vim-mustache-handlebars',
        },
    }

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip' },
    }
    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    if install_plugins then
        require('packer').sync()
    end
end)

if install_plugins then
    print '=================================='
    print '    Plugins will be installed.'
    print '    After you press Enter'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
require('onedark').setup {
    transparent = true
}
require('onedark').load()
vim.cmd('colorscheme onedark')


---
-- vim-bbye
---
vim.keymap.set('n', '<leader>q', '<cmd>Bdelete<CR>')


---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false

-- See :help lualine.txt
require('lualine').setup({
    options = {
        theme = 'onedark',
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
    },
})


---
-- bufferline
---
-- See :help bufferline-settings
require('bufferline').setup({
    options = {
        mode = 'buffers',
        offsets = {
            { filetype = 'NvimTree' }
        },
    },
    -- :help bufferline-highlights
    highlights = {
        buffer_selected = {
            italic = false
        },
        indicator_selected = {
            fg = { attribute = 'fg', highlight = 'Function' },
            italic = false
        }
    }
})


---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    -- :help nvim-treesitter-textobjects-modules
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            }
        },
    },
    ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'lua',
        'css',
        'json',
        'go',
        'rust',
        'python'
    },
})


---
-- Comment.nvim -- "gc" to comment visual regions/lines
---
require('Comment').setup({})


---
-- Indent-blankline
---
-- See :help indent-blankline-setup
require('indent_blankline').setup({
    char = '▏',
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = false
})


---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
    signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '➤' },
        topdelete = { text = '➤' },
        changedelete = { text = '▎' },
    }
})


---
-- Telescope
---
require('telescope').load_extension('fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = '[S]earch [R]ecent Files' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>s/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[S]earch string' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require('nvim-tree').setup({
    hijack_cursor = false,
    view = {
        adaptive_size = true
    },
    actions = {
        open_file = {
            quit_on_open = false
        }
    },
    on_attach = function(bufnr)
        local bufmap = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- :help nvim-tree.api
        local api = require('nvim-tree.api')

        bufmap('L', api.node.open.edit, 'Expand folder or go to file')
        bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
        bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
    end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')


---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.35
        end
    end,
    open_mapping = '<C-g>',
    direction = 'vertical',
    float_opts = {
        border = 'curved'
    },
    shade_terminals = false
})


---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = "./snippets" })


---
-- nvim-cmp (autocomplete)
---
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behavior = cmp.SelectBehavior.Select }

-- See :help cmp-config
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    -- See :help cmp-mapping
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ['<C-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
})


---
-- Mason.nvim
---
-- See :help mason-settings
require('mason').setup({
    ui = { border = 'rounded' }
})

-- See :help mason-lspconfig-settings
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'html',
        'cssls',
        'denols',
        'rust_analyzer',
        'gopls'
    }
})


---
-- LSP config
---
-- See :help lspconfig-global-defaults
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)


-- lspconfig.rust_analyzer.setup({})
--
-- lspconfig.denols.setup {
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json"),
--   init_options = {
--     lint = true,
--   },
-- }
--
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("package.json"),
--   init_options = {
--     lint = true,
--   },
-- }



---
-- Diagnostic customization
---
local sign = function(opts)
    -- See :help sign_define()
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- You can search each function in the help page.
        -- For example :help vim.lsp.buf.hover()

        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})


---
-- LSP servers
---
-- See :help mason-lspconfig-dynamic-server-setup
require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler 
        require("lspconfig")[server_name].setup {}
    end,
    -- ["denols"] = function()
    --     lspconfig.denols.setup({
    --         root_dir = lspconfig.util.root_pattern("deno.json"),
    --         init_options = {
    --             lint = true,
    --         },
    --     })
    -- end,
    ["tsserver"] = function()
        lspconfig.tsserver.setup({
            single_file_support = false
        })
    end,
})
