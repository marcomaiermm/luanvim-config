return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  dependencies = {
    {
      "vrischmann/tree-sitter-templ",
      build = "cp -r queries ../nvim-treesitter/queries/templ",
      init = function()
        vim.filetype.add({ extension = { templ = "templ" } })
      end,
      config = function()
        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
          install_info = {
            url = "https://github.com/vrischmann/tree-sitter-templ.git",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "master",
          },
        }
        vim.treesitter.language.register("templ", "templ")
      end,
    },
  },
  opts = function(_, opts)
    opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "templ" })
  end,
}
