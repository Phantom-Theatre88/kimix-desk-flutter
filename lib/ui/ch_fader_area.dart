// lib/ui/ch_fader_area.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-3: Ch/Fader Area（今回対象）— まずは墓石（Ch表記）スタブ

import 'package:flutter/material.dart';
import '../app/desk_context_vm.dart';

class ChFaderArea extends StatelessWidget {
  const ChFaderArea({
    super.key,
    required this.enabled,
    required this.world,
    required this.ctx,
    required this.onSetWorldView,
  });

  final bool enabled;
  final WorkWorld world;
  final WorldContext ctx;
  final void Function(WorkWorld world, WorldView view) onSetWorldView;

  String get _worldLabel => (world == WorkWorld.live) ? 'LIVE' : 'BLIND';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: "Ch/Fader" + view switch (locked 2-choice)
          Row(
            children: [
              Text(
                'Ch/Fader Area ($_worldLabel)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              _viewChip(
                label: 'Ch',
                selected: ctx.view == WorldView.ch,
                onTap: enabled ? () => onSetWorldView(world, WorldView.ch) : null,
              ),
              const SizedBox(width: 6),
              _viewChip(
                label: 'Fader',
                selected: ctx.view == WorldView.fader,
                onTap: enabled ? () => onSetWorldView(world, WorldView.fader) : null,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: (!enabled)
                ? _placeholder(
                    context,
                    'Not in Live/Blind.\n(Effect/Sub/Setting placeholder)',
                  )
                : (ctx.view == WorldView.ch)
                    ? const _TombstoneGrid()
                    : _placeholder(context, 'Fader view: stub'),
          ),
        ],
      ),
    );
  }

  Widget _viewChip({
    required String label,
    required bool selected,
    required VoidCallback? onTap,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap?.call(),
    );
  }

  Widget _placeholder(BuildContext context, String text) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _TombstoneGrid extends StatelessWidget {
  const _TombstoneGrid();

  @override
  Widget build(BuildContext context) {
    // スタブ：Ch 1-60 を並べる（後でVM/ShowFileに差し替える前提）
    const chCount = 60;

    return GridView.builder(
      itemCount: chCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, i) {
        final ch = i + 1;

        // 仮レベル（見た目確認用。後で差し替え）
        final level = (ch * 3) % 101; // 0-100
        final selected = (ch == 1 || ch == 2); // 仮選択（後でSelectionへ）

        return _TombstoneTile(
          ch: ch,
          levelPercent: level,
          selected: selected,
        );
      },
    );
  }
}

class _TombstoneTile extends StatelessWidget {
  const _TombstoneTile({
    required this.ch,
    required this.levelPercent,
    required this.selected,
  });

  final int ch;
  final int levelPercent;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final borderWidth = selected ? 2.0 : 1.0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 上：Ch番号（墓石の表札）
          Text(
            'Ch $ch',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              decoration: selected ? TextDecoration.underline : null,
            ),
          ),
          const SizedBox(height: 6),

          // 中：簡易レベルバー（仮）
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: levelPercent.clamp(0, 100) / 100.0,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // 下：%表示（仮）
          Text(
            '$levelPercent%',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 11,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}