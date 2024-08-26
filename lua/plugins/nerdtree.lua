return {
	{ "preservim/nerdtree",
        init = function()
            vim.cmd([[autocmd VimEnter * NERDTree | wincmd p]]);
	        vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif]])
        end
    }
}
