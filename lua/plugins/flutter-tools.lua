return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("flutter-tools").setup({
        lsp = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            -- In your Neovim config (e.g., init.lua or a module), add:

            -- Utility function to find project root via lspconfig util
            local function find_dart_root()
              local util = require("lspconfig.util")
              -- Get current buffer's file path
              local bufname = vim.api.nvim_buf_get_name(0)
              -- Try to find a directory with pubspec.yaml upward from bufname
              local root = util.root_pattern("pubspec.yaml")(bufname)
              if root then
                return root
              end
              -- Fallback to cwd
              return vim.fn.getcwd()
            end

            -- Main function to run `dart fix --apply`
            local function dart_fix_apply()
              -- Save current buffer first
              if vim.bo.modified then
                vim.cmd("write")
              end

              local root = find_dart_root()
              vim.notify("Running `dart fix --apply` in: " .. root, vim.log.levels.INFO)

              -- Start async job
              vim.fn.jobstart({ "dart", "fix", "--apply" }, {
                cwd = root,
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = function(_, data)
                  if data and #data > 0 then
                    -- Print output lines to Neovim message area
                    for _, line in ipairs(data) do
                      if line ~= "" then
                        vim.notify(line, vim.log.levels.INFO)
                      end
                    end
                  end
                end,
                on_stderr = function(_, data)
                  if data and #data > 0 then
                    for _, line in ipairs(data) do
                      if line ~= "" then
                        vim.notify("dart fix error: " .. line, vim.log.levels.ERROR)
                      end
                    end
                  end
                end,
                on_exit = function(_, exit_code)
                  if exit_code == 0 then
                    vim.notify("`dart fix --apply` completed successfully", vim.log.levels.INFO)
                    -- Reload the current buffer to reflect applied fixes
                    -- Only reload if the file still exists on disk
                    local bufname = vim.api.nvim_buf_get_name(0)
                    if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
                      vim.cmd("edit")
                    end
                  else
                    vim.notify(
                      "`dart fix --apply` failed with exit code " .. exit_code,
                      vim.log.levels.ERROR
                    )
                  end
                end,
              })
            end

            -- Keymap: for example, <leader>df (Dart Fix)
            vim.keymap.set("n", "<leader>df", dart_fix_apply, { desc = "Dart: dart fix --apply" })
          end,
          capabilities = capabilities,
          settings = {
            dart = {
              lineLength = 80,
              completeFunctionCalls = true,
              renameFilesWithClasses = "prompt",
              enableSnippets = true,
              showTodos = true,
              updateImportsOnRename = true,
            },
          },
        },
      })
    end,
  },
}

--[[
      local dartExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("/opt/homebrew/"),
        vim.fn.expand("$HOME/tools/flutter/"),
      }

      lspconfig.dartls.setup({
        capabilities = capabilities,
        cmd = {
          "dart",
          "language-server",
          "--protocol=lsp",
        },
        filetypes = { "dart" },
        root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = false,
          flutterOutline = false,
        },
        settings = {
          dart = {
            analysisExcludedFolders = dartExcludedFolders,
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      })
  ]]
