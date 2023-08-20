return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    cmd = "ToggleTerm",
    -- stylua: ignore
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=30 direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=70 direction=vertical<cr>", desc = "Vertical Terminal" },
    },
    config = function()
      require("toggleterm").setup({
        -- size = 20,
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-t>]],
        autochdir = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        direction = "float", -- horizontal | float | vertical | tab
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          --border = "curved",
          border = "rounded",
          width = math.floor(vim.o.columns * 0.85),
          height = math.floor(vim.o.lines * 0.8),
          winblend = 15,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        highlights = {
          StatusLine = { link = "StatusLine" },
          StatusLineNC = { link = "StatusLineNC" },
        },
      })

      local Terminal = require('toggleterm.terminal').Terminal
      local keymap = vim.keymap.set

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        keymap("t", "<esc>", [[<C-\><C-n>]], opts)
        keymap("t", "jk", [[<C-l>]], opts)
        keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- Set terminal keymaps whenever terminal opens
      --vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

      -- LazyGit
      local lazygit = Terminal:new {
        cmd = "lazygit",
        dir = 'git_dir',
        direction = 'float',
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd('startinsert!')
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd('startinsert!')
        end,
        hidden = true
      }
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      keymap("n", "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "LazyGit" })

      -- NCDU
      local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
      function _NCDU_TOGGLE()
        ncdu:toggle()
      end
      keymap("n", "<leader>tn", "<cmd>lua _NCDU_TOGGLE()<CR>", { noremap = true, silent = true, desc = "NCDU" })

      -- Htop
      local htop = Terminal:new({ cmd = "htop", hidden = true })
      function _HTOP_TOGGLE()
        htop:toggle()
      end
      keymap("n", "<leader>tp", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Htop" })
    end
  },
  { -- which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n" },
        ["<leader>t"] = { name = "+Terminal" },
      },
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.register(opts.defaults)
    end,
  },
}

