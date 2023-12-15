{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-jdtls
      lsp-zero-nvim
      nvim-treesitter
    ];
    extraLuaConfig = ''
        vim.g.mapleader = " "
    
        -- Open file explorer with space pv
        vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
        
        -- move highlighted text up / down
        vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
        vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
        
        -- Keep cursor in same place after appending subsequent lines with J
        vim.keymap.set("n", "J", "mzJ`z")
        
        vim.keymap.set("n", "Y", "yg$")
        
        -- Keep cursor in the middle when jumping
        vim.keymap.set("n", "<C-d>", "<C-d>zz")
        vim.keymap.set("n", "<C-u>", "<C-u>zz")
        
        -- Keep cursor in the middle when searching
        vim.keymap.set("n", "n", "nzzzv")
        vim.keymap.set("n", "N", "Nzzv")
        
        -- Move deleted characters to void buffer instead of replacing the current paste buffer
        vim.keymap.set("x", "<leader>p", "\"_dP")
        
        -- Yank to system clipboard
        vim.keymap.set("n", "<leader>y", "\"+y")
        vim.keymap.set("v", "<leader>y", "\"+y")
        
        -- Use C-c instead of Escape or C-[
        vim.keymap.set("i", "<C-c>", "<Esc>")
        
        -- Delete to void register when in normal or visual mode
        vim.keymap.set("n", "<leader>d", "\"_d")
        vim.keymap.set("v", "<leader>d", "\"_d")
        
        -- Remap new line binds to more natural, o and O should be the same (new line below)
        vim.keymap.set("n", "O", "o")
        vim.keymap.set("n", "<leader>o", "O")
        
        -- Undo with Ctrl+R 
        vim.keymap.set("n", "U", "<C-r>")
        
        vim.opt.guicursor = ""
        vim.opt.nu = true
        vim.opt.relativenumber = true
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.cursorcolumn = true
        
        vim.opt.smartindent = true
        vim.opt.wrap = false
        
        vim.opt.swapfile = false
        vim.opt.backup = false
        vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
        vim.opt.undofile = true
        
        vim.opt.hlsearch = false
        vim.opt.incsearch = true
        
        vim.opt.termguicolors = true
        
        vim.opt.scrolloff = 8
        vim.opt.signcolumn = "yes"
        vim.opt.isfname:append("@-@")
        
        vim.opt.updatetime = 50
        
        vim.opt.colorcolumn = "80"
        
        vim.g.mapleader = " "

        local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")
        -- Prevents reinstall of treesitter plugins every boot
        vim.opt.runtimepath:append(parser_install_dir)

        require'nvim-treesitter.configs'.setup {
          ensure_installed = "all",
          parser_install_dir = parser_install_dir, 
          highlight = {
            enable = true,
          },
        }
    '';
  };
}
