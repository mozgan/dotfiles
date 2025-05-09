local M = {}

local lsp_utils = require("devel.lsp.utils")

local function lsp_init()
	-- LSP handlers configuration
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},

		diagnostic = {
			virtual_text = {
				severity = { min = vim.diagnostic.severity.WARN },
			},
			underline = false,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)

	-- Hover configuration
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	-- Signature help configuration
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

function M.setup(_, opts)
	lsp_utils.on_attach(function(client, bufnr)
		require("devel.lsp.format").on_attach(client, bufnr)
		require("devel.lsp.keymaps").on_attach(client, bufnr)
	end)

	lsp_init() -- diagnostics, handlers

	local servers = opts.servers
	local capabilities = lsp_utils.capabilities()
	--print(vim.inspect(servers))
	--print(vim.inspect(capabilities))

	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, servers[server] or {})

		--print(vim.inspect(server_opts))
		require("lspconfig")[server].setup(server_opts)
		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	-- get all the servers that are available thourgh mason-lspconfig
	local have_mason, mlsp = pcall(require, "mason-lspconfig")
	local all_mslp_servers = {}
	if have_mason then
		all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
	end

	local ensure_installed = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	if have_mason then
		mlsp.setup({ ensure_installed = ensure_installed })
		mlsp.setup_handlers({ setup })
	end
end

return M
