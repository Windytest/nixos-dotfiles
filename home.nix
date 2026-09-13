  { config, pkgs, ... }:


{
  home.username = "windy";
  home.homeDirectory = "/home/windy";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  }; 
  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    tree-sitter
  ];
  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/windy/nixos-dotfiles/config/hypr";
    recursive = true;
  };
  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/windy/nixos-dotfiles/config/quickshell";
    recursive = true;
  };
  xdg.configFile."rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/windy/nixos-dotfiles/config/rofi";
    recursive = true;
  };
  xdg.configFile."kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/windy/nixos-dotfiles/config/kitty";
    recursive = true;
  };
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/windy/nixos-dotfiles/config/nvim";
    recursive = true;
  };
}
