{ config, lib, pkgs, ... }: {
  options.j4ns8i.zsh.enable = lib.mkEnableOption "zsh";
  config =
    let cfg = config.j4ns8i.zsh; in
    lib.mkIf cfg.enable {
      programs.zsh.enable = true;
      programs.zsh.initExtra = ''
        ### BEGIN init from dotfiles/modules/zsh.nix ###

        local function run_in_tmux() {
            tmux new-session
            exit 0 # exit out after the session ends or is detached
        }

        local function run_normally() {
            # Uncomment for profiling
            # zmodload zsh/zprof

            export ZSH_CONFIG_DIR=~/.config/zsh

            fpath=(
                ''${ZSH_CONFIG_DIR}/pure
                $fpath
            )

            # (N) sets NULL_GLOB to return nothing when no matches are found.
            # See `man zshexpn` > Glob Qualifiers.
            for rc in ''${ZSH_CONFIG_DIR}/*.zsh(N); do source $rc; done
            for rc in ''${ZSH_CONFIG_DIR}/share/*.zsh(N); do source $rc; done

            # Uncomment for profiling
            # zprof
        }

        # if TMUX is set or if you don't have tmux, load normally
        if [[ -n "$TMUX" ]] || [[ -f ~/.disable_tmux ]] || ! command -v tmux &>/dev/null; then
            run_normally
        else
            run_in_tmux
        fi

        ### END init from dotfiles/modules/zsh.nix ###
      '';
      home.packages = with pkgs; [ zsh ];
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
        osZsh = if pkgs.stdenv.isDarwin then "darwin.zsh" else "nixos.zsh";
      in {
        ".config/zsh/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
        };
        ".config/zsh/share".source = symlink "${config.j4ns8i.hmDir}/config/zsh/share";
        ".config/zsh/os.zsh".source = symlink "${config.j4ns8i.hmDir}/config/zsh/${osZsh}";
      };
    };
}
