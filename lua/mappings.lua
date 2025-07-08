require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- new terminals
map("n", "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map("n", "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map("n", "<leader>i", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggleable floating term" })

-- opening lsp diagnostics
map("n", "<leader>ww", function()
  vim.diagnostic.open_float(0.0, { scope = "line" })
end, { desc = "Show floating diagnostics" })

-- undo change
map("n", "U", "<C-r>", { noremap = true, silent = true })

-- scrolling
map("n", "<C-f>", "<C-e>", { noremap = true, silent = true })
map("n", "<C-e>", "<C-y>", { noremap = true, silent = true })
map("n", "{", "}")
map("n", "}", "{")

-- line navigation in wrap mode
map("n", "j", "gj")
map("n", "k", "gk")

-- pane navigation
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

-- line end and start
map("n", "<S-l>", "$")
map("n", "<S-h>", "^")

-- moving lines
local opts = { noremap = true, silent = true }
-- Normal-mode commands
map("n", "<leader>j", ":MoveLine(1)<CR>", opts)
map("n", "<leader>k", ":MoveLine(-1)<CR>", opts)
map("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
map("n", "<leader>wf", ":MoveWord(1)<CR>", opts)

-- Visual-mode commands
map("v", "<C-j>", ":MoveBlock(1)<CR>", opts)
map("v", "<C-k>", ":MoveBlock(-1)<CR>", opts)

-- Folding
map("n", "<leader>dd", function()
  if vim.opt.foldmethod:get() == "manual" then
    vim.opt.foldmethod = "indent"
    vim.cmd "normal! zM"
    print "Foldmethod 'indent'"
  else
    vim.opt.foldmethod = "manual"
    vim.cmd "normal! zR"
    print "Foldmethod 'manual'"
  end
end, { desc = "Toggle fold method" })
map("n", "<leader>o", "za", { silent = true })
map("n", "<leader>O", "zA", { silent = true })

-- Close all buffers
map("n", "<leader>bd", ":%bd<CR>", { desc = "Clear all buffers" })

-- Telescope
map("n", "<leader>fl", require("telescope.builtin").resume, { desc = "telescope redo last search" })

-- Tabs
map("n", "N", ":tabnext<CR>", opts)
map("n", "P", ":tabprev<CR>", opts)
map("n", "<leader>n", ":tabnew<CR>", opts)
map("n", "<leader>N", ":tabclose<CR>", opts
