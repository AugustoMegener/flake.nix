{ lib, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<cr>";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Telescope git_status<cr>";
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>Telescope git_commits<cr>";
    }
    {
      mode = "n";
      key = "K";
      action = lib.nixvim.mkRaw "vim.lsp.buf.hover";
    }
    {
      mode = "n";
      key = "gd";
      action = lib.nixvim.mkRaw "vim.lsp.buf.definition";
    }
    {
      mode = "n";
      key = "gr";
      action = lib.nixvim.mkRaw "vim.lsp.buf.references";
    }
    {
      mode = "n";
      key = "gi";
      action = lib.nixvim.mkRaw "vim.lsp.buf.implementation";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = lib.nixvim.mkRaw "vim.lsp.buf.rename";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw "vim.lsp.buf.format";
    }
    {
      mode = "n";
      key = "<leader>d";
      action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<cmd>split<cr>";
    }
    {
      mode = "n";
      key = "<leader>v";
      action = "<cmd>vsplit<cr>";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<cr>";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprev<cr>";
    }
  ];
}
