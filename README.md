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

CV の実体は隣のリポジトリ `../cv`（Typst）にある。
このサイトには **ビルド済みの成果物を取り込んでコミットする**。
CI には `../cv` が存在しないため、リポジトリ内に実体が必要になるから。

```sh
bun run sync:cv
```

これで次の 2 つが更新される。

| 取り込み先 | 中身 |
|---|---|
| `public/cv.pdf` | `typst compile` した CV。`/cv.pdf` で配信される |
| `src/data/publications.json` | 業績データ。CV とサイトで同じものを使う |
| `src/data/interests.json` | 研究興味。CV とサイトで同じものを使う |

`../cv` 以外に置いている場合は `CV_DIR=/path/to/cv bun run sync:cv`。

同期したら差分をコミットすること。

## 編集する場所

| ファイル | 内容 |
|---|---|
| `src/data/profile.ts` | 名前・所属・bio・リンク・研究興味 |
| `src/data/publications.json` | 業績（**直接編集しない**。`../cv/publications.json` が正） |
| `src/data/interests.json` | 研究興味（**直接編集しない**。`../cv/interests.json` が正） |
| `src/pages/index.astro` | トップページの構成 |
| `src/styles/global.css` | 配色・タイポグラフィ |

## デプロイ

`main` に push すると `.github/workflows/deploy.yml` が走る。
初回のみ GitHub の Settings → Pages → Source を **GitHub Actions** にする必要がある。
