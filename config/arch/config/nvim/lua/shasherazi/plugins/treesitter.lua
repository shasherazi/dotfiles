return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local disabled = {
      TelescopePrompt = true,
      minifiles = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local bt = vim.bo[args.buf].buftype

        -- skip prompts, special buffers, and known non-parser filetypes
        if bt ~= "" or disabled[ft] then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft

        -- auto-install only for real filetypes
        pcall(function()
          require("nvim-treesitter").install({ lang }):wait(300000)
        end)

        pcall(vim.treesitter.start, args.buf, lang)

        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        vim.bo[args.buf].indentexpr =
        "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
