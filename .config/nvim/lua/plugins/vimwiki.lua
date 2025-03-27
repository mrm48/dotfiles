return {
    'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_list = {
            { path = '~/vimwiki/notes', syntax = 'markdown', ext = '.md', links_space_char = '-'},
        }
        vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown' }
        vim.g.vimwiki_use_mouse = 1
        vim.g.vimwiki_markdown_link_ext = 1
    end
}
