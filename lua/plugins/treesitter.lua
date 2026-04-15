return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
        ensure_installed = { "lua", "python", "rust", "go", "c", "cpp", "zig" },
        highlight = { enable = true },
        indent = { enable = true },
    },
}
