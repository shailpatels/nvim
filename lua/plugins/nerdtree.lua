return {
	{ "preservim/nerdtree",
        init = function()
            -- automatically open nerdtree
            vim.cmd([[autocmd VimEnter * NERDTree | wincmd p]]);
            -- close nerdtree if its the last buffer
	        vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif]])
            -- open nerdtree in the target dir given
            vim.cmd([[autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif]])
        end
    }
}
