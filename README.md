# dotfiles

macOS向けのdotfilesを[chezmoi](https://www.chezmoi.io/)で管理するリポジトリです。
パッケージはHomebrew Bundle、tmuxプラグインはTPMで管理します。Nixとhome-managerは使用しません。

## 初回セットアップ

Homebrewをインストールした後、chezmoiとこのリポジトリを用意します。

```sh
brew install chezmoi
git clone git@github.com:himetani/dotfiles.git "$HOME/git/dotfiles"
chezmoi init --source="$HOME/git/dotfiles"
chezmoi diff
chezmoi apply
```

`chezmoi apply`は次の処理も行います。

- `Brewfile`の内容を`brew bundle`で反映する
- TPMを取得し、tmuxプラグインをインストールする
- dotfilesをホームディレクトリへ配置する

既にこのリポジトリをclone済みなら、`brew install chezmoi`以降だけを実行します。

## 日常のメンテナンス

source stateは`$HOME/git/dotfiles`です。リポジトリ側を編集してから差分を確認し、反映します。

```sh
chezmoi diff
chezmoi apply
```

ホームディレクトリ側で変更した場合は、chezmoiへ取り込んでからコミットします。

```sh
chezmoi re-add ~/.zshrc
chezmoi diff
```

パッケージを追加・削除する場合は`Brewfile`を編集します。tmuxプラグインは
`dot_config/tmux/tmux.conf`の`@plugin`行を編集します。対応するrun scriptは入力ファイルが
変わったときだけ再実行されます。

## 検証

```sh
chezmoi doctor
chezmoi managed
chezmoi diff
brew bundle check --file="$HOME/git/dotfiles/Brewfile"
tmux -f "$HOME/.config/tmux/tmux.conf" start-server \; show-options -g >/dev/null
```

chezmoiのsource stateとホームディレクトリは別物です。AI Coding Agentには原則として
このリポジトリを編集させ、`chezmoi diff`を確認してから`chezmoi apply`してください。
