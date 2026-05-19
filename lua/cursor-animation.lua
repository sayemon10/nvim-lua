local ns = vim.api.nvim_create_namespace("CursorAnimation")

vim.api.nvim_set_hl(0, "CursorAnimationStart", { bg = "#b8bb26", fg = "#282828" }) -- gruvbox green
vim.api.nvim_set_hl(0, "CursorAnimationFade", { bg = "#98971a", fg = "#282828" })
vim.api.nvim_set_hl(0, "CursorAnimationEnd", { bg = "#79740e", fg = "#ebdbb2" })

local function animate_at_cursor()
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1
    local col = pos[2]

    local line_count = vim.api.nvim_buf_line_count(0)
    if row < 0 or row >= line_count then return end

    local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
    if col < 0 or col > #line then return end

    -- Use overlay so it works on empty lines and end-of-line
    local id = vim.api.nvim_buf_set_extmark(0, ns, row, col, {
        virt_text = { { " ", "CursorAnimationStart" } },
        virt_text_pos = "overlay",
        priority = 200,
    })

    if not id then return end

    vim.defer_fn(function()
        pcall(vim.api.nvim_buf_set_extmark, 0, ns, row, col, {
            id = id,
            virt_text = { { " ", "CursorAnimationFade" } },
            virt_text_pos = "overlay",
            priority = 200,
        })
    end, 200)

    vim.defer_fn(function()
        pcall(vim.api.nvim_buf_set_extmark, 0, ns, row, col, {
            id = id,
            virt_text = { { " ", "CursorAnimationEnd" } },
            virt_text_pos = "overlay",
            priority = 200,
        })
    end, 400)

    vim.defer_fn(function()
        pcall(vim.api.nvim_buf_del_extmark, 0, ns, id)
    end, 700)
end

-- Manual command (optional — remove if you don't want it)
vim.api.nvim_create_user_command("AnimateCursor", animate_at_cursor, {})

-- Animate on every cursor movement
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("CursorAnimation", { clear = true }),
    callback = animate_at_cursor,
})

-- Animate at startup
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("CursorAnimationStartup", { clear = true }),
    callback = function()
        vim.defer_fn(animate_at_cursor, 100)
    end,
})
