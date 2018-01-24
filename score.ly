\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 16)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "陳芳語 - 愛你 (Waltz)"
  subtitle = "For female vocal and piano accompaniment"
  arranger = "Arranged by Benson"
}

upper-verse-one = \relative c'' {
  \repeat unfold 3 { r4 <a b>8-. r <a cis-.> r }
  r4 <f b>8-. r <f cis'>-. r
  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  \repeat unfold 3 { r4 <a b>8-. r <a cis-.> r }
  r4 <f b>8-. r <f cis'>-. r
  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  r4 <a b>8-. r <a cis>-. r
}

lower-verse-one = \relative c' {
  a8( e') r e-. r e-.
  fis,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  fis,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  e,8( e') r e-. r e-.

  a,8( e') r e-. r e-.
  fis,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r gis,
  fis8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  e,8( e') r e-. r e-.

  a,8( e') r e-. r e-.
}

upper-chorus-one = \relative c'' {
  r4 <a b>8-. r <a cis>-. r

  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  s2.*4
}

lower-chorus-one = \relative c' {
  a8( e') r e-. a,[ gis]

  fis8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  e,8( e') r e-. r e-.

  fis,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  e,8( e') r e-. e,[ eis]

  fis8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  e,8( e') r e-. r e-.

  b,8[ fis'] \cr a d fis a
  \cl cis,,[ e] \cr a cis e a
  \cl d,,[ a'] \cr d f a d
  \cl e,,[ gis] \cr b e gis b
  \cl
}

upper-episode = \relative c'' {
  << {
    a4.\( b8 cis4~ cis2 e4 e d4. cis8 cis2 b4\)
    a8\( gis a b cis4~ cis2 e4 gis4 fis e d4. cis8 b4\)
  } \\ {
    \repeat unfold 3 { r4 <e, a>8-. r q-. r }
    r4 <f a>8-. r q-. r
    \repeat unfold 4 { r4 <e a>8-. r q-. r }
  } >>
}

lower-episode = \relative c {
  a8( b') r b-. r b-.
  fis,8( b') r b-. r b-.
  d,,8( b'') r b-. r b-.
  d,,8( b'') r b-. r b-.
  a,8( b') r b-. r b-.
  fis,8( b') r b-. r b-.
  d,,8( b'') r b-. r b-.
  e,,8( b'') r b-. r b-.
}

upper-verse-two = \relative c' {
  \repeat unfold 3 { r4 <e a>8-. b-. q-. b-. }
  r4 <f' a>8-. b,-. q-. b-.
  \repeat unfold 4 { r4 <e a>8-. b-. q-. b-. }
  \repeat unfold 3 { r4 <e a>8-. b-. q-. b-. }
  r4 <f' a>8-. b,-. q-. b-.
  \repeat unfold 4 { r4 <e a>8-. b-. q-. b-. }
  r4 <e a>8-. b-. q-. b-.
}

upper-chorus-two = \relative c' {
  \repeat unfold 13 { r4 <e a>8-. b-. q-. b-. }
  s2.*4
}

lower-verse-two = \relative c {
  a8( b') r4 r4
  fis,8( b') r4 r4
  d,,8( b'') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  fis,8( b') r4 r4
  d,,8( b'') r4 r4
  e,,8( b'') r4 r4

  a,8( b') r4 r4
  fis,8( b') r4 r4
  d,,8( b'') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  fis,8( b') r4 r4
  d,,8( b'') r4 r4
  e,,8( b'') r4 r4

  a,8( b') r4 r4
}
lower-chorus-two = \relative c {
  a8( b') r4 a,8 gis

  fis8( b') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  e,,8( b'') r4 r4

  fis,8( b') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  e,,8( b'') r4 e,,8 eis

  fis8( b') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  e,,8( b'') r4 r4

  b,8[ fis'] \cr a d fis a
  \cl cis,,[ e] \cr a cis e a
  \cl d,,[ a'] \cr d f a d
  \cl e,,[ gis] \cr b e gis b
  \cl
}

upper-bridge = \relative c' {
  s2. eis8 gis, fis' gis, gis' gis,
  <fis' a>2. <gis b>2. <e b'>2. <fis ais>2.
  <d b'>2. <d e gis>2. <cis e a>2. <cis' e>4. <fis, d'>8 <e cis'>4
  <fis a>4. d8 <fis d'>4 <d b'>4. f8 d'4
  <a e'>4. b8 <a cis>4 <c, a'>4. fis8 e c
  b8 d fis a d4
  a,8 cis e a e'4
  b,8 d fis a d fis
  <e gis>8  d b gis e b
  R2.
}

lower-bridge = \relative c {
  a8 e' b' cis e a
  <cis,,, cis'>2.
  d4 <fis' a> q
  d, <e' gis> q
  cis, <e' gis> q
  fis, <e' ais> q
  b <fis' a> q
  e, <fis' a> <gis b>
  a, <cis e a> q
  <a, a'> <b b'> <cis cis'>
  d4 <fis' a> q
  d,4 <f' a> q
  cis,4 <e' a> q
  c,4 <e' a> q
  b,4 <fis'' a> q
  cis, <e' a> q
  d, <fis' b> q
  e,4 <e' gis> q
  e,,4 r r
}

upper-chorus-three = \relative c''' {
  R2.
  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r

  \repeat unfold 3 { r4 <a b>8-. r <a cis>-. r }
  r4 <a b>8-. r <gis b>-. r
  \repeat unfold 4 { r4 <e, a>8-. b-. q-. b-. }
  s2.*4
  cis'8 e, a d e a, a' cis, b' e, cis' a
  % <a' cis>8 e <b' d> e, <cis' e> e, <d' fis> a <e' gis> a, <gis' b> a,
  s2.*4
  <b e>8 a gis e b gis
  e4 r r
}

lower-chorus-three = \relative c' {
  R2.
  \clef treble
  fis8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  e,8( e') r e-. r e-.

  fis,8( e') r e-. r e-.
  d,8( e') r e-. r e-.
  a,8( e') r e-. r e-.
  e,8( e') r e-. \clef bass e,,,[ eis]

  fis8( b') r4 r4
  d,,8( b'') r4 r4
  a,8( b') r4 r4
  e,,8( b'') r4 r4

  b,8[ fis'] \cr a d fis a
  \cl cis,,[ e] \cr a cis e a
  \cl d,,[ a'] \cr d f a d
  \cl e,,[ gis] \cr b e gis b
  \cl
  a,,8 r cis r e r a r cis r e r

  \clef treble
  b8[ fis'] \cr a d fis a
  \cl cis,,[ e] \cr a cis e a
  \cl d,,[ a'] \cr d fis a d
  \cl e,,[ a] \cr b d e a
  \cl R2.
  \clef bass
  e,,
}

upper = \relative c' {
  \clef treble
  \tempo 4 = 144
  \time 3/4
  \key a \major
  R2.
  \upper-verse-one
  \upper-chorus-one
  \upper-episode
  \upper-verse-two
  \upper-chorus-two
  \upper-bridge
  \upper-chorus-three
  \bar "|."
}

lower = \relative c {
  \clef bass
  \time 3/4
  \key a \major
  R2.
  \lower-verse-one
  \lower-chorus-one
  \lower-episode
  \lower-verse-two
  \lower-chorus-two
  \lower-bridge
  \lower-chorus-three
  \bar "|."
}

dynamics = {
}

melody = \relative c'' {
  \clef treble
  \time 3/4
  \key a \major
  r2 r8
  % verse 1
  a8 a4 b cis gis'4. fis8 cis4 e4. d8 a4 cis b r8
  a8 a4 b cis fis, r8 fis fis4 cis'4. d8 cis4 b2 r8
  a8 a4 b cis gis'4. fis8 cis4 e4. d8 a4 cis b r8
  a8 a4 b cis fis, r8 fis fis4 cis'4 d4 cis b4. a8 gis4 a2 r4

  % chorus
  a4 cis e a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r8
  e,8 fis gis a4 gis a8 gis a4 gis fis8 e fis4. e8 cis4 b8 r
  cis'4 b8 a a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r
  cis,4 d2 a'4 a4 r8 a d, cis d4 d cis' b r8 a gis4 a2.
  R2.*3 R2.*4

  % verse 2
  a,4 b cis gis'4. fis8 cis4 e4. d8 a4 cis( b8) r8
  a8 a8 a4 b cis fis, r8 fis fis4 cis'4. d8 cis4 b2 r8
  a8 a4 b cis gis'4. fis8 cis4 e4. d8 a4 cis b r8
  a8 a4 b cis fis, r8 fis fis4 cis'4 d4 cis b4. a8 gis4 a2 r4

  % chorus 2
  a4 cis e a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r8
  e,8 fis gis a4 gis a8 gis a4 gis fis8 e fis4. e8 cis4 b8 r
  cis'4 b8 a a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r
  cis,4 d2 a'4 a4 r8 a d, cis d4 d cis' b r8 a gis4 a2.
  
  % bridge
  R2.
  r2 a8 a gis4 a b fis2. e2 r4
  r2 a8 a gis4 a b fis2( e4) cis'4( d cis4 a4)
  r4 a8 a gis4 a b e2 cis8( b) b4( a) r
  r2 a8 fis a4 b cis e2 cis4 e cis( b)

  R2.

  % chorus 3
  a,4 cis e a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r8
  e,8 fis gis a4 gis a8 gis a4 gis fis8 e fis4. e8 cis4 b8 r8
  cis'4 b8 a a4 gis a8 gis a4 cis b8 a a4 e4. cis'8 b4 r
  cis,4 d2 a'4 a4 r8 a d, cis d4 d cis' b r8 a gis4 a2.
  r2
  cis,4 d2 a'4 a4 r8 a d, cis d4 d cis' b2. r2. r4 a gis4 a2.

  \bar "|."
}

lyricsmain = \lyricmode {
  我 閉 上 眼 睛 貼 著 你 心 跳 呼 吸
  而 此 刻 地 球 只 剩 我 們 而 已
  你 微 笑 的 唇 型 總 勾 著 我 的 心
  每 一 秒 初 吻 我 每 一 秒 都 想 要 吻 你

  就 這 樣 愛 你 愛 你 愛 你 隨 時 都 要 一 起
  我 喜 歡 愛 你 外 套 味 道 還 有 你 的 懷 裡
  把 我 們 衣 服 鈕 扣 互 扣 那 就 不 用 分 離
  美 好 愛 情 我 就 愛 這 樣 貼 近 因 為 你

  有 時 沒 生 氣 故 意 鬧 脾 氣
  你 的 緊 張 在 意 讓 我 覺 得 安 心
  從 你 某 個 角 度 我 總 看 見 自 己
  到 底 你 懂 我 或 其 實 我 本 來 就 像 你

  就 這 樣 愛 你 愛 你 愛 你 隨 時 都 要 一 起
  我 喜 歡 愛 你 外 套 味 道 還 有 你 的 懷 裡
  把 我 們 衣 服 鈕 扣 互 扣 那 就 不 用 分 離
  美 好 愛 情 我 就 愛 這 樣 貼 近 因 為 你

  想 變 成 你 的 氧 氣
  溜 進 你 身 體 裡
  woo
  好 好 看 看 在 你 心 裡
  你 有 多 麼 寶 貝 我 愛 你

  就 這 樣 愛 你 愛 你 愛 你 隨 時 都 要 一 起
  我 喜 歡 愛 你 外 套 味 道 還 有 你 的 懷 裡
  把 我 們 衣 服 鈕 扣 互 扣 那 就 不 用 分 離
  美 好 愛 情 我 就 愛 這 樣 貼 近 因 為 你
  我 們 愛 情 會 一 直 沒 有 距 離 最 美 麗
}

\paper {
  page-breaking = #ly:page-turn-breaking
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiMinimumVolume = #0.7
      \set Staff.midiMaximumVolume = #0.8
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.9
        \set Staff.midiMaximumVolume = #1
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.9
        \set Staff.midiMaximumVolume = #1
        \lower
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

\book {
\bookOutputSuffix "no-vocal"
\score {
  <<
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \lower
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}
