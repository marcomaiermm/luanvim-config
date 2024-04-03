return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "pmizio/typescript-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          enabled = false, -- only use typescript tools
          keys = {
            {
              "<leader>co",
              "<cmd>TSToolsOrganizeImports<cr>",
              desc = "Organize Imports",
            },
            {
              "<leader>cR",
              "<cmd>TSToolsRemoveUnusedImports<cr>",
              desc = "Remove Unused Imports",
            },
          },
          ---@diagnostic disable-next-line: missing-fields
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
