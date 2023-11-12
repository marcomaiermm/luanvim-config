local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  --@param opts cmp.ConfigSchema
  opts = {
    mapping = cmp.config.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    })
  }
}
