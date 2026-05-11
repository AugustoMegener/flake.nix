{ ... }:
{
  globals = {
    mapleader = "ç";
    maplocalleader = "ç";
  };

  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
    signcolumn = "yes";
    scrolloff = 8;
    sidescrolloff = 8;
    wrap = false;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;
    splitbelow = true;
    splitright = true;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    updatetime = 50;
    timeoutlen = 300;
    completeopt = "menu,menuone,noselect";
    pumheight = 10;
    showmode = false;
    winborder = "rounded";
    clipboard = "unnamedplus";
    undofile = true;
    spell = false;
    guicursor = "n-v-c:block-Cursor,i:ver25-Cursor,r:hor20-Cursor";
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
    conceallevel = 2;
  };

  extraConfigLua = ''
    vim.diagnostic.config({
      signs = true,
      underline = true,
      update_in_insert = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text", "gitcommit" },
      callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "pt,en"
      end,
    })

    local orig_virtual_text = vim.diagnostic.handlers.virtual_text

    vim.diagnostic.handlers.virtual_text = {
      show = function(ns, bufnr, diagnostics, opts)
        diagnostics = vim.tbl_filter(function(diagnostic)
          return diagnostic.source ~= "spell"
        end, diagnostics)

        orig_virtual_text.show(ns, bufnr, diagnostics, opts)
      end,
      hide = orig_virtual_text.hide,
    }
  '';
}
