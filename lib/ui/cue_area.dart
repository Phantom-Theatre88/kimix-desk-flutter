// lib/ui/cue_area.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-3: CueAreaを「CueList主役(上) + CommandLine下帯(56px)」に整形
// Lock: CueList row height = 40px, CommandLine height = 56px
// NOTE: 機能追加なし。密度/階層/枠整理のみ。

import 'package:flutter/material.dart';
import '../app/desk_context_vm.dart';

class CueArea extends StatelessWidget {
  const CueArea({
    super.key,
    required this.enabled,
    required this.mode,
    required this.lastWorkWorld,
  });

  final bool enabled;
  final DeskMode mode;
  final WorkWorld lastWorkWorld;

  static const double _cmdHeight = 56.0;
  static const double _rowHeight = 40.0; // ✅ Kimロック(B)
  static const double _radius = 12.0;

  String get _modeLabel => switch (mode) {
        DeskMode.live => 'Live',
        DeskMode.blind => 'Blind',
        DeskMode.effect => 'Effect',
        DeskMode.sub => 'Sub',
        DeskMode.setting => 'Setting',
      };

  String get _wwLabel => (lastWorkWorld == WorkWorld.live) ? 'LIVE' : 'BLIND';

  @override
  Widget build(BuildContext context) {
    // 右ペイン：上=CueList（主役） / 下=CommandLine（固定帯 56px）
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(_radius),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // ===== CueList (main) =====
          Expanded(
            child: _cueListPanel(context),
          ),

          const SizedBox(height: 10),

          // ===== CommandLine (fixed) =====
          SizedBox(
            height: _cmdHeight,
            child: _commandLine(context),
          ),
        ],
      ),
    );
  }

  Widget _cueListPanel(BuildContext context) {
    // 「1枚の面」に見せるため、余計な見出しを置かない。CueLineはヘッダ行に吸収。
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(_radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header row (CueLine吸収) — 40pxに統一
          SizedBox(
            height: _rowHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Cue 1',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Name: (stub)',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'MODE=$_modeLabel',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),

          // List (dense)
          Expanded(
            child: _cueListDense(context),
          ),
        ],
      ),
    );
  }

  Widget _cueListDense(BuildContext context) {
    // まずは密度と階層のみ。後でVMに差し替える前提のスタブ。
    // itemExtentで40px固定 → “卓の一覧”っぽい詰まりを作る。
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemExtent: _rowHeight,
      itemCount: 30,
      itemBuilder: (context, i) {
        final cueNo = i + 1;
        final selected = cueNo == 1; // 仮：ヘッダCueと揃える

        return InkWell(
          onTap: enabled ? () {} : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    'Cue $cueNo',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w900 : FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'stub',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                if (selected) ...[
                  const SizedBox(width: 8),
                  const Text('▶', style: TextStyle(fontSize: 12)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _commandLine(BuildContext context) {
    // 「ワイドいっぱい不要」＝右ペイン幅に従属する帯でOK
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(_radius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          const Text(
            'CMD:',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '(input echo stub)  1 THRU 5 @ 50 ENTER',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'WW=$_wwLabel',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}