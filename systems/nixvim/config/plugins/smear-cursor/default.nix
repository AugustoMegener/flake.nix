{ lib, ... }:
{

  plugins.smear-cursor = {
    enable = true;
    cursor_color = lib.nixvim.mkRaw ''
      function()
      return {
        n = "#f29554",
        i = "#6bc99d",
        v = "#9595d9",
        V = "#9595d9",
        ["\22"] = "#9595d9",
        R = "#f25146",
        c = "#e3a824",
      }[vim.fn.mode()] or "#f29554"
    end
      '';
    opts = {
      smear_between_buffers = true;
      smear_between_neighbor_lines = true;
      scroll_buffer_space = true;
      legacy_computing_symbols_support = false;
      smear_insert_mode = true;
    };
  };

}
