;; native vim settings
(set vim.o.number true)
(set vim.o.relativenumber true)
(set vim.o.signcolumn :yes)
(set vim.o.mouse "")
(set vim.o.incsearch true)
(set vim.o.ignorecase true)
(set vim.o.smartcase true)
(set vim.o.scrolloff 5)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")
(vim.keymap.set :n "go" "m`o<esc>``")
(vim.keymap.set :n "gO" "m`O<esc>``")

;;; ----- UI -----
;; colorscheme
(vim.cmd.colorscheme :catppuccin)

;; treesitter
(let [ts-configs (require :nvim-treesitter.configs)]
  (ts-configs.setup {:highlight {:enable true}
                     :incremental_selection {:enable true}}))

;; icons
(let [icons (require :mini.icons)]
  (icons.setup))

;; clues (keymap hints)
(let [clue (require :mini.clue)]
  (clue.setup {:triggers  [;; Leader triggers
                           {:mode "n" :keys "<leader>"}
                           {:mode "x" :keys "<leader>"}
                           {:mode "n" :keys "<localleader>"}
                           {:mode "x" :keys "<localleader>"}

         ;; Built-in completion
                           {:mode "i" :keys "<C-x>"}

         ;; `g` key
                           {:mode "n" :keys "g"}
                           {:mode "x" :keys "g"}

         ;; Marks
                           {:mode "n" :keys "\""}
                           {:mode "n" :keys "`"}
                           {:mode "x" :keys "\""}
                           {:mode "x" :keys "`"}

         ;; Registers
                           {:mode "n" :keys "\""}
                           {:mode "x" :keys "\""}
                           {:mode "i" :keys "<C-r>"}
                           {:mode "c" :keys "<C-r>"}

         ;; Window commands
                           {:mode "n" :keys "<C-w>"}

         ;; `z` key
                           {:mode "n" :keys "z"}
                           {:mode "x" :keys "z"}]

               :clues [;; Enhance this by adding descriptions for <Leader> mapping groups
                       (clue.gen_clues.builtin_completion)
                       (clue.gen_clues.g)
                       (clue.gen_clues.marks)
                       (clue.gen_clues.registers)
                       (clue.gen_clues.windows)
                       (clue.gen_clues.z)
                       {:mode :n :keys "<leader>f" :desc "[f]ind"}
                       {:mode :n :keys "<leader>t" :desc "[t]rim"}]}))

(let [statusline (require :mini.statusline)]
  (statusline.setup))
(let [tabline (require :mini.tabline)]
  (tabline.setup))


;;; ----- general text editing -----
(let [pairs (require :mini.pairs)]
  (pairs.setup))

(let [jump (require :mini.jump)]
  (jump.setup))

(let [trailspace (require :mini.trailspace)]
  (trailspace.setup)
  (vim.keymap.set :n "<leader>tt" trailspace.trim {:desc "[t]railing spaces"})
  (vim.keymap.set :n "<leader>tl" trailspace.trim_last_lines {:desc "trailing [l]ines"}))

;; auto-formatting
(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:nix [:nixfmt]
                                     :python [:black]
                                     :go [:gofmt]}
                  :format_on_save {:timeout_ms 500 :lsp_format :fallback}}))

;; completion
(let [cmp (require :blink.cmp)]
  (cmp.setup {}))


;;; ----- workflow -----
(let [pick (require :mini.pick)]
  (pick.setup)
  (set vim.ui.select pick.ui_select)
  (vim.keymap.set :n "<leader>ff" pick.builtin.files {:desc "[f]iles"})
  (vim.keymap.set :n "<leader>fb" pick.builtin.buffers {:desc "[b]uffers"})
  (vim.keymap.set :n "<leader>fg" pick.builtin.grep_live {:desc "[g]rep"})
  (vim.keymap.set :n "<leader>fh" pick.builtin.help {:desc "[h]elp"}))

(let [files (require :mini.files)]
  (files.setup)
  (vim.keymap.set :n "<leader>e" files.open {:desc "file [e]xplorer"}))

(let [visits (require :mini.visits)]
  (visits.setup))

(vim.keymap.set :n "<leader>g" "<cmd>Neogit<cr>" {:desc "neo[g]it"})

;; enable all lsp-config LSPs
(vim.lsp.config "elixirls" {:cmd (nixCats "elixirlsPath")})
(let [configs {}]
  (each [_ v (ipairs (vim.api.nvim_get_runtime_file "lsp/*" true))]
    (let [name (vim.fn.fnamemodify v ":t:r")]
      (tset configs name true)))
  (vim.lsp.enable (vim.tbl_keys configs)))

;;; ----- other -----
(let [extra (require :mini.extra)]
  (extra.setup))

(let [snacks (require :snacks)]
  (snacks.setup {:input {}
                 :notifier {}
                 :statuscolumn {}}))
