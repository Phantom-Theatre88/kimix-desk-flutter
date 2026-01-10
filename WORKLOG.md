2026-01-10 iPad: Runestoneでmode_view.dart枠作成
2026-01-10 Mac: flutter run OK (local)
2026-01-10 Mac: F1-3 complete (mode/context separation, Live/Blind memory OK)
F1-4: mode color added (readability OK), aesthetics TBD
2026-01-10 F2-2: DeskShell state consolidated into DeskContextVM (no behavior change)
## 2026-01-10

- Flutter Desk UI のレイアウト検討を継続
- TopBar / MainArea / CueArea / KeyBlock の役割分離を再確認
- CueArea を「CueList（広） + CommandLine（56px）」構成で整理
- Main 下段を横3分割（Key / Edit / Playback）で確定
- KeyBlock に違和感 → 原因が「キーサイズ不統一」と判明
- v2.5 実機UIを再参照し、キーは 1U / 2U のみで成立する設計だと再確認
- 「2Uを最大サイズとする」キーサイズ制約をロック
- 本日は設計整理までで終了（実装は次回）