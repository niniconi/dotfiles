return {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.nixos.options',
        },
        home_manager = {
          expr = '(builtins.getFlake (toString ./.)).homeConfigurations."administrator@nixos".options',
        },
      },
    },
  },
}
