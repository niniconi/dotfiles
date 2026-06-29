return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f1512',
				base01 = '#171d1a',
				base02 = '#1b211e',
				base03 = '#808a85',
				base0B = '#fff272',
				base04 = '#d2dfd9',
				base05 = '#f8fffc',
				base06 = '#f8fffc',
				base07 = '#f8fffc',
				base08 = '#ffbc9f',
				base09 = '#ffbc9f',
				base0A = '#a5eacc',
				base0C = '#d7ffed',
				base0D = '#a5eacc',
				base0E = '#c0ffe4',
				base0F = '#c0ffe4',
			})
		end
	}
}
