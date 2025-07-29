local template = { "method: GET",
    "url: https://httpbin.org/get",
    "header: User-Agent: nvimrest/1.0",
    "header: Accept: *",
    "body: {\"foo\": \"bar\"}"
}

local M = {}

function M:create_http_editor()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = ""
    vim.api.nvim_buf_set_name(buf, "NvimRest")

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, template)
    vim.api.nvim_set_current_buf(buf)

    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = buf,
        callback = function(args)
            local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
            local text = table.concat(lines, "\n")
            print("User tried to save! Full text:")
            print(text)
        end,
    })
end

return M
