return {
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    config = function()
      local nvim_tree = require("nvim-tree")
      local icons = require("utils.icons")

      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings.
        -- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
        local keymap = vim.keymap.set
        -- BEGIN_DEFAULT_ON_ATTACH
        keymap('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        keymap('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        keymap('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        keymap('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        keymap('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        keymap('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        keymap('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        keymap('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        keymap('n', '<CR>', api.node.open.edit, opts('Open'))
        keymap('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        keymap('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        keymap('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        keymap('n', '.', api.node.run.cmd, opts('Run Command'))
        keymap('n', '-', api.tree.change_root_to_parent, opts('Up'))
        keymap('n', 'a', api.fs.create, opts('Create'))
        keymap('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        keymap('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
        keymap('n', 'c', api.fs.copy.node, opts('Copy'))
        keymap('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
        keymap('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        keymap('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        keymap('n', 'd', api.fs.remove, opts('Delete'))
        keymap('n', 'D', api.fs.trash, opts('Trash'))
        keymap('n', 'E', api.tree.expand_all, opts('Expand All'))
        keymap('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        keymap('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        keymap('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        keymap('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        keymap('n', 'f', api.live_filter.start, opts('Filter'))
        keymap('n', 'g?', api.tree.toggle_help, opts('Help'))
        keymap('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        keymap('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        keymap('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        keymap('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        keymap('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        keymap('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        keymap('n', 'o', api.node.open.edit, opts('Open'))
        keymap('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        keymap('n', 'p', api.fs.paste, opts('Paste'))
        keymap('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        keymap('n', 'q', api.tree.close, opts('Close'))
        keymap('n', 'r', api.fs.rename, opts('Rename'))
        keymap('n', 'R', api.tree.reload, opts('Refresh'))
        keymap('n', 's', api.node.run.system, opts('Run System'))
        keymap('n', 'S', api.tree.search_node, opts('Search'))
        keymap('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
        keymap('n', 'W', api.tree.collapse_all, opts('Collapse'))
        keymap('n', 'x', api.fs.cut, opts('Cut'))
        keymap('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        keymap('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        keymap('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        keymap('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        -- END_DEFAULT_ON_ATTACH

        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        keymap('n', '?', api.tree.toggle_help, opts('Help'))
        keymap("n", "o", api.node.open.edit, opts("Open"))
        keymap("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        keymap("n", "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
        keymap('n', 'R', api.node.run.system, opts('Run System'))
      end

      nvim_tree.setup({
        sort_by = "name",
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        prefer_startup_root = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        reload_on_bufenter = true,
        select_prompts = true,

        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Information,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
          },
        },

        hijack_directories = {
          enable = true,
          auto_open = true,
        },

        update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = { 'toggleterm', 'term' },
        },

        trash = {
          cmd = "trash-put",
          require_confirm = true,
        },

        renderer = {
          group_empty = true,
          full_name = true,
          highlight_git = true,
          highlight_opened_files = 'icon',
          highlight_modified = 'icon',
        },

        on_attach = on_attach,
      })
    end,
  },
}


