-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                              , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
    }

    use({
        'korken89/darkplus.nvim',
        as = 'darkplus',
        config = function()
            vim.cmd('colorscheme darkplus')
            -- vim.cmd([[highlight LspInlayHint guifg=#d8d8d8 guibg=#2a2a2a]])
            -- vim.cmd([[highlight Comment guifg=#6A9955]])
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    use 'ThePrimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-path' },
            { 'f3fora/cmp-spell' },
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }

    use {
        -- integrate with lualine
        'nvim-lualine/lualine.nvim',
    }
    use {
        'linrongbin16/lsp-progress.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
    }

    use 'lvimuser/lsp-inlayhints.nvim'
    use { 'korken89/nlsp-settings.nvim', branch = 'fix2' } -- Trying to fix the plugin...
    use 'saecki/crates.nvim'
end)
