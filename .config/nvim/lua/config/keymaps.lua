local function keymap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true, desc = "Leader key" })

-- Modes
--  *) normal_mode = "n",
--  *) insert_mode = "i",
--  *) visual_mode = "v",
--  *) visual_block_mode = "x",
--  *) term_mode = "t",
--  *) command_mode = "c",

--- --- --- --- --- --- --- --- --- Normal --- --- --- --- --- --- --- --- ---
-- Move down and up only one visual line
keymap("n", "j", "v:count==0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count==0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window width" })

-- Navigate buffers with <Shift-R/L>
keymap("n", "<S-Right>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next tab" })
keymap("n", "<S-Left>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous tab" })

-- Move text up and down
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", { noremap = true, silent = true, desc = "Line move up" })
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", { noremap = true, silent = true, desc = "Line move down" })

-- Next/Previous search result
--keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Next search result" })
--keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Previous search result" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })

-- Split windows
keymap("n", "sv", ":vs<CR>", { noremap = true, silent = true, desc = "Split vertically" })
keymap("n", "sh", ":sp<CR>", { noremap = true, silent = true, desc = "Split horizontally" })

-- Select all
keymap("n", "<C-a>", "ggVG<cr>", { noremap = true, silent = true, desc = "Select all" })

-- nop
keymap("n", ".", "<Nop>", { noremap = true, silent = true, desc = "nop" })

-- Redo
keymap("n", "U", "<C-r>", { noremap = true, silent = true, desc = "Redo" })

-- highlights under cursor
--if vim.fn.has("nvim-0.9") == 1 then
--  keymap("n", "<leader>ui", vim.show_pos, { noremap = true, silent = true, desc = "Inspect Pos" })
--end

-- new file, quickfix
--keymap("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })
--keymap("n", "<leader>ql", "<cmd>copen<cr>", { desc = "Quickfix List" })
--keymap("n", "<leader>ll", "<cmd>lopen<cr>", { desc = "Location List" })

-- quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
keymap("n", "<leader>w", "<cmd>update!<cr>", { desc = "Save" })

--- --- --- --- --- --- --- --- --- Insert --- --- --- --- --- --- --- --- ---
-- Press jk fast to enter
--keymap("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Exit from insert mode" })

-- Move text up and down
keymap("i", "<A-Down>", "<Esc>:m .+1<cr>==gi", { noremap = true, silent = true, desc = "Move down" })
keymap("i", "<A-Up>", "<Esc>:m .-2<cr>==gi", { noremap = true, silent = true, desc = "Move up" })

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

--- --- --- --- --- --- --- --- --- Visual --- --- --- --- --- --- --- --- ---
-- Stay in indent mode
keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Tab to left" })
keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Tab to right" })

-- Move text up and down
keymap("v", "<A-Down>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move down" })
keymap("v", "<A-Up>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move up" })

-- Paste
keymap("v", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without replace clipboard" })

-- Repeat and macro
keymap("v", ".", ":normal @q<CR>", { noremap = true, silent = true, desc = "Repeat @q macro" })

--- --- --- --- --- --- --- --- --- ALL MODE --- --- --- --- --- --- --- --- ---
-- Disable search highlight
keymap({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true, desc = "Disable highlight" })

-- Copy (Ctrl-c) / Cut (Ctrl-x) / Paste (Ctrl-v)
keymap("v", "<C-c>", '"*y :let @+=@*<CR>', { noremap = true, silent = true, desc = "Copy text" })
keymap("v", "<C-x>", '"+c', { noremap = true, silent = true, desc = "Cut text" })
keymap("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste text" })
--keymap("i", "<C-v>", '<C-R>*', { noremap = true, silent = true,  desc = "Paste text" })
keymap("i", "<C-v>", '<ESC>"+p', { noremap = true, silent = true, desc = "Paste text" })

-- Save file
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { noremap = true, silent = true, desc = "Save file" })
--keymap({ "i", "v", "n", "s" }, "<M-s>", "<cmd>w<cr><esc>", { noremap = true, silent = true, desc = "Save file" })

-- CLose buffer
keymap({ "i", "v", "n" }, "<C-w>", "<cmd>bd<cr><esc>", { noremap = true, silent = true, desc = "Close buffer" })

-- Exit neovim
keymap({ "i", "v", "n" }, "<C-q>", "<cmd>q<cr>", { noremap = true, silent = true, desc = "Exit Vim" })

-- LSP formatting
keymap("n", "<C-f>", function()
  vim.lsp.buf.format({ async = false })
  vim.api.nvim_command("write")
end, { desc = "Lsp formatting" })

