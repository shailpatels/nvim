return {
    { 'vim-airline/vim-airline',
    dependencies = {
        { 'vim-airline/vim-airline-themes' }
    },
    config = function()
        vim.cmd([[AirlineTheme lucius]])
        vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])
        vim.cmd([[let g:airline#extensions#tabline#formatter= 'unique_tail']])
    end
}

}
