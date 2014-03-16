;; -*- mode: emacs-lisp; coding: utf-8 -*-

;; (skk-restart)
;; skk-search-prog-list                 ; => ((skk-search-kakutei-jisyo-file skk-kakutei-jisyo 10000 t) (skk-search-jisyo-file skk-initial-search-jisyo 10000 t) (skk-search-jisyo-file skk-jisyo 0 t) (skk-okuri-search) (skk-search-jisyo-file skk-large-jisyo 10000) (skk-search-server skk-aux-large-jisyo 10000))
;; skk-kakutei-jisyo                    ; => nil
;; skk-initial-search-jisyo             ; => nil
;; skk-jisyo                            ; => "/home/mikagami/.skk/jisyo"
;; skk-large-jisyo                      ; => "/usr/share/skk/SKK-JISYO.L"

;; (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")
(setq skk-server-host "localhost")
(setq skk-server-portnum 11178)
(setq skk-server-report-response t)

(setq skk-preload t)
(setq skk-isearch-start-mode 'latin)
(setq skk-egg-like-newline t)
(setq skk-undo-kakutei-word-only t)

(setq skk-process-okuri-early nil)
(setq skk-henkan-strict-okuri-precedence t)
(setq skk-special-midashi-char-list '())

(setq skk-set-henkan-point-key
  '(?A ?B ?C ?D ?E ?F ?G ?H ?I ?J ?K ?L ?M ?N ?P ?R ?S ?T ?U ?V ?W ?Y ?X ?Z ?< ?> ?+ ??))

(setq skk-downcase-alist
      '((?< . ?,)
        (?> . ?.)
        (?+ . ?\;)
        (?? . ?/)))

(setq skk-rom-kana-base-rule-list
      '(("ql" nil skk-latin-mode)
        ("\C-q" nil skk-toggle-kana)
        ("qL" nil skk-jisx0208-latin-mode)
        ("qq" nil skk-set-henkan-point-subr)
        ("Q" nil skk-purge-from-jisyo)
        ("q/" nil skk-abbrev-mode)
        ("q$" nil skk-display-code-for-char-at-point)
        ("q@" nil skk-today)
        ("q\\" nil skk-input-by-code-or-menu)
        (skk-kakutei-key nil skk-kakutei)))

(setq skk-rom-kana-rule-list
      '(("j" nil ("ア" . "あ"))
        ("u" nil ("アイ" . "あい"))
        ("m" nil ("アン" . "あん"))
        ("l" nil ("イ" . "い"))
        ("." nil ("イン" . "いん"))
        ("h" nil ("ウ" . "う"))
        ("y" nil ("ウウ" . "うう"))
        ("n" nil ("ウン" . "うん"))
        (";" nil ("エ" . "え"))
        ("p" nil ("エイ" . "えい"))
        ("/" nil ("エン" . "えん"))
        ("k" nil ("オ" . "お"))
        ("i" nil ("オウ" . "おう"))
        ("," nil ("オン" . "おん"))
        ("fj" nil ("カ" . "か"))
        ("fu" nil ("カイ" . "かい"))
        ("fm" nil ("カン" . "かん"))
        ("fl" nil ("キ" . "き"))
        ("f." nil ("キン" . "きん"))
        ("fh" nil ("ク" . "く"))
        ("fy" nil ("クウ" . "くう"))
        ("fn" nil ("クン" . "くん"))
        ("f;" nil ("ケ" . "け"))
        ("fp" nil ("ケイ" . "けい"))
        ("f/" nil ("ケン" . "けん"))
        ("fk" nil ("コ" . "こ"))
        ("fi" nil ("コウ" . "こう"))
        ("f," nil ("コン" . "こん"))
        ("dj" nil ("サ" . "さ"))
        ("du" nil ("サイ" . "さい"))
        ("dm" nil ("サン" . "さん"))
        ("dl" nil ("シ" . "し"))
        ("d." nil ("シン" . "しん"))
        ("dh" nil ("ス" . "す"))
        ("dy" nil ("スウ" . "すう"))
        ("dn" nil ("スン" . "すん"))
        ("d;" nil ("セ" . "せ"))
        ("dp" nil ("セイ" . "せい"))
        ("d/" nil ("セン" . "せん"))
        ("dk" nil ("ソ" . "そ"))
        ("di" nil ("ソウ" . "そう"))
        ("d," nil ("ソン" . "そん"))
        ("sj" nil ("タ" . "た"))
        ("su" nil ("タイ" . "たい"))
        ("sm" nil ("タン" . "たん"))
        ("sl" nil ("チ" . "ち"))
        ("s." nil ("チン" . "ちん"))
        ("sh" nil ("ツ" . "つ"))
        ("sy" nil ("ツウ" . "つう"))
        ("sn" nil ("ツン" . "つん"))
        ("s;" nil ("テ" . "て"))
        ("sp" nil ("テイ" . "てい"))
        ("s/" nil ("テン" . "てん"))
        ("sk" nil ("ト" . "と"))
        ("si" nil ("トウ" . "とう"))
        ("s," nil ("トン" . "とん"))
        ("aj" nil ("ナ" . "な"))
        ("au" nil ("ナイ" . "ない"))
        ("am" nil ("ナン" . "なん"))
        ("al" nil ("ニ" . "に"))
        ("a." nil ("ニン" . "にん"))
        ("ah" nil ("ヌ" . "ぬ"))
        ("ay" nil ("ヌウ" . "ぬう"))
        ("an" nil ("ヌン" . "ぬん"))
        ("a;" nil ("ネ" . "ね"))
        ("ap" nil ("ネイ" . "ねい"))
        ("a/" nil ("ネン" . "ねん"))
        ("ak" nil ("ノ" . "の"))
        ("ai" nil ("ノウ" . "のう"))
        ("a," nil ("ノン" . "のん"))
        ("tj" nil ("ハ" . "は"))
        ("tu" nil ("ハイ" . "はい"))
        ("tm" nil ("ハン" . "はん"))
        ("tl" nil ("ヒ" . "ひ"))
        ("t." nil ("ヒン" . "ひん"))
        ("th" nil ("フ" . "ふ"))
        ("ty" nil ("フウ" . "ふう"))
        ("tn" nil ("フン" . "ふん"))
        ("t;" nil ("ヘ" . "へ"))
        ("tp" nil ("ヘイ" . "へい"))
        ("t/" nil ("ヘン" . "へん"))
        ("tk" nil ("ホ" . "ほ"))
        ("ti" nil ("ホウ" . "ほう"))
        ("t," nil ("ホン" . "ほん"))
        ("rj" nil ("マ" . "ま"))
        ("ru" nil ("マイ" . "まい"))
        ("rm" nil ("マン" . "まん"))
        ("rl" nil ("ミ" . "み"))
        ("r." nil ("ミン" . "みん"))
        ("rh" nil ("ム" . "む"))
        ("ry" nil ("ムウ" . "むう"))
        ("rn" nil ("ムン" . "むん"))
        ("r;" nil ("メ" . "め"))
        ("rp" nil ("メイ" . "めい"))
        ("r/" nil ("メン" . "めん"))
        ("rk" nil ("モ" . "も"))
        ("ri" nil ("モウ" . "もう"))
        ("r," nil ("モン" . "もん"))
        ("gj" nil ("ヤ" . "や"))
        ("gu" nil ("ヤイ" . "やい"))
        ("gm" nil ("ヤン" . "やん"))
        ("gl" nil ("イ" . "い"))
        ("g." nil ("イン" . "いん"))
        ("gh" nil ("ユ" . "ゆ"))
        ("gy" nil ("ユウ" . "ゆう"))
        ("gn" nil ("ユン" . "ゆん"))
        ("g;" nil ("イェ" . "いぇ"))
        ("gp" nil ("イェイ" . "いぇい"))
        ("g/" nil ("イェン" . "いぇん"))
        ("gk" nil ("ヨ" . "よ"))
        ("gi" nil ("ヨウ" . "よう"))
        ("g," nil ("ヨン" . "よん"))
        ("ej" nil ("ラ" . "ら"))
        ("eu" nil ("ライ" . "らい"))
        ("em" nil ("ラン" . "らん"))
        ("el" nil ("リ" . "り"))
        ("e." nil ("リン" . "りん"))
        ("eh" nil ("ル" . "る"))
        ("ey" nil ("ルウ" . "るう"))
        ("en" nil ("ルン" . "るん"))
        ("e;" nil ("レ" . "れ"))
        ("ep" nil ("レイ" . "れい"))
        ("e/" nil ("レン" . "れん"))
        ("ek" nil ("ロ" . "ろ"))
        ("ei" nil ("ロウ" . "ろう"))
        ("e," nil ("ロン" . "ろん"))
        ("wj" nil ("ワ" . "わ"))
        ("wu" nil ("ワイ" . "わい"))
        ("wm" nil ("ワン" . "わん"))
        ("wl" nil ("ウィ" . "うぃ"))
        ("w." nil ("ウィン" . "うぃん"))
        ("wh" nil ("ウ" . "う"))
        ("wy" nil ("ウウ" . "うう"))
        ("wn" nil ("ウン" . "うん"))
        ("w;" nil ("ウェ" . "うぇ"))
        ("wp" nil ("ウェイ" . "うぇい"))
        ("w/" nil ("ウェン" . "うぇん"))
        ("wk" nil ("ヲ" . "を"))
        ("wi" nil ("ヲウ" . "をう"))
        ("w," nil ("ヲン" . "をん"))
        ("vj" nil ("ガ" . "が"))
        ("vu" nil ("ガイ" . "がい"))
        ("vm" nil ("ガン" . "がん"))
        ("vl" nil ("ギ" . "ぎ"))
        ("v." nil ("ギン" . "ぎん"))
        ("vh" nil ("グ" . "ぐ"))
        ("vy" nil ("グウ" . "ぐう"))
        ("vn" nil ("グン" . "ぐん"))
        ("v;" nil ("ゲ" . "げ"))
        ("vp" nil ("ゲイ" . "げい"))
        ("v/" nil ("ゲン" . "げん"))
        ("vk" nil ("ゴ" . "ご"))
        ("vi" nil ("ゴウ" . "ごう"))
        ("v," nil ("ゴン" . "ごん"))
        ("cj" nil ("ザ" . "ざ"))
        ("cu" nil ("ザイ" . "ざい"))
        ("cm" nil ("ザン" . "ざん"))
        ("cl" nil ("ジ" . "じ"))
        ("c." nil ("ジン" . "じん"))
        ("ch" nil ("ズ" . "ず"))
        ("cy" nil ("ズウ" . "ずう"))
        ("cn" nil ("ズン" . "ずん"))
        ("c;" nil ("ゼ" . "ぜ"))
        ("cp" nil ("ゼイ" . "ぜい"))
        ("c/" nil ("ゼン" . "ぜん"))
        ("ck" nil ("ゾ" . "ぞ"))
        ("ci" nil ("ゾウ" . "ぞう"))
        ("c," nil ("ゾン" . "ぞん"))
        ("xj" nil ("ダ" . "だ"))
        ("xu" nil ("ダイ" . "だい"))
        ("xm" nil ("ダン" . "だん"))
        ("xl" nil ("ヂ" . "ぢ"))
        ("x." nil ("ヂン" . "ぢん"))
        ("xh" nil ("ヅ" . "づ"))
        ("xy" nil ("ヅウ" . "づう"))
        ("xn" nil ("ヅン" . "づん"))
        ("x;" nil ("デ" . "で"))
        ("xp" nil ("デイ" . "でい"))
        ("x/" nil ("デン" . "でん"))
        ("xk" nil ("ド" . "ど"))
        ("xi" nil ("ドウ" . "どう"))
        ("x," nil ("ドン" . "どん"))
        ("bj" nil ("バ" . "ば"))
        ("bu" nil ("バイ" . "ばい"))
        ("bm" nil ("バン" . "ばん"))
        ("bl" nil ("ビ" . "び"))
        ("b." nil ("ビン" . "びん"))
        ("bh" nil ("ブ" . "ぶ"))
        ("by" nil ("ブウ" . "ぶう"))
        ("bn" nil ("ブン" . "ぶん"))
        ("b;" nil ("ベ" . "べ"))
        ("bp" nil ("ベイ" . "べい"))
        ("b/" nil ("ベン" . "べん"))
        ("bk" nil ("ボ" . "ぼ"))
        ("bi" nil ("ボウ" . "ぼう"))
        ("b," nil ("ボン" . "ぼん"))
        ("zj" nil ("パ" . "ぱ"))
        ("zu" nil ("パイ" . "ぱい"))
        ("zm" nil ("パン" . "ぱん"))
        ("zl" nil ("ピ" . "ぴ"))
        ("z." nil ("ピン" . "ぴん"))
        ("zh" nil ("プ" . "ぷ"))
        ("zy" nil ("プウ" . "ぷう"))
        ("zn" nil ("プン" . "ぷん"))
        ("z;" nil ("ペ" . "ぺ"))
        ("zp" nil ("ペイ" . "ぺい"))
        ("z/" nil ("ペン" . "ぺん"))
        ("zk" nil ("ポ" . "ぽ"))
        ("zi" nil ("ポウ" . "ぽう"))
        ("z," nil ("ポン" . "ぽん"))
        ("dfj" nil ("ァ" . "ぁ"))
        ("dfu" nil ("ァイ" . "ぁい"))
        ("dfm" nil ("ァン" . "ぁん"))
        ("dfl" nil ("ィ" . "ぃ"))
        ("df." nil ("ィン" . "ぃん"))
        ("dfh" nil ("ゥ" . "ぅ"))
        ("dfy" nil ("ゥウ" . "ぅう"))
        ("dfn" nil ("ゥン" . "ぅん"))
        ("df;" nil ("ェ" . "ぇ"))
        ("dfp" nil ("ェイ" . "ぇい"))
        ("df/" nil ("ェン" . "ぇん"))
        ("dfk" nil ("ォ" . "ぉ"))
        ("dfi" nil ("ォウ" . "ぉう"))
        ("df," nil ("ォン" . "ぉん"))
        ("dsj" nil ("ウ゛ァ" . "う゛ぁ"))
        ("dsu" nil ("ウ゛ァイ" . "う゛ぁい"))
        ("dsm" nil ("ウ゛ァン" . "う゛ぁん"))
        ("dsl" nil ("ウ゛ィ" . "う゛ぃ"))
        ("ds." nil ("ウ゛ィン" . "う゛ぃん"))
        ("dsh" nil ("ウ゛" . "う゛"))
        ("dsy" nil ("ウ゛ウ" . "う゛う"))
        ("dsn" nil ("ウ゛ン" . "う゛ん"))
        ("ds;" nil ("ウ゛ェ" . "う゛ぇ"))
        ("dsp" nil ("ウ゛ェイ" . "う゛ぇい"))
        ("ds/" nil ("ウ゛ェン" . "う゛ぇん"))
        ("dsk" nil ("ウ゛ォ" . "う゛ぉ"))
        ("dsi" nil ("ウ゛ォウ" . "う゛ぉう"))
        ("ds," nil ("ウ゛ォン" . "う゛ぉん"))
        ("daj" nil ("ファ" . "ふぁ"))
        ("dau" nil ("ファイ" . "ふぁい"))
        ("dam" nil ("ファン" . "ふぁん"))
        ("dal" nil ("フィ" . "ふぃ"))
        ("da." nil ("フィン" . "ふぃん"))
        ("dah" nil ("フ" . "ふ"))
        ("day" nil ("フウ" . "ふう"))
        ("dan" nil ("フン" . "ふん"))
        ("da;" nil ("フェ" . "ふぇ"))
        ("dap" nil ("フェイ" . "ふぇい"))
        ("da/" nil ("フェン" . "ふぇん"))
        ("dak" nil ("フォ" . "ふぉ"))
        ("dai" nil ("フォウ" . "ふぉう"))
        ("da," nil ("フォン" . "ふぉん"))
        ("fdj" nil ("キャ" . "きゃ"))
        ("fdu" nil ("キャイ" . "きゃい"))
        ("fdm" nil ("キャン" . "きゃん"))
        ("fdl" nil ("キィ" . "きぃ"))
        ("fd." nil ("キィン" . "きぃん"))
        ("fdh" nil ("キュ" . "きゅ"))
        ("fdy" nil ("キュウ" . "きゅう"))
        ("fdn" nil ("キュン" . "きゅん"))
        ("fd;" nil ("キェ" . "きぇ"))
        ("fdp" nil ("キェイ" . "きぇい"))
        ("fd/" nil ("キェン" . "きぇん"))
        ("fdk" nil ("キョ" . "きょ"))
        ("fdi" nil ("キョウ" . "きょう"))
        ("fd," nil ("キョン" . "きょん"))
        ("dgj" nil ("シャ" . "しゃ"))
        ("dgu" nil ("シャイ" . "しゃい"))
        ("dgm" nil ("シャン" . "しゃん"))
        ("dgl" nil ("シィ" . "しぃ"))
        ("dg." nil ("シィン" . "しぃん"))
        ("dgh" nil ("シュ" . "しゅ"))
        ("dgy" nil ("シュウ" . "しゅう"))
        ("dgn" nil ("シュン" . "しゅん"))
        ("dg;" nil ("シェ" . "しぇ"))
        ("dgp" nil ("シェイ" . "しぇい"))
        ("dg/" nil ("シェン" . "しぇん"))
        ("dgk" nil ("ショ" . "しょ"))
        ("dgi" nil ("ショウ" . "しょう"))
        ("dg," nil ("ション" . "しょん"))
        ("sgj" nil ("チャ" . "ちゃ"))
        ("sgu" nil ("チャイ" . "ちゃい"))
        ("sgm" nil ("チャン" . "ちゃん"))
        ("sgl" nil ("チィ" . "ちぃ"))
        ("sg." nil ("チィン" . "ちぃん"))
        ("sgh" nil ("チュ" . "ちゅ"))
        ("sgy" nil ("チュウ" . "ちゅう"))
        ("sgn" nil ("チュン" . "ちゅん"))
        ("sg;" nil ("チェ" . "ちぇ"))
        ("sgp" nil ("チェイ" . "ちぇい"))
        ("sg/" nil ("チェン" . "ちぇん"))
        ("sgk" nil ("チョ" . "ちょ"))
        ("sgi" nil ("チョウ" . "ちょう"))
        ("sg," nil ("チョン" . "ちょん"))
        ("stj" nil ("テァ" . "てぁ"))
        ("stu" nil ("テァイ" . "てぁい"))
        ("stm" nil ("テァン" . "てぁん"))
        ("stl" nil ("ティ" . "てぃ"))
        ("st." nil ("ティン" . "てぃん"))
        ("sth" nil ("テュ" . "てゅ"))
        ("sty" nil ("テュウ" . "てゅう"))
        ("stn" nil ("テュン" . "てゅん"))
        ("st;" nil ("テェ" . "てぇ"))
        ("stp" nil ("テェイ" . "てぇい"))
        ("st/" nil ("テェン" . "てぇん"))
        ("stk" nil ("テョ" . "てょ"))
        ("sti" nil ("テョウ" . "てょう"))
        ("st," nil ("テョン" . "てょん"))
        ("agj" nil ("ニャ" . "にゃ"))
        ("agu" nil ("ニャイ" . "にゃい"))
        ("agm" nil ("ニャン" . "にゃん"))
        ("agl" nil ("ニィ" . "にぃ"))
        ("ag." nil ("ニィン" . "にぃん"))
        ("agh" nil ("ニュ" . "にゅ"))
        ("agy" nil ("ニュウ" . "にゅう"))
        ("agn" nil ("ニュン" . "にゅん"))
        ("ag;" nil ("ニェ" . "にぇ"))
        ("agp" nil ("ニェイ" . "にぇい"))
        ("ag/" nil ("ニェン" . "にぇん"))
        ("agk" nil ("ニョ" . "にょ"))
        ("agi" nil ("ニョウ" . "にょう"))
        ("ag," nil ("ニョン" . "にょん"))
        ("tdj" nil ("ヒャ" . "ひゃ"))
        ("tdu" nil ("ヒャイ" . "ひゃい"))
        ("tdm" nil ("ヒャン" . "ひゃん"))
        ("tdl" nil ("ヒィ" . "ひぃ"))
        ("td." nil ("ヒィン" . "ひぃん"))
        ("tdh" nil ("ヒュ" . "ひゅ"))
        ("tdy" nil ("ヒュウ" . "ひゅう"))
        ("tdn" nil ("ヒュン" . "ひゅん"))
        ("td;" nil ("ヒェ" . "ひぇ"))
        ("tdp" nil ("ヒェイ" . "ひぇい"))
        ("td/" nil ("ヒェン" . "ひぇん"))
        ("tdk" nil ("ヒョ" . "ひょ"))
        ("tdi" nil ("ヒョウ" . "ひょう"))
        ("td," nil ("ヒョン" . "ひょん"))
        ("rdj" nil ("ミャ" . "みゃ"))
        ("rdu" nil ("ミャイ" . "みゃい"))
        ("rdm" nil ("ミャン" . "みゃん"))
        ("rdl" nil ("ミィ" . "みぃ"))
        ("rd." nil ("ミィン" . "みぃん"))
        ("rdh" nil ("ミュ" . "みゅ"))
        ("rdy" nil ("ミュウ" . "みゅう"))
        ("rdn" nil ("ミュン" . "みゅん"))
        ("rd;" nil ("ミェ" . "みぇ"))
        ("rdp" nil ("ミェイ" . "みぇい"))
        ("rd/" nil ("ミェン" . "みぇん"))
        ("rdk" nil ("ミョ" . "みょ"))
        ("rdi" nil ("ミョウ" . "みょう"))
        ("rd," nil ("ミョン" . "みょん"))
        ("egj" nil ("リャ" . "りゃ"))
        ("egu" nil ("リャイ" . "りゃい"))
        ("egm" nil ("リャン" . "りゃん"))
        ("egl" nil ("リィ" . "りぃ"))
        ("eg." nil ("リィン" . "りぃん"))
        ("egh" nil ("リュ" . "りゅ"))
        ("egy" nil ("リュウ" . "りゅう"))
        ("egn" nil ("リュン" . "りゅん"))
        ("eg;" nil ("リェ" . "りぇ"))
        ("egp" nil ("リェイ" . "りぇい"))
        ("eg/" nil ("リェン" . "りぇん"))
        ("egk" nil ("リョ" . "りょ"))
        ("egi" nil ("リョウ" . "りょう"))
        ("eg," nil ("リョン" . "りょん"))
        ("vdj" nil ("ギャ" . "ぎゃ"))
        ("vdu" nil ("ギャイ" . "ぎゃい"))
        ("vdm" nil ("ギャン" . "ぎゃん"))
        ("vdl" nil ("ギィ" . "ぎぃ"))
        ("vd." nil ("ギィン" . "ぎぃん"))
        ("vdh" nil ("ギュ" . "ぎゅ"))
        ("vdy" nil ("ギュウ" . "ぎゅう"))
        ("vdn" nil ("ギュン" . "ぎゅん"))
        ("vd;" nil ("ギェ" . "ぎぇ"))
        ("vdp" nil ("ギェイ" . "ぎぇい"))
        ("vd/" nil ("ギェン" . "ぎぇん"))
        ("vdk" nil ("ギョ" . "ぎょ"))
        ("vdi" nil ("ギョウ" . "ぎょう"))
        ("vd," nil ("ギョン" . "ぎょん"))
        ("cgj" nil ("ジャ" . "じゃ"))
        ("cgu" nil ("ジャイ" . "じゃい"))
        ("cgm" nil ("ジャン" . "じゃん"))
        ("cgl" nil ("ジィ" . "じぃ"))
        ("cg." nil ("ジィン" . "じぃん"))
        ("cgh" nil ("ジュ" . "じゅ"))
        ("cgy" nil ("ジュウ" . "じゅう"))
        ("cgn" nil ("ジュン" . "じゅん"))
        ("cg;" nil ("ジェ" . "じぇ"))
        ("cgp" nil ("ジェイ" . "じぇい"))
        ("cg/" nil ("ジェン" . "じぇん"))
        ("cgk" nil ("ジョ" . "じょ"))
        ("cgi" nil ("ジョウ" . "じょう"))
        ("cg," nil ("ジョン" . "じょん"))
        ("xgj" nil ("ヂャ" . "ぢゃ"))
        ("xgu" nil ("ヂャイ" . "ぢゃい"))
        ("xgm" nil ("ヂャン" . "ぢゃん"))
        ("xgl" nil ("ヂィ" . "ぢぃ"))
        ("xg." nil ("ヂィン" . "ぢぃん"))
        ("xgh" nil ("ヂュ" . "ぢゅ"))
        ("xgy" nil ("ヂュウ" . "ぢゅう"))
        ("xgn" nil ("ヂュン" . "ぢゅん"))
        ("xg;" nil ("ヂェ" . "ぢぇ"))
        ("xgp" nil ("ヂェイ" . "ぢぇい"))
        ("xg/" nil ("ヂェン" . "ぢぇん"))
        ("xgk" nil ("ヂョ" . "ぢょ"))
        ("xgi" nil ("ヂョウ" . "ぢょう"))
        ("xg," nil ("ヂョン" . "ぢょん"))
        ("xgj" nil ("デャ" . "でゃ"))
        ("xgu" nil ("デャイ" . "でゃい"))
        ("xgm" nil ("デャン" . "でゃん"))
        ("xgl" nil ("ディ" . "でぃ"))
        ("xg." nil ("ディン" . "でぃん"))
        ("xgh" nil ("デュ" . "でゅ"))
        ("xgy" nil ("デュウ" . "でゅう"))
        ("xgn" nil ("デュン" . "でゅん"))
        ("xg;" nil ("デェ" . "でぇ"))
        ("xgp" nil ("デェイ" . "でぇい"))
        ("xg/" nil ("デェン" . "でぇん"))
        ("xgk" nil ("デョ" . "でょ"))
        ("xgi" nil ("デョウ" . "でょう"))
        ("xg," nil ("デョン" . "でょん"))
        ("bdj" nil ("ビャ" . "びゃ"))
        ("bdu" nil ("ビャイ" . "びゃい"))
        ("bdm" nil ("ビャン" . "びゃん"))
        ("bdl" nil ("ビィ" . "びぃ"))
        ("bd." nil ("ビィン" . "びぃん"))
        ("bdh" nil ("ビュ" . "びゅ"))
        ("bdy" nil ("ビュウ" . "びゅう"))
        ("bdn" nil ("ビュン" . "びゅん"))
        ("bd;" nil ("ビェ" . "びぇ"))
        ("bdp" nil ("ビェイ" . "びぇい"))
        ("bd/" nil ("ビェン" . "びぇん"))
        ("bdk" nil ("ビョ" . "びょ"))
        ("bdi" nil ("ビョウ" . "びょう"))
        ("bd," nil ("ビョン" . "びょん"))
        ("zgj" nil ("ピャ" . "ぴゃ"))
        ("zgu" nil ("ピャイ" . "ぴゃい"))
        ("zgm" nil ("ピャン" . "ぴゃん"))
        ("zgl" nil ("ピィ" . "ぴぃ"))
        ("zg." nil ("ピィン" . "ぴぃん"))
        ("zgh" nil ("ピュ" . "ぴゅ"))
        ("zgy" nil ("ピュウ" . "ぴゅう"))
        ("zgn" nil ("ピュン" . "ぴゅん"))
        ("zg;" nil ("ピェ" . "ぴぇ"))
        ("zgp" nil ("ピェイ" . "ぴぇい"))
        ("zg/" nil ("ピェン" . "ぴぇん"))
        ("zgk" nil ("ピョ" . "ぴょ"))
        ("zgi" nil ("ピョウ" . "ぴょう"))
        ("zg," nil ("ピョン" . "ぴょん"))
        ("o" nil skk-current-kuten)
        ("O" nil skk-current-touten)
        (":" nil "ー")
        ("d:" nil "ん")
        ("do" nil "っ")
        ("[" nil "「")
        ("]" nil "」")
        ("c[" nil "【")
        ("c]" nil "】")
        ("c@" nil "◆")
        ("co" nil "・")
        ("c:" nil "・・・")
        ("c}" nil "⇒")
        ("x(" nil "（")
        ("x)" nil "）")
        ("x:" nil "：")
        ("x?" nil "？")
        ("x!" nil "！")
        ("x_" nil "　")
        ("x-" nil "—")
        ("x~" nil "〜")))
