export const profile = {
  name: "Ryo Magoshi",
  affiliation: "M.S. student, Kyoto University, Kyoto, Japan",
  lab: "Supervised by Prof. Tatsuya Kawahara",
  email: "r.magoshi.ma54@gmail.com",
  // TODO: 自分の言葉に書き換えてください（下は CV の内容から起こした暫定文です）
  bio:
    "I am a master's student at Kyoto University working on speech processing. " +
    "My research centers on multilingual and zero-shot automatic speech recognition, " +
    "articulatory features, and LLM-based ASR.",
  interests: [
    "Speech: Speech Recognition, Speech Synthesis, Speech Translation",
    "Dialogue: Cascaded or Full-duplex Dialogue Systems",
    "Deep Learning: Self-Supervised Learning",
  ],
  links: {
    github: "https://github.com/nagohachi",
    scholar: "https://scholar.google.co.jp/citations?user=hP617uUAAAAJ",
    cv: "/cv.pdf",
  },
  /** 業績リストで強調する姓 */
  familyName: "Magoshi",
} as const;
