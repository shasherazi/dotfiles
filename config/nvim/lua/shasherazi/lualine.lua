local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local function os_icon()
    local icons = {
      unix = '', -- e712
      dos = '', -- e70f
      mac = '' -- e711
    }
    if vim.fn.has('mac') == 1 then return icons.mac
    elseif vim.fn.has('win32') == 1 then return icons.dos
    else return icons.unix end
end


local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { "mode" },
		lualine_c = { },
		lualine_x = { spaces, "encoding", os_icon,  filetype },
		--[[ lualine_y = { location }, ]]
	  lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
