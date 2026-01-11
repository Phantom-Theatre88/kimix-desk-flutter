// lib/ui/ch_fader_area.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-5a: Ch墓石（1Cue固定）+ Prev/Current/Next 予告帯（Cue番号のみ）
// Lock: 墓石セルは上下分割（上25%: CH番号 / 下75%: レベル）。角丸は 6px 固定。
// Phase F2-6: Fader治具（50%アンカー固定）— まずは表示だけ（連動なし）

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
      padding: const EdgeInsets.all(8),
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
                onTap: enabled
                    ? () => onSetWorldView(world, WorldView.ch)
                    : null,
              ),
              const SizedBox(width: 6),
              _viewChip(
                label: 'Fader',
                selected: ctx.view == WorldView.fader,
                onTap: enabled
                    ? () => onSetWorldView(world, WorldView.fader)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: (!enabled)
                ? _placeholder(
                    context,
                    'Not in Live/Blind.\n(Effect/Sub/Setting placeholder)',
                  )
                : (ctx.view == WorldView.ch)
                ? const _ChTombstoneView()
                : _FaderRigView(),
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

class _ChTombstoneView extends StatelessWidget {
  const _ChTombstoneView();

  static const double _previewBandHeight = 20;
  static const double _gap = 4;
  static const double _radius = 6;

  static const int _cols = 12;
  static const int _rows = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CuePreviewBand(height: _previewBandHeight),
        const SizedBox(height: _gap),
        Expanded(
          child: _TombstoneGrid(cols: _cols, rows: _rows, radius: _radius),
        ),
      ],
    );
  }
}

class _CuePreviewBand extends StatelessWidget {
  const _CuePreviewBand({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    // Stub cue numbers (replace later from VM)
    const prev = 12;
    const current = 13;
    const next = 14;

    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Row(
        children: [
          _CueChip(label: 'Prev', number: prev),
          SizedBox(width: 8),
          _CueChip(label: 'Current', number: current, emphasis: true),
          SizedBox(width: 8),
          _CueChip(label: 'Next', number: next),
        ],
      ),
    );
  }
}

class _CueChip extends StatelessWidget {
  const _CueChip({
    required this.label,
    required this.number,
    this.emphasis = false,
  });

  final String label;
  final int number;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: emphasis ? const Color(0xFFFFB300) : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(999),
          color: null,
        ),
        alignment: Alignment.center,
        child: Text(
          '$label: $number',
          style: TextStyle(
            fontSize: 12,
            fontWeight: emphasis ? FontWeight.w800 : FontWeight.w600,
          ),
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ),
    );
  }
}

class _TombstoneGrid extends StatelessWidget {
  const _TombstoneGrid({
    required this.cols,
    required this.rows,
    required this.radius,
  });

  final int cols;
  final int rows;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final total = cols * rows;

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        const spacing = 3.0;
        final cellW = (w - (cols - 1) * spacing) / cols;
        final cellH = (h - (rows - 1) * spacing) / rows;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(total, (i) {
            final ch = i + 1;
            final level = _stubLevelFor(ch);
            final selected = (ch == 1 || ch == 2); // stub selection

            return SizedBox(
              width: cellW,
              height: cellH,
              child: _TombstoneTile(
                ch: ch,
                levelText: level,
                selected: selected,
                radius: radius,
              ),
            );
          }),
        );
      },
    );
  }

  static String _stubLevelFor(int ch) {
    final v = (ch * 7) % 101;
    return '$v%';
  }
}

class _TombstoneTile extends StatelessWidget {
  const _TombstoneTile({
    required this.ch,
    required this.levelText,
    required this.selected,
    required this.radius,
  });

  final int ch;
  final String levelText;
  final bool selected;
  final double radius;

  @override
  Widget build(BuildContext context) {
    // Selection recognition: border color (yellow/orange), not thicker border.
    const selectedBorderColor = Color(0xFFFFB300); // amber
    final borderColor = selected ? selectedBorderColor : Colors.black;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          // 上25%: CH番号
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9EE),
                border: const Border(bottom: BorderSide(width: 1)),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                ),
              ),
              child: Text(
                '$ch',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),

          // 下75%: レベル
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                levelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaderRigView extends StatefulWidget {
  _FaderRigView();

  // Lock anchor: knob center at 50% == 50% tick line
  static const int cols = 16;
  static const int rows = 2;
  static const int perPage = cols * rows; // 32
  static const int maxPages = 32; // 🔐 lock

  static const double minFaderWidth = 54;
  static const double rowGap = 10;
  static const double colGap = 8;
  static const double pagerBarH = 28;

  @override
  State<_FaderRigView> createState() => _FaderRigViewState();
}

class _FaderRigViewState extends State<_FaderRigView> {
  int _page = 0; // 0-based

  // Per-page stub value (0–100). This will later be replaced by VM values.
  final Map<int, int> _pageValue = {};

  int _currentValue() => _pageValue[_page] ?? 50;

  void _setCurrentValue(int v) {
    final vv = v.clamp(0, 100);
    setState(() => _pageValue[_page] = vv);
  }

  void _prev() {
    if (_page <= 0) return;
    setState(() => _page -= 1);
  }

  void _next() {
    if (_page >= _FaderRigView.maxPages - 1) return;
    setState(() => _page += 1);
  }

  @override
  Widget build(BuildContext context) {
    // Phase F2-6: First build ONE fader strip cleanly, then expand to 2x16.
    // Paging UI stays visible (Page 1..32), but only one strip is shown for now.

    final value = _currentValue(); // 0–100

    return LayoutBuilder(
      builder: (context, c) {
        final availableH = c.maxHeight.isFinite ? c.maxHeight : 300.0;
        final bodyH = (availableH - _FaderRigView.pagerBarH - 6).clamp(
          1.0,
          99999.0,
        );

        // Use available width (avoid fixed 54px * 16 overflow during the one-strip phase)
        final stripW = c.maxWidth.clamp(80.0, 140.0);

        return Column(
          children: [
            _FaderPagerBar(
              height: _FaderRigView.pagerBarH,
              page1Based: _page + 1, // 🔐 display only
              onPrev: _prev,
              onNext: _next,
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: bodyH,
              child: Center(
                child: SizedBox(
                  width: stripW,
                  height: bodyH,
                  child: _FaderStrip(
                    indexLabel: '${_page + 1}',
                    value: value,
                    onSetValue: _setCurrentValue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FaderPagerBar extends StatelessWidget {
  const _FaderPagerBar({
    required this.height,
    required this.page1Based,
    required this.onPrev,
    required this.onNext,
  });

  final double height;
  final int page1Based;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          IconButton(
            onPressed: onPrev,
            icon: const Text(
              '◀︎',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 28),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                'Page $page1Based',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onNext,
            icon: const Text(
              '▶︎',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 28),
          ),
        ],
      ),
    );
  }
}

class _FaderRow extends StatelessWidget {
  const _FaderRow({
    required this.startIndex,
    required this.values,
    required this.rowHeight,
  });

  final int startIndex;
  final List<int> values;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(values.length, (i) {
        final faderNo = startIndex + i;
        final value = values[i].clamp(0, 100);

        return Padding(
          padding: EdgeInsets.only(
            right: (i == values.length - 1) ? 0 : _FaderRigView.colGap,
          ),
          child: SizedBox(
            width: _FaderRigView.minFaderWidth,
            height: rowHeight,
            child: _FaderStrip(
              indexLabel: '$faderNo',
              value: value,
              onSetValue: (_) {},
            ),
          ),
        );
      }),
    );
  }
}

class _FaderStrip extends StatelessWidget {
  const _FaderStrip({
    required this.indexLabel,
    required this.value,
    required this.onSetValue,
  });

  final String indexLabel;
  final int value;
  final ValueChanged<int> onSetValue;

  // ===== Visual constants (keep small / safe; tune later) =====
  static const double _labelHeight = 18;
  static const double _trackTopPad = 8;
  static const double _trackBottomPad = 10;
  static const double _tickAreaWidth = 12;
  static const double _knobHeight = 18;
  static const double _knobWidth = 22;

  // ===== Holy locks (from Swift v2.6.1) =====
  // - Anchor: knob center at 50% == 50% tick line
  // - Tick Y correction: p + 0.010
  // - 0% / 50% / 100%: do not draw tick lines (labels only)
  static const double _pOffset = 0.010; // 🔐

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: _labelHeight,
          child: Center(
            child: Text(
              indexLabel,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, c2) {
              final h2 = c2.maxHeight;
              final trackH = (h2 - _trackTopPad - _trackBottomPad).clamp(
                1.0,
                99999.0,
              );

              // ===== Single-source-of-truth mapping (Swift v2.6.1) =====
              // Use pp = clamp(p + pOffset) for BOTH knob and tick/labels.
              final knobHalf = _knobHeight / 2.0;
              final minY = _trackTopPad + knobHalf;
              final maxY = _trackTopPad + trackH - knobHalf;
              final travel = (maxY - minY).clamp(1.0, 99999.0);

              final p = (value / 100.0).clamp(0.0, 1.0);
              final pp = (p + _pOffset).clamp(0.0, 1.0); // 🔐
              final yCenter = (maxY - pp * travel).roundToDouble();

              void setFromLocalDy(double localDy) {
                final y = localDy.clamp(minY, maxY);

                // Hard snap at ends so 0%/100% are reachable even with pOffset.
                // (Keep 50% anchor mapping intact for the interior.)
                const eps = 0.5; // small tolerance in px
                if (y <= minY + eps) {
                  onSetValue(100);
                  return;
                }
                if (y >= maxY - eps) {
                  onSetValue(0);
                  return;
                }

                final pp2 = ((maxY - y) / travel).clamp(0.0, 1.0);
                final p2 = (pp2 - _pOffset).clamp(0.0, 1.0); // 🔐 inverse
                final v = (p2 * 100.0).round().clamp(0, 100);
                onSetValue(v);
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (d) => setFromLocalDy(d.localPosition.dy),
                onPanUpdate: (d) => setFromLocalDy(d.localPosition.dy),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Track + ticks (tick painter draws within trackH)
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: _trackTopPad,
                          bottom: _trackBottomPad,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Tick + label area
                            SizedBox(
                              width: _tickAreaWidth,
                              child: CustomPaint(
                                painter: _TickPainter(
                                  knobHeight: _knobHeight,
                                  pOffset: _pOffset,
                                  suppressTicksAt: const {0, 50, 100},
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            // Track area
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Knob (centered on yCenter)
                    Positioned(
                      left: _tickAreaWidth + 2 + 4,
                      top: yCenter - _knobHeight / 2,
                      child: Container(
                        width: _knobWidth,
                        height: _knobHeight,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // % text (centered on the same y)
                    Positioned(
                      right: 0,
                      top: yCenter - 8,
                      child: Text(
                        '$value%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TickPainter extends CustomPainter {
  const _TickPainter({
    required this.knobHeight,
    required this.pOffset,
    required this.suppressTicksAt,
  });

  final double knobHeight;
  final double pOffset; // 🔐 p + 0.010
  final Set<int> suppressTicksAt; // e.g. {0,50,100}

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Swift v2.6.1 mapping (same ruler as knob):
    // minY = knobH/2, maxY = H - knobH/2, travel = max(1, maxY-minY)
    // y = (maxY - pp*travel).rounded, where pp = clamp(p + 0.010)
    final knobHalf = knobHeight / 2.0;
    final minY = knobHalf;
    final maxY = (size.height - knobHalf).clamp(minY, 99999.0);
    final travel = (maxY - minY).clamp(1.0, 99999.0);

    double yFor(int v) {
      final p = (v / 100.0).clamp(0.0, 1.0);
      final pp = (p + pOffset).clamp(0.0, 1.0);
      return (maxY - pp * travel).roundToDouble();
    }

    void tick(int v, double len, {bool strong = false}) {
      if (suppressTicksAt.contains(v)) return;
      paint.color = strong ? Colors.black : Colors.black54;
      final y = yFor(v);
      canvas.drawLine(
        Offset(size.width - len, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Minor ticks
    tick(75, 8);
    tick(25, 8);

    // Strong tick at 50 (kept for future; suppressed by default set)
    tick(50, 10, strong: true);

    // End ticks (suppressed; labels-only policy)
    tick(100, 10);
    tick(0, 10);

    // Labels only for 0 / 50 / 100
    final tp = TextPainter(textDirection: TextDirection.ltr);
    void label(int v, String text) {
      final y = yFor(v);
      tp.text = TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      );
      tp.layout(maxWidth: size.width);
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }

    label(100, '100');
    label(50, '50');
    label(0, '0');
  }

  @override
  bool shouldRepaint(covariant _TickPainter oldDelegate) {
    return oldDelegate.knobHeight != knobHeight ||
        oldDelegate.pOffset != pOffset ||
        oldDelegate.suppressTicksAt != suppressTicksAt;
  }
}
