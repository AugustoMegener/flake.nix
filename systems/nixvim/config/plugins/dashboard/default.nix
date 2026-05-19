{ ... }:
{
  plugins.dashboard = {
    enable = false;
    lazyLoad.enable = false;
    callSetup = false;
    luaConfig.post = ''
      pcall(vim.api.nvim_clear_autocmds, { group = "Dashboard", event = "VimEnter" })
      require("dashboard").setup({
        theme = "doom",
        config = {
          center = {
            {
              icon = "",
              icon_hl = "group",
              desc = "description",
              desc_hl = "group",
              key = "shortcut key in dashboard buffer not keymap !!",
              key_hl = "group",
              key_format = " [%s]",
              action = "",
            },
          },
          footer = {},
          vertical_center = false,
        },
      })
    '';
  };
}
