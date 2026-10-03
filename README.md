# nagohachi.github.io

## 開発

```sh
bun install
bun run dev
bun run build
bun run preview
```

## CV の更新

```sh
bun run build:cv
```

## 編集する場所

| ファイル | 内容 |
|---|---|
| `cv/cv.typ` | CV のレイアウトと本文 |
| `cv/publications.json` | 業績 |
| `cv/interests.json` | 興味のある分野 |
| `src/data/profile.ts` | 名前・所属・bio・リンク |
| `src/pages/index.astro` | トップページの構成 |
| `src/styles/global.css` | CSS |
