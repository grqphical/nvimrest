-- make sure the user has curl installed
local curl_process_result = vim.system({ 'curl', '--version' }):wait(500)

if curl_process_result.code ~= 0 then
    error("curl not found on your system")
    return
end

local M = {}

return M
