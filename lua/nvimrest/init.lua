local editor = require("editor")

vim.api.nvim_create_user_command("NvimRest", function()
    editor:create_http_editor()
end, {})
