// @ts-check
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  // リポジトリ名が nagohachi.github.io なので base は不要（ルート配信）。
  // 別名のリポジトリに置く場合は base: "/<repo>/" を足すこと。
  site: "https://nagohachi.github.io",
});
