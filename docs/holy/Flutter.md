# Kimix v3.0 Flutter移行 ― 作業手順書 v1（通勤対応）🔐
（※仕様の正本は HolySpec。これは “作業の進め方” だけを定義する別冊）

## 0. 参照正本🔐
- 正本：HolySpec_v30_Completed_v3_1_FULL.md
- 運用導線：HolySpec_Index.md
- 本書は「正本を変更しない」ことが最優先

## 1. 目的（この別冊の役割）
- iPad（通勤）で “書く作業” を前進させる
- Mac mini（短時間）で “動作確認” を確定させる
- 仕様の追加・整理はしない（聖典に従うだけ）
- Sandboxという“別ルート”は作らない（工具としてのテストは可）

## 2. 作業分業（固定）🔐
### iPad（30〜60分/日）
やること＝「コードを書く」「構造を整える」「参照根拠を残す」
- 新規ファイル作成・編集
- View/VMの責務コメント追記
- Token/Themeの器だけ作る
- その日のDoneを `WORKLOG.md` に1行で残す

禁止（F1〜F3の間）
- I/O（ファイル、ネットワーク、Node、sACN等）
- 仕様に無い挙動の補完
- 見た目の作り込み（整列・配色沼）

### Mac mini（5〜10分）
やること＝「pullして起動」「赤をログ化」「通ったら確定」
- `git pull`
- `flutter run`
- エラーは “全文ログ” を保存（コピペでOK）
- 通ったら WORKLOG に「Mac OK」1行追記

## 3. フォルダ構成（最小・ロック）🔐
Flutter標準の `lib/` 配下に、Kimix用の “迷子防止構造” を最小で作る。

lib/
├─ main.dart
├─ app/
│  ├─ app.dart              # MaterialAppの入口（最小）
│  └─ desk_shell.dart        # DeskTemplate相当（骨格）
├─ core/
│  ├─ holy/
│  │  └─ refs.dart           # 参照根拠メモ（章/拘束/禁止事項）
│  └─ tokens/
│     ├─ tokens.dart         # DesignTokensの器（値は後）
│     └─ theme.dart          # Themeの器（参照点だけ）
├─ features/
│  └─ mode/
│     ├─ mode_vm.dart        # ViewModel相当（モード状態のみ）
│     └─ mode_view.dart      # 共有スペース枠＋モード枠
└─ WORKLOG.md                # 日々のDone 1行ログ

## 4. View / ViewModel 対応表（迷子防止）
- SwiftUI View → Flutter Widget（Stateless/Stateful）
- ObservableObject → ChangeNotifier（まずこれで統一）
- @Published → notifyListeners()（値変更時）
- Viewの状態（軽い）→ StatefulWidget内のState（ただし最小）
- “正本仕様に関わる状態” → VM側に置く（後工程で拡張）

注意：状態管理ライブラリ（Riverpod/Bloc等）は現時点で導入しない。
理由：方式選定が沼りやすく、F1/F2の目的を壊すため。

## 5. Phase F1（UI骨格）Done定義🔐
F1で実装してよいのは “枠” だけ。

やること
- DeskShell（ヘッダ＋MainArea枠）
- ModeView（LIVE/BLINDの切替“見た目”だけ）
- refs.dart に参照根拠を残す

Done（合格）
- アプリ起動して真っ白ではない
- LIVE/BLINDが押せて表示が切り替わる
- MainArea（共有スペース）が常に同じ領域にある

やらない
- コマンド文法、Cue、Selection、Level（F2/F3以降）
- 保存、I/O、外部接続（F5）

## 6. WORKLOG 運用（毎回1行）
例：
- 2026-01-09 iPad: desk_shell.dart 作成、MainArea枠追加
- 2026-01-09 Mac: flutter run OK

これだけで「何をやったか」を絶対に失わない。

【END】