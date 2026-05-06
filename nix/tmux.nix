{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "j"; # prefix = C-j
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    sensibleOnTop = false;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin.overrideAttrs (_: {
          version = "2.3.0";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v2.3.0";
            sha256 = "11qivjsnd7xr2hzjc8rb69fwcxl88qrhd2zkxq6x1w0j510528nw";
          };
        });
        extraConfig = ''
          set -g @catppuccin_flavor "frappe"
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #{b:pane_current_path} #W #F"
          set -g @catppuccin_window_current_text " #{b:pane_current_path} #W #F"

          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -agF status-right "#{E:@catppuccin_status_ram}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      }
      cpu
      battery
      logging
    ];

    extraConfig = ''
      # Cursor motion in tmux command prompt (prefix + :)
      set -g status-keys emacs

      # Save tmux command prompt history
      set -g history-file ~/.tmux_history

      set -g focus-events on

      # True color
      set -sa terminal-overrides ",xterm-ghostty:RGB"

      # -------------------------------------------------------------------
      # Key bindings
      # -------------------------------------------------------------------
      # Double tapping the prefix jumps to last window
      unbind-key c
      bind-key C-j last-window

      # Choose session
      bind-key C-s choose-session

      # Window control
      bind-key n new-window

      # Pane control
      bind-key d split-window -h -c '#{pane_current_path}'
      bind-key C-d split-window -v -c '#{pane_current_path}'

      # Disable confirm before killing
      bind-key x kill-pane

      # Reload configuration
      bind-key C-r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Toggle status bar
      bind-key G set status

      # Copy & Paste
      bind-key -T edit-mode-vi Up send-keys -X history-up
      bind-key -T edit-mode-vi Down send-keys -X history-down
      unbind-key -T copy-mode-vi Space
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      unbind-key -T copy-mode-vi Enter
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      unbind-key -T copy-mode-vi ]
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      unbind-key ]
      bind-key C-p paste-buffer
      unbind-key [
      bind-key C-v copy-mode

      # Equally resize all panes
      bind-key = select-layout even-horizontal
      bind-key | select-layout even-vertical

      # Resize panes
      bind-key J resize-pane -D 10
      bind-key K resize-pane -U 10
      bind-key H resize-pane -L 10
      bind-key L resize-pane -R 10

      # Pane movement
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key tab select-pane -t :.+
      bind-key btab select-pane -t :.-

      # Synchronized panes
      bind-key * set-window-option synchronize-panes
    '';
  };
}
