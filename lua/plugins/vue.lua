-- Vue.js LSP and tooling configuration
-- Provides autocompletion for variables, props, emits, composables,
-- directives and other symbols in .vue files using Volar + vtsls.
return {
  -- 1. Install Vue language server via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Add vue-language-server (Volar) to auto-installed tools
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "vue-language-server",
      })
    end,
  },

  -- 2. Configure Volar LSP and extend vtsls for .vue files
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Volar: primary LSP for .vue files
        -- Handles template expressions, script setup, style completions
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              -- Hybrid mode: false = Volar handles everything in .vue files
              -- Set to true only if you want vtsls to handle <script> blocks
              hybridMode = false,
            },
          },
        },

        -- vtsls: extend to support <script> blocks inside .vue files
        -- This gives TypeScript-aware completions (types, imports, etc.)
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue", -- added: enables TS completions inside .vue <script> blocks
          },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    -- Vue TypeScript plugin: bridges vtsls and Volar
                    name = "@vue/typescript-plugin",
                    location = vim.fn.expand(
                      vim.fn.stdpath("data")
                        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
                    ),
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },

  -- 3. Add Vue Treesitter grammar for syntax highlighting and text objects
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "vue", -- template/script/style block awareness
        "css", -- style block highlighting (if not already installed)
      })
    end,
  },

  -- 4. Enable prettierd formatting for .vue files
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- prettierd already handles vue files; this makes it explicit
      opts.formatters_by_ft.vue = { "prettierd" }
      return opts
    end,
  },
}
