local curl = require("nvimrest.curl")

local template = { "method: GET",
    "url: https://httpbin.org/get",
    "header: User-Agent: nvimrest/1.0",
    "header: Accept: *",
    "body: {\"foo\": \"bar\"}"
}

local M = {}

function M:parse_request()
    local lines = vim.api.nvim_buf_get_lines(M.buf, 0, -1, false)

    local request = {
        url = "",
        method = "",
        header = {},
    }

    for _, line in ipairs(lines) do
        if string.match(line, "^url") then
            request.url = string.sub(line, #"url: " + 1, #line)
        elseif string.match(line, "^method") then
            request.method = string.sub(line, #"method: " + 1, #line)
        elseif string.match(line, "^header") then
            table.insert(request.header, string.sub(line, #"header: " + 1, #line))
        end
    end

    return request
end

function M:create_http_editor()
    M.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[M.buf].buftype = ""
    vim.api.nvim_buf_set_name(M.buf, "NvimRest")

    vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, template)
    vim.api.nvim_set_current_buf(M.buf)

    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = M.buf,
        callback = function()
            local request = M:parse_request()
            curl:do_request(request)
        end,
    })
end

return M
