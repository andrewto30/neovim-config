return {
	-- Package manager for LSP servers, formatters, linters
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server", -- for editing this config
				"pyright",
				"gopls",
				-- Formatters (used by conform)
				"stylua",
				"black",
				"isort",
				"gofumpt",
				"goimports",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			-- Auto-install missing tools listed in ensure_installed
			local mr = require("mason-registry")
			local function install_missing()
				for _, tool in ipairs(opts.ensure_installed or {}) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(install_missing)
			else
				install_missing()
			end
		end,
	},

	-- LSP configurations (just the registry of server configs; we use vim.lsp.config to enable them)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Diagnostic display
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
			})

			-- Keymaps applied when an LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gr", "<cmd>FzfLua lsp_references<cr>", "References")
					map("n", "gi", vim.lsp.buf.implementation, "Implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Type definition")
					map("n", "K", vim.lsp.buf.hover, "Hover docs")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
					map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, "Next diagnostic")
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, "Prev diagnostic")
					map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature help")
				end,
			})

			-- Apply capabilities to ALL servers globally (so we don't repeat ourselves below)
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Per-server configuration overrides
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } }, -- recognize the `vim` global
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})

			-- pyright needs no extra config; defaults from nvim-lspconfig are fine.

			-- Enable the servers (this is what actually starts them on matching filetypes)
			vim.lsp.enable({ "lua_ls", "pyright", "gopls" })
		end,
	},
}
