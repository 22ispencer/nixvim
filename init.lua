-- [nfnl] init.fnl
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.mouse = ""
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 5
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "go", "m`o<esc>``")
vim.keymap.set("n", "gO", "m`O<esc>``")
vim.cmd.colorscheme("catppuccin")
do
  local ts_configs = require("nvim-treesitter.configs")
  ts_configs.setup({highlight = {enable = true}, incremental_selection = {enable = true}})
end
do
  local icons = require("mini.icons")
  icons.setup()
end
do
  local clue = require("mini.clue")
  clue.setup({triggers = {{mode = "n", keys = "<leader>"}, {mode = "x", keys = "<leader>"}, {mode = "n", keys = "<localleader>"}, {mode = "x", keys = "<localleader>"}, {mode = "i", keys = "<C-x>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "\""}, {mode = "n", keys = "`"}, {mode = "x", keys = "\""}, {mode = "x", keys = "`"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}}, clues = {clue.gen_clues.builtin_completion(), clue.gen_clues.g(), clue.gen_clues.marks(), clue.gen_clues.registers(), clue.gen_clues.windows(), clue.gen_clues.z(), {mode = "n", keys = "<leader>f", desc = "[f]ind"}, {mode = "n", keys = "<leader>t", desc = "[t]rim"}}})
end
do
  local statusline = require("mini.statusline")
  statusline.setup()
end
do
  local tabline = require("mini.tabline")
  tabline.setup()
end
do
  local pairs = require("mini.pairs")
  pairs.setup()
end
do
  local jump = require("mini.jump")
  jump.setup()
end
do
  local trailspace = require("mini.trailspace")
  trailspace.setup()
  vim.keymap.set("n", "<leader>tt", trailspace.trim, {desc = "[t]railing spaces"})
  vim.keymap.set("n", "<leader>tl", trailspace.trim_last_lines, {desc = "trailing [l]ines"})
end
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {nix = {"nixfmt"}, python = {"black"}, go = {"gofmt"}}, format_on_save = {timeout_ms = 500, lsp_format = "fallback"}})
end
do
  local cmp = require("blink.cmp")
  cmp.setup({})
end
do
  local pick = require("mini.pick")
  pick.setup()
  vim.ui.select = pick.ui_select
  vim.keymap.set("n", "<leader>ff", pick.builtin.files, {desc = "[f]iles"})
  vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, {desc = "[b]uffers"})
  vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, {desc = "[g]rep"})
  vim.keymap.set("n", "<leader>fh", pick.builtin.help, {desc = "[h]elp"})
end
do
  local files = require("mini.files")
  files.setup()
  vim.keymap.set("n", "<leader>e", files.open, {desc = "file [e]xplorer"})
end
do
  local visits = require("mini.visits")
  visits.setup()
end
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", {desc = "neo[g]it"})
vim.lsp.config("elixirls", {cmd = "elixir-ls"})
do
  local configs = {}
  for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
    local name = vim.fn.fnamemodify(v, ":t:r")
    configs[name] = true
  end
  vim.lsp.enable(vim.tbl_keys(configs))
end
do
  local extra = require("mini.extra")
  extra.setup()
end
local snacks = require("snacks")
return snacks.setup({input = {}, notifier = {}, statuscolumn = {}})
