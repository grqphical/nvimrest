local function split(str, delimiter)
    local result = {}
    for part in string.gmatch(str, "[^" .. delimiter .. "]+") do
        table.insert(result, part)
    end
    return result
end

-- make sure the user has curl installed
local curl_process_result = vim.system({ 'curl', '--version' }):wait(500)

if curl_process_result.code ~= 0 then
    error("curl not found on your system")
    return
end

local curl_cmd = "curl -x %s"

local M = {}

function M:do_request(request)
    local cmd = string.format(curl_cmd, request.method)

    for _, header in ipairs(request.header) do
        cmd = cmd .. string.format(" -H \"%s\"", header)
    end

    cmd = cmd .. " " .. request.url

    local result = vim.system(split(cmd, " "), { text = true }):wait(1000)
    if result.code ~= 0 then
        error(string.format("failed to run HTTP request (curl exit code: %d): %s)", result.code, result.stdout))
    end
    print(result.stdout)
end

return M
