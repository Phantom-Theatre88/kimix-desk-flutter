docs/holy/README.md
# Kimix Desk Holy Spec

このディレクトリは Kimix Desk における「聖典（Holy）」を格納する場所である。

- Holy は実装より上位の判断基準とする
- WORKLOG.md は「経緯」、Holy は「確定事項」を記録する
- Holy に反する実装・設計は必ず立ち止まり、修正または再検討する
- 実装中に Holy を書き換えない（変更は別途合意の上で行う）

docs/holy/Cue.md
# Cue 仕様（Holy）

## スコープ
- Cue は状態と再生単位を管理する
- Fader ページや表示状態は Cue に従属する

## Live / Blind
- Live と Blind はそれぞれ独立した Cue を持つ
- Cue 番号・現在 Cue 状態は Live / Blind 間で共有しない

## Fader ページとの関係
- Fader ページは Cue に従属する
- Cue を変更した場合、Fader ページは Page1 に戻る

## ページ保持ルール
- 同一 Cue 内での Ch ↔ Fader 切替ではページを保持する
- Cue を切り替えた場合は Page1 に戻る