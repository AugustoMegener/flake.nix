{ pkgs, inputs, ... }:
let
  gradlePlugin = pkgs.stdenv.mkDerivation {
    name = "gradle-nvim";
    src = inputs.gradle-nvim;
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };

  gradlewNix = pkgs.writeShellScriptBin "gradlew-nix" ''
    exec nixGLIntel ./gradlew "$@"
  '';

  javaDebugExtension = pkgs.vscode-extensions.vscjava.vscode-java-debug;
  javaDebugJar = "${javaDebugExtension}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-0.53.1.jar";
in
{
  extraPlugins = [
    pkgs.vimPlugins.nvim-dap
    gradlePlugin
  ];

  extraConfigLua = ''
    local dap = require("dap")

    dap.adapters.java = {
      type = "executable",
      command = "java",
      args = { "-jar", "${javaDebugJar}" },
    }

    dap.configurations.java = {
      {
        type = "java",
        name = "Debug (Launch) - Current File",
        request = "launch",
        mainClass = function()
          return vim.fn.input("Main class: ", vim.fn.expand("%:t:r"))
        end,
        projectName = function()
          return vim.fn.input("Project name: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        end,
      },
    }

    require("gradle").setup({
      gradle_executable = "${gradlewNix}/bin/gradlew-nix",
    })

    local map = vim.keymap.set
    map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    map("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
  '';
}
