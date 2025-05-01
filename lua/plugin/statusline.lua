local modes = {
    ["n"]  = "N",
    ["no"] = "N",
    ["v"]  = "V",
    ["V"]  = "VISUAL LINE",
    [""]  = "VISUAL BLOCK",
    ["s"]  = "SELECT",
    ["S"]  = "SELECT LINE",
    [""]  = "SELECT BLOCK",
    ["i"]  = "I",
    ["ic"] = "I",
    ["R"]  = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"]  = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"]  = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"]  = "SHELL",
    ["nt"] = "TERMINAL",
}
vim.cmd([[
hi StatusLineAccent         guifg=#252535 guibg=#98BB6C
hi StatusLineInsertAccent   guifg=#252535 guibg=#D27E99
hi StatuslineVisualAccent   guifg=#252535 guibg=#FFA066
hi StatuslineReplaceAccent  guifg=#252535 guibg=#C34043
hi StatusLineFilenameAccent guifg=#DCD7BA guibg=#54546D
hi StatusLineTimeAccent     guifg=#252535 guibg=#938AA9
hi StatusLineGitAccent      guifg=#252535 guibg=#938AA9
hi StatusLineNormal         guifg=#252535 guibg=#2A2A37
]])

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatusLineAccent#"
    if current_mode == "n" then
        mode_color = "%#StatuslineAccent#"
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
    return "%#StatusLineFilenameAccent# " .. fname .. " %#StatusLineNormal#"
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
local function git_branch_name()
    local name = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\\n'")
    if name == '' then
        return ""
    end
    return '%#StatusLineGitAccent#  ' .. name .. ' %#StatusLineNormal#'
end

Statusline = {}

Statusline.active = function()
    return table.concat {
        mode(),
        git_branch_name(),
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
