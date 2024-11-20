# packages.nix
{ pkgs }:

with pkgs; [
  # Language Servers
  nodePackages.typescript-language-server
  lua-language-server
  pyright
  nil # Nix LSP
  
  # Formatters and Linters
  stylua       # Lua formatter
  black        # Python formatter
  nixfmt       # Nix formatter
  eslint_d     # JavaScript linter
  
  # Build Tools and Dependencies
  gcc          # Required for TreeSitter
  gnumake
  ripgrep      # Required for Telescope file finding
  fd           # Better find for Telescope
  git          # For git integration
  
  # Optional but recommended
  tree-sitter  # Syntax highlighting
  fzf          # Fuzzy finding
]
