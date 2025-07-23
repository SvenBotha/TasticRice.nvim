-- CodeCompanion plugin configuration for Lazy.nvim
-- Add this to your plugins directory or lazy setup

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp", -- Optional: for completion
		"nvim-telescope/telescope.nvim", -- Optional: for actions
		"stevearc/dressing.nvim", -- Optional: for better UI
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "openai",
				},
				inline = {
					adapter = "openai",
				},
				agent = {
					adapter = "openai",
				},
			},
			adapters = {
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						env = {
							api_key = "OAIK", -- Your environment variable name
						},
						schema = {
							model = {
								default = "gpt-3.5-turbo", -- or "gpt-3.5-turbo" if you prefer
							},
						},
					})
				end,
			},
			display = {
				action_palette = {
					width = 95,
					height = 10,
				},
				chat = {
					window = {
						layout = "vertical", -- or "horizontal", "buffer"
						width = 0.45,
						height = 0.8,
						relative = "editor",
						border = "single",
						title = "CodeCompanion",
					},
				},
			},
			opts = {
				log_level = "ERROR", -- or "DEBUG" for troubleshooting
				send_code = true, -- Send code context with requests
				use_default_actions = true,
				use_default_prompt_library = true,
			},
		})

		-- Key mappings
		local wk_ok, wk = pcall(require, "which-key")

		-- Basic keymaps (work without which-key)
		vim.keymap.set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
		vim.keymap.set(
			{ "n", "v" },
			"<Leader>ch",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ desc = "Toggle CodeCompanion Chat" }
		)
		vim.keymap.set("v", "<Leader>ca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to chat" })
		vim.keymap.set("n", "<Leader>ci", "<cmd>CodeCompanionChat<cr>", { desc = "Inline CodeCompanion" })
		vim.keymap.set("n", "<Leader>cl", "<cmd>CodeCompanionCmd<cr>", { desc = "CodeCompanion Command" })

		-- Additional useful keymaps
		vim.keymap.set("n", "<Leader>cp", function()
			require("codecompanion").prompt("explain")
		end, { desc = "Explain code" })

		vim.keymap.set("v", "<Leader>ce", function()
			require("codecompanion").prompt("explain")
		end, { desc = "Explain selection" })

		vim.keymap.set("v", "<Leader>cf", function()
			require("codecompanion").prompt("fix")
		end, { desc = "Fix code" })

		vim.keymap.set("v", "<Leader>co", function()
			require("codecompanion").prompt("optimize")
		end, { desc = "Optimize code" })

		-- If which-key is available, register the mappings with descriptions
		if wk_ok then
			wk.register({
				["<leader>c"] = {
					name = "CodeCompanion",
					c = { "<cmd>CodeCompanionActions<cr>", "Actions" },
					h = { "<cmd>CodeCompanionChat Toggle<cr>", "Toggle Chat" },
					a = { "<cmd>CodeCompanionChat Add<cr>", "Add to Chat", mode = "v" },
					i = { "<cmd>CodeCompanionChat<cr>", "Inline Chat" },
					l = { "<cmd>CodeCompanionCmd<cr>", "Command" },
					p = {
						function()
							require("codecompanion").prompt("explain")
						end,
						"Explain Code",
					},
					e = {
						function()
							require("codecompanion").prompt("explain")
						end,
						"Explain Selection",
						mode = "v",
					},
					f = {
						function()
							require("codecompanion").prompt("fix")
						end,
						"Fix Code",
						mode = "v",
					},
					o = {
						function()
							require("codecompanion").prompt("optimize")
						end,
						"Optimize Code",
						mode = "v",
					},
				},
			})
		end

		-- Auto commands for better integration
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "codecompanion" then
					vim.opt_local.wrap = true
					vim.opt_local.linebreak = true
				end
			end,
		})
	end,
}
