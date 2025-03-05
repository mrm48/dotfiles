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

require("matt.set")
require("matt.lsp")
require("matt.themes")
