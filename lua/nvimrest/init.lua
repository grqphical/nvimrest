local editor = require("nvimrest.editor")

local M = {}

function M:setup()
    vim.api.nvim_create_user_command("NvimRest", function()
        editor:create_http_editor()
    end, {})
end

return M
