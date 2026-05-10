{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  cachix.pull = [
    "nixpkgs-python"
  ];

  packages = [ pkgs.black ];

  languages.python = {
    enable = true;
    venv.enable = true;
  };

  dotenv.enable = true;

  git-hooks.hooks = {
    shellcheck.enable = true;
    check-added-large-files = {
      enable = true;
    };
    trim-trailing-whitespace = {
      enable = true;
      excludes = [ "(\\.lock|\\.lock\\.hcl)$" ];
    };
    end-of-file-fixer.enable = true;
    nixfmt.enable = true;
    gitleaks = {
      enable = true;
      entry = "${pkgs.gitleaks}/bin/gitleaks git --pre-commit --staged --verbose --redact";
      language = "system";
      stages = [ "pre-commit" ];
      pass_filenames = false;
    };
    black.enable = true;
  };
}
