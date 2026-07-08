return {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package",
        },
        {
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "https://json.schemastore.org/tsconfig",
        },
        {
          fileMatch = { ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc",
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json" },
          url = "https://json.schemastore.org/prettierrc",
        },
      },
    },
  },
}
