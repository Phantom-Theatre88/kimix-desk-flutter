# 第-1章 ― Usage / Guard / Stop Rules  
### （本聖典の使用規則・思考制約・暴走停止指針）

---

## -1.0 この章の存在理由（最重要）

この章は **操作説明ではない**。  
また **思想章でもない**。

この章は、

> **kibi（設計補助AI）が  
> Kimix Desk に関する思考・提案・実装判断を行う際、  
> 必ず最初に読み、  
> かつ途中で何度も立ち戻るための  
> 思考制約章である。**

同時に、

> **kim が  
> 「なぜこの判断が暴走と感じられたか」  
> 「どの前提が無視されたか」  
> を事後に追跡するための  
> 記録可能な基準点**  
> でもある。

---

## -1.1 この聖典の唯一の目的

この聖典の目的は **1つだけ**。

> **kim と kibi の間で  
> 「解釈のズレ」「思考の飛躍」「善意の暴走」  
> を発生させないこと。**

- 読みやすさは目的ではない  
- 簡潔さも目的ではない  
- 教育性も目的ではない  

**「同じ前提で思考する」ことだけが目的**。

---

## -1.2 kibiが思考を開始する前の必須チェック（暴走防止チェック）

kibi は、  
Kimix に関する **いかなる提案・修正・解釈** を行う前に、  
必ず以下を順番に確認する。

### チェック1  
**今扱っている話題は、どのカテゴリか？**

以下の6カテゴリ以外の話題は、  
**この聖典の管理対象外**である。

1. Selection（選択）
2. Level（レベル入力）
3. Cue Playback（再生）
4. Cue Edit（記録・更新・削除）
5. Part / Time / Delay / Link（Cue構造）
6. Utility / Navigation

👉  
この分類に **即座に割り当てられない話題**は、  
思考を開始してはいけない。

---

### チェック2  
**そのカテゴリ内で、何がLOCKされているか？**

- LOCKされている仕様  
  → 解釈・変更・一般化は禁止
- DRAFT  
  → 文法の補完のみ可、挙動追加は禁止
- FUTURE  
  → 実装判断に使ってはいけない

**この判定ができない場合、kibiは即停止する。**

---

### チェック3  
**今の判断は「安全側」に倒れているか？**

Kimix Desk の聖典は、常に以下を優先する：

1. 事故を起こさない  
2. 現場で予測できる  
3. 操作者が迷わない  

「便利そう」「一般的」「EOSだと〜」  
という理由は **一切採用しない**。

---

## -1.3 kibiがやってはいけない思考（明示）

以下は **すべて禁止**。

- 聖典に書いていない挙動を  
  「自然だと思うから」補うこと
- EOSの仕様を  
  「互換だから」という理由で拡張すること
- UI都合・実装都合を  
  操作仕様に逆流させること
- kimの確認なしに  
  「整理」「簡略化」「一般化」を行うこと

---

## -1.4 kimがこの章を読む理由（重要）

この章は、  
kim が **kibiを信用するための章**でもある。

もし今後：

- 「話が噛み合っていない」
- 「勝手に別方向へ行った」
- 「仕様を薄められた」

と感じた場合、  
kim はこの章に戻り、以下を確認すればよい。

- どのチェックが飛ばされたか
- どのLOCKが無視されたか
- どの禁止思考が踏まれたか

---

## -1.5 この章と第0章の関係

- **第-1章**：  
  思考の柵・暴走停止装置（kibi主対象）
- **第0章**：  
  思想・価値観・設計姿勢（kim＋人間主対象）

---

## -1.6 この章がある限り許されること

この章がある限り：

- kibiは提案してよい  
- kimは否定してよい  
- 仕様は進化してよい  

ただし、

> **この章を無視した進化は  
> Kimix ではない。**

---

## -1.7 過去に起きた暴走の実例（思考レベル）

以下は、実際に Kimix の設計過程で発生した  
「善意による暴走」の代表例である。

### 例1：EOS互換という言葉の誤用

- 状況：  
  EOSでは一般的な挙動であるため、  
  Kimixにも自然に入れるべきだと判断した。
- 問題点：  
  「互換」は文法レベルまでであり、  
  思想・挙動まで含むものではない。
- 無視されたチェック：  
  - チェック1（カテゴリ確認）  
  - チェック2（LOCK範囲の確認）

---

### 例2：仕様の整理・要約による意味の劣化

- 状況：  
  人間が読みやすいように文章を整理・短縮した。
- 問題点：  
  Kimixの聖典は  
  「理解しやすさ」より  
  「解釈がブレないこと」を優先する。
- 無視されたチェック：  
  - チェック3（安全側判断）

---

### 例3：実装都合からの仕様逆流

- 状況：  
  ViewModelやUI実装が簡単になるため、  
  操作仕様を調整しようとした。
- 問題点：  
  Kimixでは  
  実装は仕様に従う側であり、  
  仕様が実装に寄ることはない。
- 無視されたチェック：  
  - チェック2（LOCK確認）

---



# Kimix Desk ‒ Command HolySpec v26（0～10章 + CmdSpec v）【統合済み】

> ※ベース構成は維持し、Time仕様書v1は **第6章/第7章/第9章/付録**に統合済み。

---

## 目次

- 第0章 ― 基本原則（Philosophy / Core Rules）
- 第1章 ― コマンド体系の全体構造（Overview）
- 第2章 ― 選択系 HolySpec（Selection System）
- 第3章 ― レベル入力 HolySpec（Level System）
  - 3-1. 基本文法（EOS互換）
  - 3-2. 2桁％（Kimix独自）
  - 3-3. @FF（FULL）
  - 3-4. 相対入力（＋／－）
  - 3-5. 決定後の cmdBuffer 保持
  - 3-6. 選択が空のときの自動復元（Kimix独自）
  - 3-7. 選択が空のときの自動復元（HolySpec）
  - 3-8. 小数レベルの入力（将来拡張）
- 第4章 ― Cue Playback HolySpec（GO / STOP / BACK）
  - 4-1. GO（前進）
  - 4-2. STOP（停止）
  - 4-3. BACK（戻し）
  - 4-4. Cue ▲▼（カーソル移動）
  - 4-5. GOTO CUE
- 第5章 ― Cue Edit HolySpec（Record / Update / Delete）
  - 5-1. 記録（Record）
  - 5-2. 更新（Update）
  - 5-3. 削除（Delete）
  - 5-4. Track / CueOnly / Block（記録モード）
  - 5-5. Enter×2（核となる安全HolySpec）
  - 5-6. 記録時の画面変化（将来 HolySpec）
- 第6章 ― Part / Time / Delay / Link（※Time仕様書v1 統合済み）
- 第7章 ― Slash “/” HolySpec（※Time仕様書v1 反映済み）
- 第8章 ― Utility
- 第9章 ― Safety（※Time仕様書v1 反映済み）
- 第10章 ― Reflex Map（キー配置と意味）
- 付録：チェックシート（実装者向け）（※Time項目追記済み）

---

## 第0章 ― 基本原則（Philosophy / Core Rules）

KimixDesk v26 のコマンド体系は、  
ETC EOS 系コマンド文法の互換性を保ちながら、  
舞台現場で安全に運用できる“ミニマル且つ直感的”な体系として設計する。

---

### 0-1. 共通哲学（永続ルール）

1. **選択 → 操作 → 確定（Enter×2）**  
   - すべての編集コマンドはこのフローを基礎にする。  
   - 記録事故を防ぐため、Cue記録・更新・削除は必ず Enter×2。

2. **CommandPad → CmdBuffer → VM の単一路**  
   - 入力経路は常に「10key → Bridge → VM（pad～）」で統一。  
   - 外部キーボード、OSC、Bluetooth MIDI も将来ここに統合する。

3. **EOS互換性を維持しつつ“複雑さは採用しない”**  
   - EOSにある「大量のモード」「表記ゆれ」「複雑FX」などは排除。  
   - KimixDesk は「実用性」「現場速度」「安価・軽量」を優先する。

4. **明示的コマンド設計（暗黙挙動は避ける）**  
   - 特に Cue 記録／更新／削除 は必ず手順が見える形にする。  
   - 例：REC → CUE番号 → Enter → Enter

5. **A/B クロスフェードは HolySpec v2（Kimix独自）**  
   - EOS の「マスターフェーダ複数制御」ではなく、  
     Kimix 独自の **A/B Slot モデル** を採用する。

---

### 0-2. コマンド文法の大分類（6カテゴリ）

KimixDesk v26 のコマンド系統は次の 6つに分ける：

1. Selection（選択）
2. Level（レベル入力）
3. Cue Playback（再生）
4. Cue Edit（記録・更新・削除）
5. Part / Time / Delay / Link（Cue構造編集）
6. Utility / Navigation（ユーティリティ）

EOSの巨大体系を、実務に必要な中核だけに収束させた構成。

---

### 0-3. 設計姿勢：安全・明瞭・最小ルール

- 事故を起こさない：  
  記録や削除コマンドは Enter×2 を必須とし、  
  cmdBuffer に常に「今何のコマンドか」が明示される。

- シーケンスが読みやすい：  
  `1 THRU 10 @ 50` のような “文章” として成立する文法を採用。

- 複数モードを持たない：  
  Patch / FX / MagicSheet のような複雑機能は別フェーズ。
---
## 0-x 卓レイアウトの共有スペース原則（v3.0）

本節は、Kimix Desk における **画面構成・レイアウト思想の正本定義**である。  
操作仕様や View 実装よりも上位に位置し、以降すべての章に優先して適用される。

### 0-x-1 モード間の等価性（最重要）

Kimix Desk において、以下のモードは **すべて等価**である。

- Ch モード
- Fader モード
- Patch モード
- Setting モード

いずれかのモードが「基準」「特別」「優先」として扱われることはない。  
表示・遷移・構成においても、優先順位は存在しない。

---

### 0-x-2 共有スペース（Main Area）の定義

Kimix Desk は、卓全体を以下の考え方で構成する。

- 卓には **共通の共有スペース（Main Area）** が存在する
- Ch / Fader / Patch / Setting は  
  **同一の共有スペースを占有し、内容のみを差し替える**
- レイアウトの基準点は常に DeskTemplate にある

共有スペースは「左」「中央」など物理的位置で固定することは許可されるが、  
**モードによってサイズ・役割・意味を変えてはならない**。

---

### 0-x-3 Setting モードの位置づけ（例外禁止）

Setting モードは以下の点で **例外ではない**。

- 別画面として扱わない
- 特別なレイアウトを与えない
- 一時的・暫定という理由で構造を分けない

Setting モードはあくまで  
**共有スペースを使用する一モード**であり、  
「自由に崩してよい画面」ではない。

---

### 0-x-4 View 実装への拘束条件

View 実装において、以下を禁止する。

- モードごとに異なる親レイアウトを持つこと
- Setting モード専用の DeskTemplate を作ること
- 「後で直す」「今だけ」という理由で例外構造を導入すること

View は必ず、

- DeskTemplate
- Spec（寸法・余白・配置ルール）

を参照し、**共有スペース差し替え**として実装されなければならない。

---

### 0-x-5 本原則の位置づけ（🔐）

本節で定義された  
**モード等価性・共有スペース原則**は、

- v3.0 において 🔐LOCK とする
- 将来フェーズでも変更・緩和・例外化を行わない
- 実装都合・検証都合・一時対応を理由とした逸脱を禁止する

本原則に反する設計・実装・提案は、  
理由の如何を問わず **暴走扱い**とする。

## 0-x. 内部構造ルール（Write / Save / Recovery）

本節は、Kimix v3.0 における **内部構造およびデータ操作責務**を定義する。  
本節の内容は、以降すべての章に優先して適用される内部ルールであり、  
操作仕様やユーザー挙動を規定するものではない。

---
# 🔐【追記】0-x-1〜0-x-6  
## 内部構造ルール補遺（Save検証 / 差分定義 / 自動復旧）

> 本節は **v3.0 で追加された内部安全装置**を定義する。  
> 本節は操作仕様ではなく、**内部データの正当性を保証するための実装ルール**である。  
> 使用者の操作感・UI 表示・コマンド文法には影響しない。

---
### 0-x-2. ShowLibrary / ShowFolder 階層構造と識別ルール

Kimix は、複数公演データを保持するための
親フォルダ「ShowLibrary（固定パス）」を持つ。

ShowLibrary 配下には、公演単位のフォルダ（ShowFolder）が
複数並ぶ構造とする。

ShowFolder は 1 公演を表し、
フォルダ名には人間可読な「公演名」を用いる。
フォルダ名は内部識別には使用しない。

各 ShowFolder は内部識別子として ShowID を持つ。
ShowID は Meta 内にのみ保持され、
UI・フォルダ名・ファイル名には表示しない。

正本判定・保存検証・復旧処理における識別は、
ShowID のみを根拠とする。

ShowFolder 配下には、全公演共通のテンプレ構造として
CueData / Patch / Meta / _recovery などのサブフォルダを持つ。

#### 正本（Single Source of Truth）［v3.0 🔐］
- **正本 = ShowFile（メモリ上）** と定義する。
- 正本という語は ShowFile 以外に使用しない。
- DataOnly / JSON / VM / Bridge は正本ではない（写し・機構）。
- 正本の更新入口は CueEdit_vm.commit のみとする。

### 0-x-3. ShowFolder 配下の最小サブフォルダ構成

ShowFolder 配下には、全公演共通の最小構成として
以下のサブフォルダを持つ。

- CueData/  
  公演におけるキュー情報（時間構造・演出結果）を保持する。

- Patch/  
  フィクスチャおよび出力系の物理接続情報を保持する。

- Meta/  
  卓設定・表示設定・ShowID など、  
  公演および卓そのものに関わる内部情報を保持する。

- _recovery/  
  保存検証失敗や異常終了時の復旧用データを保持する。
  通常運用で人間が編集することは想定しない。

上記 4 フォルダは同等の重要度を持つ構造要素であり、
いずれかを欠いた構成は不完全な ShowFolder とみなす。

将来、時間的・数理的変化を再利用可能な演算単位として扱う場合、
Effect/ フォルダを追加する余地を残す。
ただし、Effect/ は本章で定義する最小構成には含めない。

### 0-x-4. ビルド停止時の行動ロック（短い版）

ビルドが停止した場合、推測による暴走と範囲逸脱を防ぐため、
以下の順序と制約を必ず守る。

1. エラー原文をそのまま提示する  
   （ファイル名・行番号・メッセージ）

2. 直前に触ったファイル一覧を宣言する  
   （Phase範囲内かを確認するため）

3. 修正対象を分類して提示する  
   - このPhase内で直せる赤  
   - 別Phaseに送る赤

4. このPhase内で直せる赤のみ、一括修正案を提示する  
   （差分・抜粋は禁止）

5. 推測が混ざる場合は【推測】ブロックに隔離し、
   KimのGOが出るまで採用しない\

### ShowID の扱い（識別と表示の分離）

ShowID は公演（ShowFolder）を一意に識別する内部IDであり、  
フォルダ名・表示名・ファイル名には埋め込まない。

人間可読な名称は表示専用とし、  
正本判定・保存検証・復旧処理は ShowID のみを根拠とする。

## 0-x-1. 用語定義（差分の再定義）

本聖典では「差分」という語を曖昧に使用しない。  
以下の 2 種類を明確に分離して定義する。

### ■ Save検証（I/O検証）
Save 操作において、

- **保存したいメモリ上の正規データ**
- **実際にディスクへ書き出された保存結果**

が **一致しているか**を確認する検証工程を指す。

これは  
「データが変わったか」を見るものではなく、  
**「意図したデータが正しく書けたか」を確認する安全装置**である。

---

### ■ 変更差分（履歴差分）
旧保存データと新保存データの内容差分を指す。

- 操作によってデータが変化する以上、差分は **必ず発生する**
- 通常運用・安全判断には **一切使用しない**
- 開発・解析用途に限定される概念とする

---

## 0-x-2. Save検証（I/O検証）の定義【常時ON】

Save 操作時は、必ず以下の手順で検証を行う。

1. メモリ上に正規データが存在する
2. Save を実行する
3. データをディスクへ書き出す  
   （※ tmp → rename による原子保存）
4. 書き出されたファイルを **直ちに読み戻す**
5. 読み戻し結果とメモリ上の正規データを  
   **正規化 JSON 同士で比較**する

- 一致 → 正常 Save  
- 不一致 → **Save検証失敗（異常）**

Save検証は **常時ON** とし、  
Debug 設定やユーザー操作で無効化してはならない。

---

## 0-x-3. 再起動時検証

以下の場合、起動直後に同様の検証を行う。

- 前回終了が異常終了  
  （クラッシュ／フリーズ／強制終了）
- 保存データの整合性に疑義がある場合

この場合も、

- **メモリ上の正規データ**
- **保存データ**

の一致／不一致を判定基準とする。

---

## 0-x-4. 自動復旧処理（B方式・確定）

Save検証または再起動時検証で不一致が検出された場合、  
卓は以下の復旧処理を **自動で実行**する。

1. **メモリ上の正規データを正とみなす**
2. 正規データを以下へ保存する：
   - フォルダ：`/<ShowName>/_recovery/`
   - 用途：内部退避（UI非表示）
   - ファイル数：**常に1個**
   - ファイル名：固定（例：`last_recovery.json`）
   - 保存方法：常に上書き
3. 保存された復旧データを  
   **自動的に最新データとして採用**し、運用を継続する
4. 元の保存ファイルは  
   `.corrupted` にリネームして退避する

---

## 0-x-5. `.corrupted` ファイルの扱い（事故解析用）

- `.corrupted` ファイルは **最大3件まで保持**する
- 4件目以降は **最も古いものから自動削除**
- 命名にはタイムスタンプを含める

`.corrupted` は事故解析のための保険であり、  
通常運用で使用者が意識する必要はない。

---

## 0-x-6. 沼回避のための設計原則（重要）

- Save検証は  
  **「操作の正否」を判断するものではない**
- Save検証は  
  **「データが正しく書けたか」を保証するための安全装置**である
- 差分検出は  
  **プログラムバグ修正の代替ではない**
- ただし、  
  **バグが存在する期間および不慮の事故に備えるため、必須の保険**として常設する

### 0-x-7. Bridge分割ルール（Write/Save の配線固定）

- 入力の統合出口は `DeskBridge` とする（入力経路は固定）。
  - UI / 10Key → DeskBridge → CueEdit_vm.commit → …

- 永続化（Save/Recovery）への接続は `ShowFileBridge` が担当する。
  - CueEdit_vm.commit → ShowFileBridge → ShowFileIO

- 責務分離（禁止）
  - DeskBridge は保存I/O詳細（パス/Recovery/JSON等）を持たない
  - ShowFileBridge は入力処理（Pad正規化/デバウンス等）を持たない
  - 経路は必ず1本・単方向（逆流禁止）

---

### 🔐 ロック宣言
本節に定義された Save検証・差分定義・自動復旧ルールは、  
**v3.0 以降、変更・簡略化・無効化を禁止**する。

### ■ 用語定義

- **Write**  
  Cue Edit（Record / Update / Delete）により、  
  **ShowFile（DataOnly）内の CueData を更新する行為**を指す。

- **Save**  
  公演データを **ShowFolder（公演フォルダ）**として永続保存する行為を指す。  
  Save は基本的に **手動操作**で行われる。

- **Recovery（AutoSave）**  
  フリーズ・クラッシュ・強制終了からの復帰を目的とした、  
  **使用者が意識しない内部退避**を指す。  
  Recovery は Save とは異なり、公演保存を意味しない。

---

### ■ Write の適用範囲

- Write が使用されるのは **Ch / Fader モード**のみとする。
- Patch モードでは Write を使用せず、Enter による即時確定とする。
- Write の対象は以下を含む（B）：
  - Channel / Fader Level
  - Part / Time / Delay / Link
  - Cue Edit に付随する記録モード（存在する場合）

---

### ■ 責務分離（v3.0）

- **commit の統合出口**
  - すべての確定操作（10Key / UI ボタン）は  
    **DeskBridge に統合され、commit イベントとして発火**する。

- **Write 本体**
  - Write（CueData の更新適用）は  
    **Core に配置された `CueEdit_vm` が担当**する。
  - `CueEdit_vm` は commit を受け取り、  
    ShowFile（DataOnly）の CueData に対して Write を行う。

- **再生系**
  - `Cue_vm` / `CuePlayback_vm` は再生演算の心臓部とし、  
    Write 本体の責務を持たない。

---

### ■ Recovery（内部退避）

- Recovery は **commit イベント発生時**にのみ行われる。
- 保存先は **ShowFolder 配下の内部用サブフォルダ**とする。  
  例：`/<ShowName>/_recovery/`
- Recovery に含める内容は以下を最小セットとする：
  - cmdBuffer
  - commit 直前までの操作状態
  - mode（Ch/Fader / Patch 等）
  - timestamp
- Recovery は使用者が気づく必要のない内部機構とする。

---

### ■ 優先順位

- 本節に定義された内部構造ルールは、  
  他章に記載された操作仕様・挙動説明よりも優先される。
- 既存の聖典に明示的な規定がある場合は、  
  **既存の聖典を最優先**とする。

---

## 第1章 ― コマンド体系の全体構造（Overview）

この章では、全6カテゴリの定義と EOSとの対応／Kimixでの扱いを明記する。

---

### 1-1. Selection（選択）

扱う内容：  
チャンネル番号、範囲、追加／除外、前回選択、アクティブ選択。

EOSから継承する部分：
- `1`
- `1 THRU 10`
- `1 + 5 - 7`
- `SELECT LAST`
- `SELECT ACTIVE`

Kimix固有の部分：
- 選択は常に「IndexSet」で管理し、padState によって完全再現できる。
- Clear はコマンド行だけを消し、選択は消さない（安全設計）。

---

### 1-2. Level（レベル入力）

扱う内容：  
絶対値入力（@）、相対入力（＋／－）、FULL（@FF）、2桁％。

EOSから継承：
- `@ 50`
- `@ 0`
- `@ +10 / @ -`
- `FULL`

Kimix固有：
- FULL = `@FF`
- 2桁％（50→0.50）は Kimix 独自の高速入力方式
- 値入力は Enter不要、即時反映 → 事故なし

---

### 1-3. Cue Playback（再生）

扱う内容：  
GO、STOP、BACK、GOTO、カーソル移動。

EOSからの継承：
- GO
- STOP
- BACK
- GOTO CUE X

Kimix固有：
- A/B Slot による “HolySpec クロスフェード” を採用
- BACK は「前のCueへ戻る」＋BackTime（3秒）
- Cue▲▼ で cursorIndex を操作（CueList UI の一部）

---

### 1-4. Cue Edit（記録・更新・削除）

扱う内容：  
REC、UPDATE、DELETE、CueOnly/Track。

EOSから継承：
- RECORD
- UPDATE
- DELETE
- TRACK / CUE ONLY

Kimix固有：
- Enter×2 で確定
- BLOCK/Track/QOnly の3種に減らす
- REC◎ → 記録モード明確化（UI変化あり）

---

### 1-5. Part / Time / Delay / Link

扱う内容：  
Cue構造の中の Up/Down、Delay、Part追加、Wait、Link。

EOSから継承：
- `PART 2`
- `TIME 3`
- `TIME 3 / 1.`
- `DELAY 2`
- `WAIT 5`
- `LINK`

Kimix固有：
- `/` は “文脈別に意味を変える”（Timeでは Up/Down separator）
- Link 表記の簡略化
- Part の構造を Cue_vm の parts 機能と統合

---

### 1-6. Utility / Navigation

扱う内容：  
UNDO、CLEAR、Backspace、COPY/PASTE、矢印キー。

EOSから継承：
- UNDO
- CLEAR
- ⌫
- COPY / PASTE
- ◀︎ ▼ ▶︎ ▲

Kimix固有：
- UNDOは1ステップのみ
- 矢印は CueList / ChArea の UI 操作として扱う

---

## 第2章 ― 選択系 HolySpec（Selection System）

この章では「KimixDesk での選択はどう動くか？」を EOS互換＋独自安全ルールとして定義する。

---

### 2-1. 数値選択
`1` → チャンネル1を選択（IndexSet = {0}）

---

### 2-2. 範囲選択（THRU）
`1 THRU 10` → 1～10 の連続選択（IndexSet = {0...9}）

- 文法は EOS と完全一致。
- Kimix の padThru() は padState.rangeStart を使うため安全。

---

### 2-3. 追加 ＋ 除外 －
`1 + 5 - 7`

- `+`：追加
- `-`：除外
- 現場の EOS と同じ文法
- KimixDesk の padState.include / exclude に直結

---

### 2-4. “/”（選択コンテキスト）
`1 / 5 / 10`

- 選択コンテキストでは `/` は「グループ分割」の意味
- 将来的に Group/Fixture タイプの区切りにも拡張可
- Time/Linkとは絶対に意味を共有しない（後述）

---

### 2-5. SelectLast / SelectActive
`SelectLast` / `SelectActive`

- 専用キーで実装
- EOS の挙動を簡略化しつつ“前回/現在選択”を呼び出す
- 「選択復元」機能は padState.lastSelection として管理

---

### 2-6. 選択のフォールバック（Kimix独自安全機能）

- `@` で値入力開始 → 選択が空なら直前選択を自動復元
- 例：`@ 50` → 直前の選択に対して適用

---

### 2-7. Clear（選択は消さない）
`Clear`

- cmdBuffer だけを消す
- 選択は消さない（誤消し事故対策）
- EOS の ClearCmd とほぼ一致

---

### 2-8. Backspace
`⌫`

- 数字の1桁戻し
- @ モードと selection モードで挙動が違う
- 選択モード：数字だけ戻す
- レベルモード：値桁を戻す or @ をキャンセル

---

## 第3章 ― レベル入力 HolySpec（Level System）

レベル（明るさ）入力は KimixDesk の最重要操作のひとつ。  
現場事故防止のため、Kimix独自の安全ロジックを追加して設計している。

---

### 3-1. 基本文法（EOS互換）
`@ 50`

- 絶対値 50%
- Enter不要（EOS互換）
- 押した瞬間に Live/Blind の該当バッファへ即反映

---

### 3-2. 2桁％（Kimix独自）
`50`

- そのまま「50%」として扱う（@省略）
- Enter不要、即反映
- 誤爆防止：2桁までで止まる HolySpec 確立済み

---

### 3-3. @FF（FULL）
`@FF`

- EOSの `@ FULL` と等価
- 100%
- Enter不要、即時反映
- Kimixでは FULL という英字は使わず @FF に統一（誤入力防止）

---

### 3-4. 相対入力（＋／－）
`@ +` / `@ -`

- 現在値に対して ±を加算
- EOSの相対文法と一致
- `+5` / `-5` 専用キーも高速化のため追加済み

---

### 3-5. 決定後の cmdBuffer 保持

- レベル確定後も cmdBuffer は保持
- 次に数字を押したら padDigit が自動クリア
- `/（Ch）` を押してもクリアしない  
→ HolySpec として正式採用

---

### 3-6. 選択が空のときの自動復元（Kimix独自）
`@ 50`

- 選択が空なら lastSelection を復元して適用
- EOSより安全（事故防止）
- LOCK 済

---

### 3-7. 選択が空のときの自動復元（HolySpec）
`@ 50`（選択なしで @ を押した場合）

1. lastSelection を復元
2. それが無ければ selectedIndex
3. それすら無ければ何もしない（安全停止）

---

### 3-8. 小数レベルの入力（将来拡張）
- `@ .5` → 0.5%
- `@ 12.5` → 12.5%  
将来サポート予定（予約済み）。

---

## 第4章 ― Cue Playback HolySpec（GO / STOP / BACK）

KimixDesk の Cue 再生は A/B Slot HolySpec（v2）に基づいて動く。  
EOSの「マスターフェーダ」とは異なるが、動作感覚は EOS に近い。

---

### 4-1. GO（前進）
GO

- 再生開始
- 再生中なら「再開」扱い
- A/B Slot の Up担当が上昇、Down担当が減衰

HolySpec：
- 担当は現在レベルで決定（固定）
  - level==1 → Down担当
  - level==0 → Up担当

---

### 4-2. STOP（停止）
STOP

- 再生をその場で凍結
- 方向性は保持
- 再度 GO で同方向に再開

HolySpec：
- STOP はトグルしない
- EOSの「Stop/Back」混合動作は採用しない

---

### 4-3. BACK（戻し）
BACK

- 停止状態で BACK → 1つ前の Cue へ戻る（世代単位）
- 再生中に BACK → 逆方向フェード開始
- BACK 中に BACK → 停止（PAUSE）

HolySpec：
- 戻し時間は BackTime（固定3秒）
- CueTimeとは別管理

---

### 4-4. Cue ▲▼（カーソル移動）

- ▲：前のCueへ
- ▼：次のCueへ

HolySpec：
- 再生はしない（カーソルのみ）
- 再生は GO のみ

---

### 4-5. GOTO CUE

`CUE 12 Enter`  
10keyでは：`CUE → 12 → Enter → Enter`

HolySpec：
- GOTOは「カーソル移動」扱い
- 再生しない
- 再生は GO の瞬間のみ（事故再生防止）

---

## 第5章 ― Cue Edit HolySpec（Record / Update / Delete）

Cue記録・更新・削除の正式仕様。  
Enter×2 ルールが最重要。

---

### 5-1. 記録（Record）

EOS互換：
`RECORD CUE 5 Enter Enter`  
10key：`REC◎ → CUE → 5 → Enter → Enter`

HolySpec：
- REC◎ 押下で記録モード開始
- cmdBuffer に “Record CUE:??”
- Cue番号必須（未入力はエラー）
- Enter×2 で実行
- Enter×1 では何もしない

---

### 5-2. 更新（Update）

EOS互換：
`UPDATE CUE 5 Enter Enter`

Kimix：
- UPDATE 専用キーは置かず
- `REC◎ → CUE 5 → Enter×2` で上書き

HolySpec：
- 新規/上書きは Cue番号の既存判定で決定
- 記録フローはRecordと同一

---

### 5-3. 削除（Delete）

`DELETE CUE 5 Enter Enter`

- v26では Enter×2 で固定
- 10key拡張案は将来検討（現行採用しない）

---

### 5-4. Track / CueOnly / Block（記録モード）

Row1 の TRACK/QOnly キーで切替。

- Track：前後影響あり（標準）
- CueOnly：そのCueだけ編集
- Block：Track継承を遮断

---

### 5-5. Enter×2（核となる安全HolySpec）

CueEdit は  
Enter → 予告  
Enter → 実行  
の2段階を必須。

理由：
- 記録事故防止
- Enter1回誤爆が最危険
- UIダイアログではなく Enter×2 で完結

---

### 5-6. 記録時の画面変化（将来 HolySpec）

- 記録モード中：RECキー赤点灯
- cmdBuffer：待機→確認→実行で段階表示
- 実行後：通常状態へ戻る

---

## 第6章 ― Part / Time / Delay / Link（Time仕様書v1 統合済み）

### 6.1 Part
Cue内のサブフェード。  
HolySpec：Partは配列で保持。

---

### 6.2 Part記述構文（Phase3実装予定）
例：
- `CUE 12 Part 1`
- `@ 40`
- `Time 3.`
- `Delay 1.`

---

### 6.3 Time（統合・確定仕様）

#### 6.3.1 Time 入力形式（確定 HolySpec）

- **Time X**：Up=X, Down=X  
- **Time X/Y**：Up=X, Down=Y  
- **Time X/0, Time 0/Y**：意図ある0として受理  
- **禁止（即エラー）**：`Time 3/` / `Time /3` / `Time 3//2` / `Time /`

#### 6.3.2 内部値の保持（確定）
Timeは `(up: Double, down: Double)` の組で保持。

#### 6.3.3 DefaultTime の適用（確定）
- Time未入力の場合：SettingのDefaultTimeを適用  
- 適用は **Rec/Update の保存時に実値として保存**（再生時の暗黙適用は禁止）

#### 6.3.4 表示フォーマット（確定）
- `3.0`→`3`、`0.0`→`0`
- up==down かつ単値入力 → `Time 3`
- 異なる場合 → `Time 3/1.5`
- 表示は **内部値から生成**

#### 6.3.5 エラー規則（確定）
- `3/`, `/3`, `3//2`, `/`, 空白スラッシュ等はエラー  
- エラー時：cmdBuffer赤、Enter不可、値は適用されない

#### 6.3.6 Draft と保存（Cue Edit 連動）
- Time入力はDraft  
- `Rec → Enter → Enter` で本保存  
- Time未入力は DefaultTime で保存

---

### 6.4 Delay / Wait
- `Delay 2`
- `Wait 1.`

---

### 6.5 Link（連結）
- `Link`
- `CUE 20 / 3`
- `Enter`

- `/` は回数
- HolySpecで構文のみ確定（Phase3）

---

## 第7章 ― Slash “/” HolySpec（Time仕様書v1 反映済み）

### 7.1 “/” の意味は文脈で決定する（確定）

1. **Time の区切り（Up/Down 分離子：最優先）**
2. **Link 回数指定**
3. Selecting（将来：ほぼ不可）
4. fallback → 無視

---

### 7.2 “/” と安全性（補強）

- 直前トークンで用途が100％決まる
- ambiguousは禁止
- **“@ の直後に /” は絶対禁止**
- **Time文脈で片側欠損（3/, /3）は即エラー**

---

### 7.3 “/” と Enter（確定）

- `/` は値確定ではない
- 次の数字 or Enter を待つ
- 片側欠損の状態では Enter 無効（Timeは特に厳格）

---

## 第8章 ― Utility

### 8.1 UNDO
- 直前の非危険操作を1手戻す
- Record/Delete実行は対象外

### 8.2 Clear
- cmdBufferクリア
- selectionは保持
- 削除用ではない

### 8.3 Backspace
- Token単位で戻す

### 8.4 Copy / Paste
選択セットの複製。

### 8.5 GoToCue / GoToNext（Utility分類）
（再掲）

### 8.6 CG（将来）
（予約）

### 8.7 Link（将来）
（予約）

---

## 第9章 ― Safety（Time仕様書v1 反映済み）

### 9.1 Enter×2
- Delete
- Record
- Update  
すべて2段階確定

### 9.2 再生中の制限
- 再生中：危険操作は Enter1回まで許可
- Enter2回目は playback完了後

### 9.3 入力値の clamp（補強）
- Time/Delay：`0 ≤ value ≤ 999`
- Level：`0 ≤ value ≤ 100`（内部表現に応じて）
- 小数桁制限（将来仕様）
- NaN/Inf は即拒否

### 9.4 SelectionとClearの関係
- Selectionは消さない
- lastSelection＠復元

### 9.5 UI警告色
- Record/Delete：赤
- LevelEntry：黄
- Playback：青
- Idle：グレー

---

## 第10章 ― Reflex Map（キー配置と意味）

### 10.1 HolySpecブロック
- 左3：文法（CUE/Ch/Time/Part）
- 数字4：値
- 中央2：補助（UNDO/Clear/Delete/⌫）
- 右3：ナビ（▲/▼/SelectLast/SelectActive）

### 10.2 色分け
- 赤：危険
- 黄：レベル
- 青：参照
- 緑：確定

### 10.3 キーサイズ（1x/2x）
2倍キー：
- REC◎
- Delete
- Enter↩

### 10.4 Reflex Mapの目的
- 手の動きが意味と一致
- プロは高速
- 初心者は安全
- 誤操作ゼロ

### 10.5 まとめ
- 直感で触っても壊れない
- 聖典とUIが完全連動
- 物理卓化しても違和感ゼロ

---

## 付録：チェックシート（実装者向け）（Time追記済み）

- [ ] Selection：IndexSetで再現できる
- [ ] Clear：cmdBufferのみクリア、選択は保持
- [ ] Level：@不要の2桁％が即時反映で動く
- [ ] @FF：FULL統一、英字FULLは使わない
- [ ] 相対入力：@ + / @ - がEOS互換
- [ ] レベル確定後も cmdBuffer保持が仕様通り
- [ ] lastSelection復元（選択空で@）が安全に動く
- [ ] CuePlayback：GO/STOP/BACK の状態遷移がHolySpec通り
- [ ] GOTO：カーソルのみ移動、再生しない
- [ ] CueEdit：Record/Update/Delete は Enter×2 必須
- [ ] Track/QOnly/Block の3モードのみ
- [ ] **Time：X と X/Y のみ許可、片側欠損（3/, /3）は拒否**
- [ ] **Time：内部は (up, down) Double、表示は内部から生成**
- [ ] **Time未入力：DefaultTime を保存時に実値として埋める**
- [ ] Safety：clamp（Time/Delay 0..999）とエラー時Enter不可
- [ ] 再生中：危険操作 Enter2回目は完了後

---

【END_FULL_HOLYSPEC】

---

# 【追記】v3.0 内部構造ルール（Write / Save / Recovery）

> 追記方針：既存の -1章／1〜10章（操作仕様）は変更せず、
> **第0章の末尾に“内部構造（実装者向け）”として追記**する。
> 操作仕様と衝突する場合は、**既存の聖典（操作仕様）を最優先**とする。

## 0-x. 内部構造ルール（Write / Save / Recovery）

本節は、Kimix v3.0 における **内部構造およびデータ操作責務**を定義する。  
本節の内容は、以降すべての章に優先して適用される内部ルールであり、  
操作仕様やユーザー挙動を規定するものではない。

### 用語定義

- **Write**  
  Cue Edit（Record / Update / Delete）により、  
  **ShowFile（DataOnly）内の CueData を更新する行為**を指す。

- **Save**  
  公演データを **ShowFolder（公演フォルダ）**として永続保存する行為を指す。  
  Save は基本的に **手動操作**で行われる。

- **Recovery（AutoSave）**  
  フリーズ・クラッシュ・強制終了からの復帰を目的とした、  
  **使用者が意識しない内部退避**を指す。  
  Recovery は Save とは異なり、公演保存を意味しない。

### Write の適用範囲

- Write が使用されるのは **Ch / Fader モード**のみとする。
- Patch モードでは Write を使用せず、Enter による即時確定とする。
- Write の対象は以下を含む（B）：
  - Channel / Fader Level
  - Part / Time / Delay / Link
  - Cue Edit に付随する記録モード（存在する場合）

### 責務分離（v3.0）

- **commit の統合出口**
  - すべての確定操作（10Key / UI ボタン）は  
    **DeskBridge に統合され、commit イベントとして発火**する。

- **Write 本体**
  - Write（CueData の更新適用）は  
    **Core に配置された `CueEdit_vm` が担当**する。
  - `CueEdit_vm` は commit を受け取り、  
    ShowFile（DataOnly）の CueData に対して Write を行う。

- **再生系**
  - `Cue_vm` / `CuePlayback_vm` は再生演算の心臓部とし、  
    Write 本体の責務を持たない。

### Recovery（内部退避）

- Recovery は **commit イベント発生時**にのみ行われる。
- 保存先は **ShowFolder 配下の内部用サブフォルダ**とする。  
  例：`/<ShowName>/_recovery/`
- Recovery に含める内容は以下を最小セットとする：
  - cmdBuffer
  - commit 直前までの操作状態
  - mode（Ch/Fader / Patch 等）
  - timestamp
- Patch 側の commit（Enter 確定）も Recovery に含める（復元率優先）。
- Recovery は使用者が気づく必要のない内部機構とする。

---

## 0-y. ShowFolder / ShowFile（DataOnly）定義

### ShowFolder（公演フォルダ）
- **保存・移動・バックアップ単位**：OS上の 1フォルダ = 1公演  
- 構成（v3.0 暫定）：
  ```
  /<ShowName>/
    ├─ ShowFile/      （CueData：正本データ）
    ├─ Patch/
    ├─ Fixture/
    ├─ Universe/
    ├─ Meta/
    └─ _recovery/     （内部退避：使用者は意識しない）
  ```
- 起動時ロード規則：
  - 前回終了時に有効データあり → 自動ロード優先
  - 新規／未指定 → 手動ロード優先

### ShowFile（DataOnly）
- **意味：実行時の正本データ（DataOnly）**
- 含む：CueData / PatchData / FixtureData / UniverseData / MetaData（将来含む）
- 含まない：UI状態（カーソル、選択、Live/Blind等）、保存／ロード処理

---

## 0-z. CueData 構造ロック（v3.0 / 最小＋拡張可能）

### CueItem（正本：1 Cue）
- `cueNumber: String`（小数点対応）  
  - 例：`"1"`, `"1.5"`, `"10.2"`
  - 正本は **表示用文字列** とする（表示と内部の不一致事故を避ける）

- `parts: [Part]`
  - **Part0 が本Cue**（基底Part）
  - Part は配列で保持する（Partが増えても構造が崩れない）

### Part（Cueのセクション単位）
- `time: (up: Double, down: Double)`
- `delay / wait / link`（Time仕様書・統合章の定義に従う）
- `levels`（レベル群）を保持する（下記）

### levels（拡張しやすいレベル表現：確定）
- 形：
  ```text
  levels:
    [ Channel:Int :
        [ ParamKey:String : Double ]
    ]
  ```
- 初期の必須 ParamKey：
  - `"Intensity"`（Ch/Fader の基本値）
- 将来拡張（例）：
  - `"Color.R"`, `"Color.G"`, `"Color.B"`
  - `"Beam.Iris"`, `"Beam.Zoom"`
  - `"Fx.Speed"` など

### DefaultTime の扱い（重要）
- DefaultTime は **Rec/Update の保存（Write）時に実値として保存する**。  
  再生時に暗黙適用して帳尻を合わせない（事故防止）。

---

## 0-aa. CueEdit_vm（Write本体）の責務とAPI粒度（v3.0）

### 目的
- DeskBridge から発火した **commit** を受け取り、  
  **ShowFile（DataOnly）の CueData に対して Write（適用）**を行う。

### 入力経路（固定）
- 10Key / UI ボタン → **DeskBridge（統合）** → `CueEdit_vm` → ShowFile（DataOnly）

### API粒度（固定：commit 1本）
- `CueEdit_vm` が外部に公開する入口は **1本**とする：
  - `commit(_ intent: CueEditIntent)`

> ※ここでの commit は「Enter回数」ではなく、  
> **操作仕様上の“実行（commit）”タイミング**を指す。  
> 予告段階（Enter 1回目など）では Write を行わない。

### CueEditIntent（最低限：v3.0）
- `op`: `record | update | delete`
- `targetCueNumber: String`（小数点対応、正本は文字列）
- `mode`: `track | cueOnly | block`（存在する場合）
- `partsDraft: [Part]`（Part0が本Cue。Time/Delay/Link含む）
- `levelsSnapshot`: `levels` と同形式（Ch/Faderの現時点スナップ）
- `timestamp`
- `source`: `tenKey | uiButton`（統合は維持、記録は残してよい）

### Write処理の必須ルール
- Write は **Ch/Faderモードのみ**。
- Patchモードは Write を使わない（Enter確定）。
- Write 実行時に必ず行う：
  - DefaultTime の実値化（保存時に埋める）
  - Cue番号の一意性維持（同番号の扱いは op に従う）
- Write 実行後、必ず Recovery を記録する：
  - `/<ShowName>/_recovery/` に commit時のみ退避（使用者は意識しない）

---

## 0-ab. 既存聖典との優先順位（確認）
- Cue番号やコマンドラインの詳細が既に聖典で確定している場合、  
  **本追記より既存の聖典を最優先**とする。




---

# 【追記】UI / Spec / View 責務規定（v3.0補完）

（※本追記は既存章を削除・要約せず、思想・制約レイヤとして上書き適用される）

## 第-1章 Usage / Guard / Stop Rules 追記

### -1.x UI構造に関する思考制約（Spec / View / VM）

本項は、Kimix Desk における UI 構造の思考暴走を防止するための強制制約である。

以下の違反は、すべて暴走とみなす。

- View 内に装飾値（色・余白・角丸・線幅・フォントサイズ・opacity 等）を直書きすること
- Spec が存在するにも関わらず、View 側で見た目を内包・再定義すること
- Spec を経由せずに UI 表情を変更・調整すること
- 「見た目は変わらない」という推測判断を根拠にすること

Spec を忘却した思考・実装は、善意であっても許可されない。

### -1.x-2 卓の表情（UI一貫性）に関する停止条件

UI の評価単位は画面・モード単位ではなく、常に卓全体である。

以下は禁止する。

- 特定モードのみ独自の表情を持たせること
- 「この画面だけ例外」という判断
- 設定画面・Patch画面を別UIとして扱う思考

### -1.x-3 今は行ってはいけないこと（沼防止）

- UI 表情の全面洗い出し・一斉修正
- Spec 統合を目的とした大規模工事
- 見た目統一を理由とした構造変更

---

## 第0章 基本原則 追記

### 0-x 卓の表情と UI 一貫性（Kimix Desk の顔）

Kimix Desk の卓の顔は UI 全体で構成される。

### 0-x-2 Spec の位置づけ（見た目の正本）

Spec は見た目の唯一の正本であり、View はこれを参照する存在である。
