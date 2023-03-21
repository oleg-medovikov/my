vim.cmd([[packadd packer.nvim]])
require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("morhetz/gruvbox")
  vim.cmd([[colorscheme gruvbox]])
  use("nvim-treesitter/nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "python" },
    highlight = {
      enable = false,
    },
  })
  use("nvim-lualine/lualine.nvim")
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "ayu_dark",
    },
  })

-- Замена fzf и ack
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require'telescope'.setup {} end, }
-- Даже если включена русская раскладка vim команды будут работать
  use("powerman/vim-plugin-ruscmd")
-- Переводчик рус - англ
  use("skanehira/translate.vim")
-- popup окошки
  use ("nvim-lua/popup.nvim")
-- Collection of configurations for built-in LSP client
  use ("neovim/nvim-lspconfig")
  use ("williamboman/nvim-lsp-installer")
-- Автодополнялка
  use ("hrsh7th/nvim-cmp")
  use ("hrsh7th/cmp-nvim-lsp")
  use ("hrsh7th/cmp-buffer")
  use ("saadparwaiz1/cmp_luasnip")
-- Автодополнлялка к файловой системе
  use ("hrsh7th/cmp-path")
-- Snippets plugin
  use ("L3MON4D3/LuaSnip")
  
-- Файловый менеджер
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, }
end)


local opt = vim.opt
----------для nerdtree-------------
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

--  setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "U", action = "dir_down" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-----------------------------------------------------------
-- LSP settings
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then
        -- only apply these settings for the "sumneko_lua" server
        opts.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the 'vim', 'use' global
                    globals = {'vim', 'use', 'pylint'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    end
    server:setup(opts)
end)


-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', options = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end
        },
    },
},
}
  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
}

----------для переводчика----------
-- Направление перевода с русского на английский
vim.g.translate_source = 'en'
vim.g.translate_target = 'ru'
vim.translate_popup_window = 1
-----------------------------------
opt.list = true
opt.number = true
opt.listchars:append("tab:> ")
opt.shiftwidth = 4
opt.expandtab = true
opt.cursorline = true
opt.cursorcolumn = false
opt.swapfile = false
opt.wrap = false
opt.spell = true
opt.spelllang= { 'en_us', 'ru_yo' }
opt.so=999                          -- Курсор всегда в центре экрана
opt.undofile = true                 -- Возможность отката назад
opt.splitright = true               -- vertical split вправо
opt.splitbelow = true               -- horizontal split вниз
opt.termguicolors = true            --  24-bit RGB colors


-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает, где nvim в последний раз редактировал файл
vim.cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает скопированную часть текста на долю секунды
vim.api.nvim_exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup end
]], false)
-----------------------------------------------------------
-- don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-----------------------------------------------------------



-- Map global leader from \ to Space
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
-- save file
map("i", "ii", "<Esc>:w<Enter>", { noremap = true })
map("i", "шш", "<Esc>:w<Enter>", { noremap = true })
-- дерево файлов.
map('n', '<C-f>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>', { noremap = true})
-- fzf
map('n', '<leader><leader>', ':Telescope find_files<CR>', { noremap = true })

map('n', '<C-t>', ':tabnew<cr>', { noremap = true})
map('n', '<C-l>', ':tabnext<cr>', { noremap = true})
map('n', '<C-h>', ':tablast<cr>', { noremap = true})
-- Persist undo tree across neovim sessions
vim.opt.undofile = true
