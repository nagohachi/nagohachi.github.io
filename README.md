# nagohachi.github.io

[Astro](https://astro.build/) + [bun](https://bun.sh/) で作った個人サイト。
GitHub Actions で GitHub Pages に自動デプロイされる。

## 開発

```sh
bun install
bun run dev      # http://localhost:4321
bun run build    # dist/ に出力
bun run preview  # ビルド結果を確認
```

## CV の更新

CV の実体は `cv/cv.typ`（Typst）。`bun run dev` / `bun run build` の先頭で
`public/cv.pdf` に自動でコンパイルされるので、手動の同期作業はない。

```sh
bun run build:cv   # PDF だけ作り直したいとき
```

`public/cv.pdf` は生成物なので git 管理外。CI でも同じコマンドで作られる。

VS Code で `cv/cv.typ` を保存すると tinymist が `public/cv.pdf` を直接更新する
（`.vscode/settings.json` の `tinymist.outputPath` 設定による）。

## 編集する場所

| ファイル | 内容 |
|---|---|
| `cv/cv.typ` | CV のレイアウトと本文 |
| `cv/publications.json` | 業績。**CV とサイトが同じファイルを読む** |
| `cv/interests.json` | 研究興味。**CV とサイトが同じファイルを読む** |
| `src/data/profile.ts` | 名前・所属・bio・リンク（サイト専用） |
| `src/pages/index.astro` | トップページの構成 |
| `src/styles/global.css` | 配色・タイポグラフィ・角丸 |

## デプロイ

`main` に push すると `.github/workflows/deploy.yml` が走る。
初回のみ GitHub の Settings → Pages → Source を **GitHub Actions** にする必要がある。
