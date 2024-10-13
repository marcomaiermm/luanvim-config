vim.filetype.add({ extension = { templ = "templ" } })

return {
  {
    "marilari88/twoslash-queries.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        tailwindcss = {
          filetypes_include = { "templ" },
          init_options = { userLanguages = { templ = "html" } },
        },
      },
    },
    setup = {
      templ = {
        filetypes = { "html", "templ" },
      },
    },
  },
}
