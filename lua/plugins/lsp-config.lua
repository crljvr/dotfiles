return {
	{
		"mason-org/mason.nvim",
		config = true,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- Display information about a method etc.
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- Go to definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			--
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- This should present function declaration parameter names and such in Dart.
			vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, {})
		end,
	},
}
