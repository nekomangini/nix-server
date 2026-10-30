{ ... }:

{
  # FIX: keybind conflicts
  programs.fish.functions.fish_user_key_bindings = ''
    # Ctrl+f accept autosuggestion
    # Alt+f accept one word of autosuggestion
    bind \cf accept-autosuggestion
    bind \ef forward-word
  '';
}
