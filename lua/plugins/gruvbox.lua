return {
    { "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                operators = true,
                comments = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,
            contrast = "hard",
            palette_overrides = {},
            overrides = {
                ColorColumn = { bg = "#e8e0cc" },
            },
            dim_inactive = false,
            transparent_mode = false,
        },
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd([[colorscheme gruvbox]])
        end,
    }
}
