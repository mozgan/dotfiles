return {
  {
    "madskjeldgaard/cppman.nvim",
    event = "VeryLazy",
    dependencies = "MunifTanjim/nui.nvim",
    cmd = "CPPMman",
    keys = {
      { "rc", function() require("cppman").open_cppman_for(vim.fn.expand("<cword>")) end, desc = "CPPMan - Search Word" },
      { "cc", function() require("cppman").input() end, desc = "CPPMan - Search Box" },
    },
    opts = true,
    config = function()
      require("cppman").setup()
    end
  },
  {
    "danymat/neogen",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>nf", ":lua require('neogen').generate()<CR>", desc = "Create Auto Comment" },
    },
    config = function(_, opts)
      require("neogen").setup({
        enabled = true,
        snippet_engine = "luasnip",
        input_after_comment = true,
        languages = {
          ["cpp.doxygen"] = require("neogen.configurations.cpp")
        },
      })
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>rc", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
    },
    opts = {
      mode = "term",
        startinsert = true,
        filetype = {
          python = "python3 -u",
          c = {
            "cd /tmp &&",
            "mkdir -p bin &&",
            "cd bin &&",
            "gcc -Wall -pedantic $dir/$fileName -o $fileNameWithoutExt &&",
            "./$fileNameWithoutExt"
          },
          --c = "cd $dir && mkdir -p bin && cd bin && gcc ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          cpp = {
            "cd /tmp &&",
            "mkdir -p bin &&",
            "cd bin &&",
            "g++ -Wall -pedantic --std=c++20 $dir/$fileName -o $fileNameWithoutExt &&",
            "./$fileNameWithoutExt"
          },
          --cpp = "cd $dir && mkdir -p bin && cd bin && g++ ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        },
        project = {
          -- TODO: take project list from other file if possible
        },
    },
    config = function(_, opts)
      require("code_runner").setup(opts)
    end
  },
  {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
    },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_build_directory = "",
        cmake_build_directory_prefix = "build/",
        cmake_build_type = "Debug",
        cmake_soft_link_compile_commands = true,
        cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
      })
    end,
  },
  { -- which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>c"] = { name = "+CMake" },
        ["<leader>r"] = { name = "+Code Runner" },
      },
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.register(opts.defaults)
    end,
  },
}

