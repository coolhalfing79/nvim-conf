local modes = {
    ["n"]   = "NORMAL",
    ["no"]  = "NORMAL",
    ["v"]   = "VISUAL",
    ["V"]   = "VISUAL LINE",
    [""]  = "VISUAL BLOCK",
    ["s"]   = "SELECT",
    ["S"]   = "SELECT LINE",
    [""]  = "SELECT BLOCK",
    ["i"]   = "INSERT",
    ["ic"]  = "INSERT",
    ["R"]   = "REPLACE",
    ["Rv"]  = "VISUAL REPLACE",
    ["c"]   = "COMMAND",
    ["cv"]  = "VIM EX",
    ["ce"]  = "EX",
    ["r"]   = "PROMPT",
    ["rm"]  = "MOAR",
    ["r?"]  = "CONFIRM",
    ["!"]   = "SHELL",
    ["nt"]  = "TERMINAL",
}
vim.cmd([[
hi StatusLineNormalAccent   guifg=#1E2326 guibg=#93B259
hi StatusLineInsertAccent   guifg=#1E2326 guibg=#E69875
hi StatuslineVisualAccent   guifg=#1E2326 guibg=#DBBC7F
hi StatuslineReplaceAccent  guifg=#1E2326 guibg=#C34043
hi StatusLineTimeAccent     guifg=#1E2326 guibg=#D699B6
hi StatusLineGitAccent      guifg=#D3C6AA guibg=#475258
hi StatusLineFilenameAccent guifg=#D3C6AA guibg=#3D484D
hi StatusLineNormal         guifg=#D3C6AA guibg=#343F44
]])

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatusLineNormalAccent#"
    if current_mode == "n" then
        mode_color = "%#StatuslineNormalAccent#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsertAccent#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    end
    return string.format("%s %s ", mode_color, modes[current_mode]):upper() .. "%#StatusLineNormal#"
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
        return ""
    end
    return "%#StatusLineFilenameAccent# " .. fname .. "%m %r" .. " %#StatusLineNormal#"
end

local function filetype()
    local type = vim.bo.filetype
    if type == "" then
        return ""
    end
    return "%#StatusLineFilenameAccent#   " .. type .. ' %#StatusLineNormal#'
end

local function time()
    return '%#StatusLineTimeAccent#   %{strftime("%H:%M")} '
end
local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return '%#StatusLineGitAccent#  ' .. branch .. ' %#StatusLineNormal#'
    else
        return ""
    end
end


vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
    callback = function()
        vim.b.branch_name = branch_name()
    end
})

Statusline = {}

Statusline.active = function()
    return table.concat {
        mode(),
        vim.b.branch_name,
        filename(),
        " %=% ",
        filetype(),
        time()
    }
end

function Statusline.inactive()
    return " %F"
end

function Statusline.short()
    return "%#StatusLineNC#   NvimTree"
end

vim.cmd([[
augroup Statusline
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
augroup END
]])
