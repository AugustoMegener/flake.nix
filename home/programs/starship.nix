{ ... }:
{
  programs.starship = {
    enable = true;

    settings = {

      "$schema" = "https://starship.rs/config-schema.json";

      format = ''
        [╭](bold)\
        [](color_red)\
        [☭](bold bg:color_red)\
        $username\
        [](bg:color_yellow fg:color_red)\
        $directory\
        [](fg:color_yellow bg:color_blue)\
        $git_branch\
        $git_status\
        [](fg:color_blue bg:color_green)\
        $c\
        $cpp\
        $rust\
        $golang\
        $nodejs\
        $php\
        $java\
        $kotlin\
        $haskell\
        $python\
        [](fg:color_green bg:color_bg3)\
        $docker_context\
        $conda\
        $pixi\
        [](fg:color_bg3 bg:color_bg1)\
        $time\
        [ ](fg:color_bg1)\
        $nix_shell\
        $line_break$character
      '';

      palette = "gruvbox_dark";

      palettes.gruvbox_dark = {
        color_fg0 = "#ead9c5";
        color_bg1 = "#40392d";
        color_bg3 = "#312b24";
        color_blue = "#4eb0cf";
        color_aqua = "#689d6a";
        color_green = "#6bc99d";
        color_orange = "#f29554";
        color_purple = "#9595d9";
        color_red = "#f25146";
        color_yellow = "#e3a824";
      };

      os = {
        disabled = false;
        style = "bg:color_red fg:color_fg0";
      };

      os.symbols = {
        Windows = "󰍲";
        Ubuntu = "";
        SUSE = "";
        Raspbian = "󰐿";
        Mint = "󰣭";
        Macos = "󰀵";
        Manjaro = "";
        Linux = "󰌽";
        Gentoo = "󰣨";
        Fedora = "󰣛";
        Alpine = "";
        Amazon = "";
        Android = "";
        AOSC = "";
        Arch = "󰣇";
        Artix = "󰣇";
        EndeavourOS = "";
        CentOS = "";
        Debian = "󰣚";
        Redhat = "󱄛";
        RedHatEnterprise = "󱄛";
        Pop = "";
      };

      username = {
        show_always = true;
        style_user = "bg:color_red fg:color_fg0";
        style_root = "bg:color_red fg:color_fg0";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:color_bg3 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Documentos" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Musicas" = "󰝚 ";
        "Pictures" = " ";
        "Fotos" = " ";
        "Developer" = "󰲋 ";
        ".config"=" ";
        "nixos"=" ";
        "Vault"=" ";
      };

      git_branch = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_blue)]($style)";
      };

      git_status = {
        style = "bg:color_blue";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_blue)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      java = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_green)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      pixi = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      nix_shell = {
        disabled = false;
        impure_msg = " ";
        pure_msg = " ";
        unknown_msg = "󰞋 ";
        format = ''

        [│](bold)[ $symbol$state$name]($style)'';
        symbol = "󱄅 ";
        style = "bold fg:color_blue";

        line_break = {
          disabled = false;
        };
      };

      character = {
        disabled = false;
        success_symbol = "[╰─](bold)[󰗧─➤](bold fg:color_green)";
        error_symbol = "[╰─](bold)[󰗧─➤](bold fg:color_red)";
        vimcmd_symbol = "[╰─](bold)[─➤](bold fg:color_yellow)";
        vimcmd_replace_one_symbol = "[╰─](bold)[─➤](bold fg:color_red)";
        vimcmd_replace_symbol = "[╰─](bold)[─➤](bold fg:color_red)";
        vimcmd_visual_symbol = "[╰─](bold)[󰒅─➤](bold fg:color_purple)";
      };
    };
  };
}
