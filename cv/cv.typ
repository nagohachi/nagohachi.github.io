#let full-name = "Ryo Magoshi"
#let my-family-name = "Magoshi"

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
  hyphenate: false,
)
#set par(justify: true, leading: 0.62em, spacing: 0.9em)

#show heading.where(level: 1): it => block(above: 1.5em, below: 0.6em)[
  #text(size: 11pt, weight: "bold", upper(it.body))
]
#show heading.where(level: 2): it => block(above: 1.0em, below: 0.35em)[
  #text(size: 11pt, style: "italic", it.body)
]

#show link: it => text(fill: rgb("#1a4d8f"), it)

#set list(marker: [--], indent: 0em, body-indent: 0.55em, spacing: 0.55em)
#set enum(indent: 0em, body-indent: 0.55em, spacing: 0.7em)

#let sec(body) = pad(left: 1.2em, body)

#let entry(title, date) = grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: (left, right),
  strong(title), date,
)

#let au(..names) = (
  names
    .pos()
    .map(n => {
      if n.contains(my-family-name) { strong(n) } else { n }
    })
    .join(", ")
)

#let pub(authors, title, venue, year, url: none, note: none, first: false, status: none) = (
  authors: authors,
  first: first,
  status: status,
  title: title,
  venue: venue,
  year: year,
  url: url,
  note: note,
)

#let url-label(u) = {
  if u.contains("arxiv.org") { "arXiv" } else if u.contains("isca-archive.org") { "ISCA Archive" } else if u.ends-with(
    ".pdf",
  ) { "PDF" } else { "link" }
}

// ハイフンを含む語の途中で改行しない（改行するとテキスト抽出で "Zero-Shot" が "ZeroShot" になる）
#let render-pub(p) = [
  #show regex("\\w+(-\\w+)+"): box
  #(p.authors). "#(p.title)." #emph(p.venue), #(p.year)#if p.status != none [ (#p.status)].
  #if p.note != none [ #strong[(#(p.note))] ]
  #if p.url != none [ #link(p.url)[\[#url-label(p.url)\]] ]
]

#let publist(prefix, items, start: 1) = {
  set enum(numbering: n => [#text(weight: "regular")[\[#prefix#n\]]], start: start)
  for p in items {
    enum.item(render-pub(p))
  }
}

#let pubref(prefix, items, title-part) = {
  let i = items.position(p => p.title.contains(title-part))
  if i == none {
    text(fill: red)[\[?#title-part\]]
  } else {
    [\[#prefix#(i + 1)\]]
  }
}

// Work Experience の #pubref より前で定義する必要がある
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
      first: p.authors.at(0).contains(my-family-name),
      status: p.at("status", default: none),
    ))
)

// 主著の論文を先に並べ、番号は主著から共著へ通しで振る
#let first-papers = conf-papers.filter(p => p.first)
#let co-papers = conf-papers.filter(p => not p.first)
#let ordered-papers = first-papers + co-papers

#align(
  center,
)[
  #text(size: 17pt, weight: "bold")[#upper(full-name)]
  #v(0.5em, weak: true)
  Yoshida Honmachi, Sakyo-ku, Kyoto, Japan \
  E-mail: #"r.magoshi.ma54@gmail.com" \
  Homepage: #link("https://nagohachi.github.io/") \
  GitHub: #link("https://github.com/nagohachi") \
  Google Scholar: #link("https://scholar.google.co.jp/citations?user=hP617uUAAAAJ")
]
#v(0.8em)

Graduate student at Kyoto University focusing on multilingual ASR and speech LLMs.
Currently completing an M.S.; admitted to the Ph.D. program starting April 2027.
First author of four papers at INTERSPEECH and IEEE SLT,
one of which was nominated for the Best Student Paper Award at INTERSPEECH 2026.

= Research Interests
#sec[
  #list(..interests)
]

= Education
#sec[
  #entry(
    "Ph.D. (admitted) in Informatics, Kyoto University, Kyoto, Japan",
    "Starting 04/2027",
  )
  Graduate School of Informatics, Kyoto University
  - Supervisor: Tatsuya Kawahara

  #v(0.6em)
  #entry(
    "M.S. in Informatics, Kyoto University, Kyoto, Japan",
    "04/2025 – 03/2027",
  )
  Graduate School of Informatics, Kyoto University
  - Thesis title: _LLM-based Speech Recognition for Low-Resource Languages and Domains_
  - Supervisor: Tatsuya Kawahara

  #v(0.6em)
  #entry(
    "B.E., Kyoto University, Kyoto, Japan",
    "04/2021 – 03/2025",
  )
  Undergraduate School of Informatics and Mathematical Science, Faculty of Engineering
  - Supervisor: Tatsuya Kawahara
]

= Publications
#sec[
  == Conference Papers (First Author)
  #publist("C", first-papers)

  == Conference Papers (Co-Author)
  #publist("C", co-papers, start: first-papers.len() + 1)
]

= Awards
#sec[
  *Best Student Paper Award Nominee* (one of 14 nominees), from INTERSPEECH 2026, Sydney, Australia, nominated August 2026
  - Paper title: "Improving Zero-Shot Phonetic Classification through Language-Agnostic Articulatory Features"
  - #link(
      "https://interspeech2026.org/en-AU/pages/program/best-student-papers",
    )[\[Nominee list\]]
]

= Work Experience
#sec[
  #entry("LY Corporation", "08/2025 – 10/2025")
  Research Internship
  - Worked on text-only domain adaptation as a form of post-training for LLM-based ASR, improving word error rate and out-of-vocabulary recall by about 20% (relative)
  - Published as #pubref("C", ordered-papers, "Refining Pseudo-Audio Prompts")
]

= Technical Strengths
#sec[
  - Languages: Python, C++, TypeScript
  - Frameworks: PyTorch, ESPnet, NeMo, Megatron-LM, NeMo-RL, ms-swift, Fairseq, Django, React
]
