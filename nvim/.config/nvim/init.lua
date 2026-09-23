-- =============================================================================
-- 1. General Options
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Appearance & Colors
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.ruler = true
opt.showcmd = true
opt.title = true
opt.colorcolumn = "80"
opt.numberwidth = 5
opt.laststatus = 2

-- Line Numbers (Hybrid relative numbering)
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false -- vim default
opt.showmatch = true

-- Navigation & Scrolling
opt.scrolloff = 3
opt.mouse = "a"
opt.tabpagemax = 100
opt.backspace = { "indent", "eol", "start" }

-- Search
opt.hlsearch = true
opt.incsearch = true

-- Encoding & Clipboard
opt.encoding = "utf-8"
opt.clipboard = "unnamedplus" -- Replaces custom xclip visual mapping

-- Spell & Error formatting
opt.errorformat:append("remote: %f:%l:%c:%m")
opt.spellfile = vim.fn.expand("~/.vim/spell/en.utf-8.add")

-- Global Path Variables
vim.env.notes_path = vim.fn.expand("~/obsidian/main")
vim.env.todotxt_todo_path = vim.fn.expand("~/todo.txt/todo.txt")
vim.env.todotxt_done_path = vim.fn.expand("~/todo.txt/done.txt")

-- =============================================================================
-- 2. Custom Functions & Helper Commands
-- =============================================================================
local map = vim.keymap.set

-- Toggle Invisible Characters (F7)
local invisible_state = false
function _G.ToggleInvisible()
  invisible_state = not invisible_state
  if invisible_state then
    vim.opt.listchars = { tab = "▸ ", trail = "·", eol = "¬", nbsp = "_" }
    vim.opt.list = true
  else
    vim.opt.listchars = {}
    vim.opt.list = false
  end
end

-- Dictionary word info lookup (F6)
function _G.ShowInfo()
  local word = vim.fn.expand("<cword>")
  local dict_path = vim.fn.expand("~/dict")
  if vim.fn.filereadable(dict_path) == 1 then
    local handle = io.popen(string.format('grep "^%s " %s | cut -d\' \' -f2-', word, dict_path))
    if handle then
      local result = handle:read("*a"):gsub("%s+$", "")
      handle:close()
      print(word .. ": " .. result)
    end
  else
    print("Dictionary ~/dict not found.")
  end
end

-- GNU Coding Standards indentation helper
function _G.GnuIndent()
  local bopt = vim.opt_local
  bopt.cindent = true
  bopt.cinoptions = ">4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1"
  bopt.expandtab = true
  bopt.shiftwidth = 2
  bopt.tabstop = 8
  bopt.softtabstop = 2
  bopt.textwidth = 80
  bopt.formatoptions:remove({ "r", "o" })
  bopt.formatoptions:append({ "c", "q", "l" })
end

-- Sudo save command (:w!!)
vim.api.nvim_create_user_command("SudoWrite", function()
  vim.cmd("w !sudo tee % > /dev/null")
end, {})
vim.cmd("cmap w!! SudoWrite<CR>")

-- =============================================================================
-- 3. Keymaps
-- =============================================================================
map("n", "<F2>", "gg=G", { desc = "Re-indent file" })
map("n", "<F3>", "<cmd>setlocal foldmethod=syntax<CR>", { desc = "Syntax fold" })
map("n", "<F5>", "<cmd>make<CR><CR>", { desc = "Run make" })
map("n", "<F6>", "<cmd>lua ShowInfo()<CR>", { desc = "Dictionary word info" })
map("n", "<F7>", "<cmd>lua ToggleInvisible()<CR>", { desc = "Toggle whitespace" })

map("n", "<leader>t", ":tabe " .. vim.env.todotxt_todo_path .. "<CR>", { desc = "Open Todo.txt" })
map("n", "<leader>T", ":tabe " .. vim.env.todotxt_done_path .. "<CR>", { desc = "Open Done.txt" })
map("n", "<leader>l", "<cmd>tabe ~/money/ledger/inbox.ledger<CR>", { desc = "Open Ledger" })

-- Tag jump splits
map("n", "<C-\\>", "<cmd>tab split | exec 'tag ' . expand('<cword>')<CR>")
map("n", "<A-]>", "<cmd>vsp | exec 'tag ' . expand('<cword>')<CR>")

-- =============================================================================
-- 4. Autocommands & Filetype Configurations
-- =============================================================================
local augroup = vim.api.nvim_create_augroup("UserConfigs", { clear = true })

-- Relative numbering in Normal, absolute in Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup,
  callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function() vim.opt.relativenumber = true end,
})

-- Spell checking for specific file types
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "debchangelog" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
  end,
})

-- Python indentation
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    local bopt = vim.opt_local
    bopt.expandtab = true
    bopt.tabstop = 4
    bopt.shiftwidth = 4
  end,
})

-- Format JSON with python
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "json",
  callback = function()
    map("n", "<F2>", ":%!python3 -m json.tool<CR>", { buffer = true, silent = true })
  end,
})

-- Read-only review buffers
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "diff", "logreview" },
  callback = function() vim.opt_local.modifiable = false end,
})

-- Custom Filetypes & Syntax matching
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.rasi",
  callback = function() vim.opt_local.filetype = "css" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = { "CVE-[0-9][0-9][0-9][0-9]-[0-9N]*", "00boilerplate.*" },
  callback = function() vim.opt_local.syntax = "cve" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "/tmp/check-cves.*",
  callback = function() vim.opt_local.syntax = "check_cves" end,
})

-- Build system overrides
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*/charmcraft.yaml",
  callback = function() vim.opt_local.makeprg = "charmcraft pack -p ./charm" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = vim.fn.expand("~/ubuntu/packages/*"),
  callback = function() vim.opt_local.makeprg = "umt build -f" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = vim.fn.expand("~/.Xresources"),
  callback = function() vim.opt_local.makeprg = "xrdb ~/.Xresources" end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*/linux*/**/*.{c,h}",
  callback = function() vim.opt_local.makeprg = "time make -j20 all" end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*/grub*/**/*.{c,h}",
  callback = function() GnuIndent() end,
})

-- Fallback makeprg definitions based on project directory
if vim.fn.filereadable("Makefile") == 0 then
  vim.opt.makeprg = "gcc -Wall -Wextra -ggdb -o %< %"
end
if vim.fn.filereadable(".make") == 1 then
  vim.opt.makeprg = "./.make"
end
if vim.fn.filereadable(".config/i3/config") == 1 then
  vim.opt.makeprg = "i3-msg restart"
end

-- Skeleton templates
vim.api.nvim_create_autocmd("BufNewFile", {
  group = augroup,
  pattern = "*.*",
  callback = function()
    local ext = vim.fn.expand("<afile>:e")
    local skeleton = vim.fn.expand("~/.vim/templates/skeleton." .. ext)
    if vim.fn.filereadable(skeleton) == 1 then
      vim.cmd("silent! 0r " .. skeleton)
    end
  end,
})

-- =============================================================================
-- 5. Plugin Manager Bootstrap (lazy.nvim)
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- 6. Plugins Specification
-- =============================================================================
require("lazy").setup({
  -- UI / Theme
  { "morhetz/gruvbox", lazy = false, priority = 1000, config = function() vim.cmd("colorscheme gruvbox") end },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "wombat" },
      tabline = {
        lualine_a = { { "buffers", mode = 2 } },
        lualine_z = { "tabs" },
      },
    },
  },

  -- Navigation & Search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "CtrlP Replacement" },
      { "<space>/", "<cmd>Telescope live_grep<CR>", desc = "Unite grep replacement" },
      { "<space>s", "<cmd>Telescope buffers<CR>", desc = "Buffer quick-match" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<F4>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" } },
    opts = {},
  },
  {
    "simrat39/symbols-outline.nvim", -- Modern replacement for tagbar
    keys = { { "<F8>", "<cmd>SymbolsOutline<CR>", desc = "Tagbar/Outline" } },
    opts = {},
  },

  -- Treesitter (Replaces json, toml, ansible, fish syntax plugins)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "python", "bash", "json", "toml", "yaml", "fish", "terraform" },
        highlight = { enable = true },
      })
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim", opts = {} }, -- Replaces gitgutter

  -- Editing Helpers
  { "numToStr/Comment.nvim", opts = {} }, -- Modern replacement for nerdcommenter
  { "AndrewRadev/linediff.vim" },
  { "chrisbra/csv.vim" },

  -- Task, Notes & Bookkeeping
  { "freitass/todo.txt-vim" },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_dir_link = "index"
      vim.g.vimwiki_fold_lists = 1
      vim.g.vimwiki_hl_cb_checked = 1
      vim.g.vimwiki_hl_headers = 1
      vim.g.vimwiki_url_maxsave = 0
      vim.g.vimwiki_use_mouse = 1
      vim.g.vimwiki_list = {
        {
          path = vim.env.notes_path,
          path_html = vim.env.notes_path .. "/html",
          ext = ".md",
          syntax = "markdown",
          diary_rel_path = "diary/",
          diary_index = "index",
          diary_header = "Journal",
          diary_sort = "desc",
        },
        {
          path = "~/ibm/wiki",
          path_html = "~/ibm/wiki/html",
          diary_rel_path = "diary/",
          diary_index = "index",
          diary_header = "Journal",
          diary_sort = "desc",
        },
      }
    end,
    keys = {
      { "<leader>wn", "<cmd>VimwikiDiaryNextDay<CR>" },
      { "<leader>wp", "<cmd>VimwikiDiaryPrevDay<CR>" },
    },
  },
  {
    "ledger/vim-ledger",
    init = function()
      vim.g.ledger_maxwidth = 80
      vim.g.ledger_align_at = 56
      vim.g.ledger_fold_blanks = 1
      vim.g.ledger_fillstring = "· "
      vim.g.ledger_default_commodity = "BRL"
      vim.g.ledger_commodity_sep = " "
      vim.g.ledger_date_format = "%Y-%m-%d"
      vim.g.ledger_commodity_before = 0
    end,
    ft = { "ledger" },
  },
  { "nathangrigg/vim-beancount" },

  -- Domain Specific & Debugging
  { "sirtaj/vim-openscad" },
  { "hashivim/vim-terraform" },
  { "puremourning/vimspector" },
  { "andreshazard/vim-logreview" },
})
