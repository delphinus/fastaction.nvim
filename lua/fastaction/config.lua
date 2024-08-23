local M = {}
local m = {}

---@type FastActionConfig
m.defaults = {
    dismiss_keys = { 'j', 'k', '<c-c>', 'q' },
    keys = 'qwertyuiopasdfghlzxcvbnm',
    override_function = function(_) end,
    popup = {
        border = 'rounded',
        hide_cursor = true,
        highlight = {
            divider = 'FloatBorder',
            key = 'MoreMsg',
            title = 'Title',
            window = 'NormalFloat',
        },
        title = 'Select one of:',
    },
    priority = {},
    register_ui_select = false,
}
---@type FastActionConfig
m.config = {}

---@param opts FastActionConfig
function M.resolve(opts) m.config = vim.tbl_deep_extend('force', m.defaults, opts) end

---@return FastActionConfig
function M.get() return m.config end

---@param filetype string
---@return string[]
function M.get_priority_keys(filetype)
    ---@type string[]
    local keys = {}
    for _, v in ipairs(m.config.priority[filetype]) do
        keys[#keys + 1] = v.key
    end
    return keys
end

---@return string[]
function M.get_keys()
    ---@type string[]
    local keys
    if type(m.config.keys) == 'table' then
        keys = m.config.keys --[=[@as string[]]=]
    elseif type(m.config.keys) == 'string' then
        keys = vim.split(m.config.keys --[=[@as string]=], '', { trimempty = true })
    end
    return keys
end

return M
