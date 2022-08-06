local attach_to_buffer = function(output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
   group = vim.api.nvim_create_augroup("autorust", { clear = true }),
   pattern = "main.rs",
   callback = function()
     local append_data = function(_, data)
       if data then
         --vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
         alert(data)
       end
     end
     -- Add a title to the new buffer
     -- Run the application using vim.fn.jobstart
     vim.fn.jobstart(command, {
         stdout_buffered = true,
         on_stdout = append_data,
         on_stderr = append_data,
     })
   end,
 })
 end

 vim.api.nvim_create_user_command("AutoRust", function()
   print "AutoRun starts now"
   local command = vim.fn.input("Command:")
   local pattern = vim.split(vim.fn.input("Pattern:"), " ")
   attach_to_buffer(tonumber(bufnr), pattern, command)
 end, {})

function alert(body)
  require "notify"(body, "info", {title = "Rust output"})
end
