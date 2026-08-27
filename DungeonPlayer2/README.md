# Dungeon Player2 サイト構成

2026-08-20 に iframe(frameset)構成を廃止し、各ページが独立したURLを持つ通常の静的サイトに変換した。

## 構成

- `index.html` … トップページ（旧 `dp2_top.html` の内容）
- `dp2_*.html` / `diary.html` … 各コンテンツページ。すべて単独で完結し、個別のURL・title・description・OGPを持つ
- `assets/styles.css` … 全ページ共通スタイル
- `assets/_nav.html` … **サイドメニューの原本**
- `assets/menu.js` … スマホ用メニュー開閉
- `assets/pages.css` … ページ個別スタイル。`.content-body` の `page-items` / `page-area` / `page-diary` でスコープ。
  対象ページに `<link rel="stylesheet" href="assets/pages.css">` が必要。
  **ページ固有のCSSは `<head>` に直接書かず、必ずここに追記すること**（共通ナビと衝突するため）
- `sitemap.xml` … 検索エンジン向けURL一覧（ページを追加したら追記すること）
- `top.html` / `dp2_top.html` / `dp2_menu.html` … 旧URL用のリダイレクト（noindex）

## メニューを変更するとき

`assets/_nav.html` を編集してから、次を実行する。全ページに反映される。

    bash tools/update-nav.sh

各ページのメニューを直接編集しないこと（次回の実行で上書きされる）。

## CSS を変更したとき

ブラウザのキャッシュで古いCSSが表示され続けるのを防ぐため、全ページの
`styles.css?v=YYYYMMDD` / `pages.css?v=YYYYMMDD` の日付を更新すること。

    cd DungeonPlayer2
    sed -i "s|.css?v=[0-9]*|.css?v=$(date +%Y%m%d)|g" index.html dp2_*.html diary.html

この番号を上げないと、既存の訪問者には変更が反映されない。

## ページを追加するとき

1. 既存ページをコピーして `<head>` の title / description / canonical / og:* を書き換える
2. `assets/_nav.html` にリンクを追加して `tools/update-nav.sh` を実行
3. `sitemap.xml` に URL を追記

## 未対応（TODO）

- **OGP画像**: `ogp.png`（1200x630）を配置し、全ページの `og:image` に適用済み。（2026-08-21 完了）
- **スクリーンショットの容量**: `ss3.png`(3.6MB) `ss5.png`(5.1MB) `ss7.png`(4.6MB) が重い。
  表示は 710x330 程度なのでリサイズすれば大幅に軽くなる。
- **アクセス解析は導入しない**（2026-08-21 決定）。GA4もGTMも入れない。
  `dp2_information.html` に残る GTM の noscript 断片は動作していないが、放置でよい。
