return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "▔", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          untracked = { hl = "GitSignsUntracked", text = "┃", numhl = "GitSignsUntrackedNr", linehl = "GitSignsUntrackedLn" },
        },
        current_line_blame = true,   -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_formatter_opts = { relative_time = true },
        current_line_blame_formatter = "      <author>, <author_time:%R> - <summary>",
      })
    end,
  },
  { -- fold look
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99   -- feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ftMap = {
        vim = { 'indent' },
        python = { 'indent' },
        git = '',
        c = { 'indent' },
        cpp = { 'indent' },
        lua = { 'indent' },
      }

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = (' 󰘕 %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx =
          math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
        suffix = (' '):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      local ufo = require("ufo")
      ufo.setup({
        filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        open_fold_hl_timeout = 0,
        enable_get_fold_virt_text = true,
        close_fold_kinds = { 'imports', 'comment' },
        fold_virt_text_handler = handler,
        --provider_selector = function(bufnr, filetype, buftype)
        --  return ftMap[filetype] or {'treesitter', 'indent'}
        --end,
      })

      local keymap = vim.keymap.set

      keymap('n', 'zR', ufo.openAllFolds, { noremap = true, silent = true, desc = "Open All Folds" })
      keymap('n', 'zM', ufo.closeAllFolds, { noremap = true, silent = true, desc = "Close All Folds" })
      keymap('n', 'zr', ufo.openFoldsExceptKinds, { noremap = true, silent = true, desc = "Open Folds Except Kinds" })
      keymap('n', 'zm', ufo.closeFoldsWith, { noremap = true, silent = true, desc = "Close Folds With" }) -- closeAllFolds == closeFoldsWith(0)
    end
  },
  { -- configurable statuscolumn
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        foldfunc = "builtin",
        order = "NSFs",
        segments = {
          { -- sign
            " ",
            sign = { name = { ".*" } }, --maxwidth = 2, colwidth = 1 },
            click = "v:lua.ScSa",
            " ",
          },
          { -- line number
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
          },
          { -- fold
            text = { " ", builtin.foldfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScFa",
          },
        },
      })
    end,
  },
}
