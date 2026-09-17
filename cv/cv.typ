// Academic CV  —  build:  typst compile cv.typ   /   typst watch cv.typ
// 日本語を本文に書きたい場合も、下の font フォールバックでそのまま通ります。

// ===========================================================================
//  設定
// ===========================================================================
#let full-name = "Ryo Magoshi"
#let my-family-name = "Magoshi" // 業績リストで自動的に太字にする姓

#set document(title: "CV — " + full-name, author: full-name)
#set page(
  paper: "us-letter",
  margin: (x: 1in, top: 0.9in, bottom: 0.9in),
  numbering: "1",
)
#set text(
  font: ("New Computer Modern", "Hiragino Mincho ProN"),
  size: 11pt,
  lang: "en",
)
#set par(justify: true, leading: 0.62em, spacing: 0.9em)

// ===========================================================================
//  スタイル定義
// ===========================================================================

// 大見出し: 太字の大文字
#show heading.where(level: 1): it => block(above: 1.5em, below: 0.6em)[
  #text(size: 11pt, weight: "bold", upper(it.body))
]
// 小見出し: イタリック
#show heading.where(level: 2): it => block(above: 1.0em, below: 0.35em)[
  #text(size: 11pt, style: "italic", it.body)
]

#show link: it => text(fill: rgb("#1a4d8f"), it)

#set list(marker: [--], indent: 0em, body-indent: 0.55em, spacing: 0.55em)
#set enum(indent: 0em, body-indent: 0.55em, spacing: 0.7em)

// 見出しの下の本文を少し字下げするブロック
#let sec(body) = pad(left: 1.2em, body)

// 見出し行 + 右寄せ日付
#let entry(title, date) = grid(
  columns: (1fr, auto),
  align: (left, right),
  strong(title), date,
)

// 著者リスト: 自分の姓を自動で太字に
#let au(..names) = (
  names
    .pos()
    .map(n => {
      if n.contains(my-family-name) { strong(n) } else { n }
    })
    .join(", ")
)

// 業績 1 件: 中身はデータ。描画は publist が行う
#let pub(authors, title, venue, year, url: none, note: none) = (
  authors: authors,
  title: title,
  venue: venue,
  year: year,
  url: url,
  note: note,
)

// 業績 1 件の描画
// URL の行き先に応じた短いラベル（本文に生 URL を出さないため）
#let url-label(u) = {
  if u.contains("arxiv.org") { "arXiv" }
  else if u.contains("isca-archive.org") { "ISCA Archive" }
  else if u.ends-with(".pdf") { "PDF" }
  else { "link" }
}

#let render-pub(p) = [
  #(p.authors). "#(p.title)." #emph(p.venue), #(p.year).
  #if p.note != none [ #strong[(#(p.note))] ]
  #if p.url != none [ #link(p.url)[\[#url-label(p.url)\]] ]
]

// 業績リスト: [J1] [C1] のようなラベル付き
#let publist(prefix, items) = {
  set enum(numbering: n => [#text(weight: "regular")[\[#prefix#n\]]])
  for p in items {
    enum.item(render-pub(p))
  }
}

// 本文から業績を参照: #pubref("C", conf-papers, "Refining Pseudo-Audio") -> [C3]
// タイトルの一部で引くので、論文を足して番号がずれても自動で追従する
#let pubref(prefix, items, title-part) = {
  let i = items.position(p => p.title.contains(title-part))
  if i == none {
    text(fill: red)[\[?#title-part\]]
  } else {
    [\[#prefix#(i + 1)\]]
  }
}

// ===========================================================================
//  業績データ (本文より前で定義: Work Experiences から #pubref で参照するため)
// ===========================================================================
#let interests = json("interests.json")

#let conf-papers = (
  json("publications.json")
    .conference
    .map(p => pub(
      au(..p.authors),
      p.title,
      p.venue,
      p.year,
      url: p.at("url", default: none),
      note: p.at("note", default: none),
    ))
)

// ===========================================================================
//  ヘッダ
// ===========================================================================
#align(
  center,
)[
  #text(size: 17pt, weight: "bold")[#upper(full-name)]
  #v(0.5em, weak: true)
  Kyoto, Japan \
  E-mail #raw("r.magoshi.ma54 [at] gmail.com") \
  #link("https://nagohachi.github.io/")[Homepage] #h(0.8em)
  #link("https://github.com/nagohachi")[GitHub] #h(0.8em)
  #link("https://scholar.google.co.jp/citations?user=hP617uUAAAAJ")[Google Scholar]
]
#v(0.8em)

// One-paragraph summary: your field, headline achievements, and notable awards in
// two or three sentences.

// ===========================================================================
//  本文
// ===========================================================================

= Research Interests
#sec[
  #list(..interests)
]

= Education
#sec[
  #entry(
    "Ph.D. in Computer Science, Kyoto University, Kyoto, Japan",
    "From 04/2027",
  )
  School of Informatics, Kyoto University
  - Supervisor: Tatsuya Kawahara

  #v(0.6em)
  #entry(
    "M.S. in Computer Science, Kyoto University, Kyoto, Japan",
    "04/2025 – 03/2027",
  )
  School of Informatics, Kyoto University
  - Thesis title: _TBD_
  - Supervisor: Tatsuya Kawahara

  #v(0.6em)
  #entry(
    "B.E. in Engineering, Kyoto University, Kyoto, Japan",
    "04/2021 – 03/2025",
  )
  - Supervisor: Tatsuya Kawahara
]

= Work Experiences
#sec[
  #entry("LY Corporation", "08/2025 – 10/2025")
  Research Internship
  - Text-only Domain Adaptation of LLM-based ASR
  - Published as #pubref("C", conf-papers, "Refining Pseudo-Audio Prompts")
]

= Publications
#sec[
  == Conference Papers
  #publist("C", conf-papers)
]

= Technical Strengths
#sec[
  - Languages: Python, C++, TypeScript
  - Frameworks: PyTorch, ESPnet, NeMo, Fairseq, Django, React
]

= Awards
#sec[
  *Best Student Paper Award Nominee* (one of 14 nominees), from INTERSPEECH 2026, Sydney, Australia, nominated August 2026
  - Paper title: "Improving Zero-Shot Phonetic Classification through Language-Agnostic Articulatory Features"
  - #link(
      "https://interspeech2026.org/en-AU/pages/program/best-student-papers",
    )[\[Nominee list\]]
]

