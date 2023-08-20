return {
  { -- telescope
    "nvim-telescope/telescope.nvim",
    event = 'VeryLazy',
    dependencies = {
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "debugloop/telescope-undo.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
    },
    cmd = "Telescope",
    -- stylua: ignore
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fB", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find Command" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
      { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Find Project" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODOs" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      --local icons = require("utils.icons")
      local project_actions = require("telescope._extensions.project.actions")

      telescope.setup({
        defaults = {
          color_devicons = true,
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", },
          },
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          file_ignore_patterns = {
            'vendor/*', '%.lock', '__pycache__/*', '%.sqlite3', '%.ipynb',
            'node_modules/*', '%.jpg', '%.jpeg', '%.png', '%.svg', '%.otf',
            '%.ttf', '.git/', '%.webp', '.dart_tool/', '.github/', '.gradle/',
            '.idea/', '.settings/', '.vscode/', '__pycache__/', 'build/',
            '_build', 'env/', 'gradle/', 'node_modules/', 'target/', '%.pdb',
            '%.dll', '%.class', '%.exe', '%.cache', '%.ico', '%.pdf', '%.dylib',
            '%.jar', '%.docx', '%.met', 'smalljre_*/*', '.vale/', '%.burp',
            '%.mp4', '%.mkv', '%.rar', '%.zip', '%.7z', '%.tar', '%.bz2',
            '%.epub', '%.flac', '%.tar.gz',
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", }, hidden = true, },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
              width = 0.8,
              previewer = false,
              prompt_title = false,
            },
          },
          fzf = {
            fuzzy = true,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            case_mode = "smart_case",
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
          project = {
            base_dirs = {
              '~',
              --        --'~/dev/src',
              --        -- {'~/dev/src2'},
              --        -- {'~/dev/src3', max_depth = 4},
              --        -- {path = '~/dev/src4'},
              --        -- {path = '~/dev/src5', max_depth = 2},
            },
            hidden_files = true,        -- default: false
            theme = "dropdown",
            order_by = "recent",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
            -- default for on_project_selected = find project files
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
            end
          },
          undo = {
            side_by_side = true,
            use_delta = true,
            entry_format = "state #$ID, $STAT, $TIME",
            layout_strategy = "horizontal",
          },
        },
        preview = {},
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("file_browser")
      telescope.load_extension("noice")
      telescope.load_extension("undo")
    end,
  },
  { -- todo comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "td", "<cmd>TodoQuickFix<cr>", desc = "TODO" },
    },
    opts = {},
  },
  { -- trouble
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "tt", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    },
    opts = {},
  },
  { -- which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n" },
        ["<leader>f"] = { name = "+Find" },
        ["t"] = { name = "+Trouble/TODO" },
      },
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.register(opts.defaults)
    end,
  },
}


