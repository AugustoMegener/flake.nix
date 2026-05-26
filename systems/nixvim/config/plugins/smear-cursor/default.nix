{ pkgs, lib, ... }:
{

  plugins.smear-cursor = {
    enable = true;
    settigngs = {
      opts = {
        smear_between_buffers = true;
        smear_between_neighbor_lines = true;
        scroll_buffer_space = true;
        legacy_computing_symbols_support = false;
        smear_insert_mode = true;
      };
    };
  };

}
