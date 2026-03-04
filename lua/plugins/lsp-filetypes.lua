-- Override default filetypes for LSP servers that declare
-- composite/unknown filetypes, silencing checkhealth warnings.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          filetypes = { "yaml" },
        },
        antlersls = {
          filetypes = { "html" },
        },
        docker_compose_language_service = {
          filetypes = { "yaml" },
        },
        marksman = {
          filetypes = { "markdown" },
        },
        vtsls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        yamlls = {
          filetypes = { "yaml" },
        },
      },
    },
  },
}
