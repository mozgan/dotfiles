return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ascii text: https://patorjk.com/software/taag
      dashboard.section.header.val = {
        [[               ,        ,           ]],
        [[              /(        )`          ]],
        [[              \ \___   / |          ]],
        [[              /- _  `-/  '          ]],
        [[             (/\/ \ \   /\          ]],
        [[             / /   | `    \         ]],
        [[             O O   ) /    |         ]],
        [[             `-^--'`<     '         ]],
        [[            (_.)  _  )   /          ]],
        [[             `.___/`    /           ]],
        [[               `-----' /            ]],
        [[  <----.     __ / __   \            ]],
        [[  <----|====O)))==) \) /====        ]],
        [[  <----'    `--' `.__,' \           ]],
        [[               |        |           ]],
        [[                \       /           ]],
        [[           ______( (_  / \______    ]],
        [[         ,'  ,-----'   |        \   ]],
        [[         `--{__________)        \/  ]],

--        [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
--        [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
--        [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
--        [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
--        [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
--        [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],

--        [[                               __                ]],
--        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", " " .. " New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recently Used Files", ":Telescope oldfiles <CR>"),
        dashboard.button("b", " " .. " Browse Files", ":Telescope file_browser <CR>"),
        dashboard.button("p", " " .. " Find Project", ":Telescope project <CR>"),
        dashboard.button("f", " " .. " Find File", ":Telescope find_files <CR>"),
        dashboard.button("t", " " .. " Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("s", " " .. " Settings", ":e $MYVIMRC | :cd %:p:h | vsplit . | wincmd k | pwd<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      local function footer()
        local datetime = os.date "%H:%M:%S %d.%m.%Y"
        local plugins_text =
            "   v"
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
            .. "   "
            .. datetime

        -- Quote
        local fortune = require("alpha.fortune")
        local quote = table.concat(fortune(), "\n")

        return plugins_text .. "\n" .. quote
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      dashboard.opts.hide = { statusline = true, tabline = true, winbar = true, }

      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
      ]])
    end
  },
}
