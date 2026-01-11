// lib/ui/keypad_area.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-4d: KeyBoardArea（10Key）をスクショ配列に寄せて“見た目復元”
// Lock: ブロック標題は撤去（面積優先）。全キーは No-op（配線は後Phase）。
// NOTE: 卓っぽい「密度」と「配列」を先に作り、沼（機能/美学）に入らない。

import 'package:flutter/material.dart';

const double keyUnitGap = 4.0;
const double keyRowHeight = 1.0;

class KeypadArea extends StatelessWidget {
  const KeypadArea({super.key});

  static const double _height = 260;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Left grid area
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                    flex: (keyRowHeight * 1000).toInt(),
                    child: Row(
                      children: [
                        _keyCell('CUE'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Time'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('TRACK\nQ Only'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('7'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('8'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('9'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('@FF'),
                        SizedBox(width: keyUnitGap),
                        _keyButton2U('REC', kind: KeyKind.rec),
                        SizedBox(width: keyUnitGap),
                        _keyButton2U('UNDO', kind: KeyKind.blue),
                        SizedBox(width: keyUnitGap),
                        _keyCell('GoTo\nNext'),
                      ],
                    ),
                  ),
                  SizedBox(height: keyUnitGap),
                  Expanded(
                    flex: (keyRowHeight * 1000).toInt(),
                    child: Row(
                      children: [
                        _keyCell('Ch'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('/'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Step'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('4'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('5'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('6'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('+'),
                        SizedBox(width: keyUnitGap),
                        _keyIconCell(Icons.backspace_outlined),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Clear'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Copy'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Paste'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('GoTo\nCue'),
                      ],
                    ),
                  ),
                  SizedBox(height: keyUnitGap),
                  Expanded(
                    flex: (keyRowHeight * 1000).toInt(),
                    child: Row(
                      children: [
                        _keyCell('CG'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Wait'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Link'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('1'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('2'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('3'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('THRU'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('+5'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('-5'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Select\nLast'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('▲'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Select\nActive'),
                      ],
                    ),
                  ),
                  SizedBox(height: keyUnitGap),
                  Expanded(
                    flex: (keyRowHeight * 1000).toInt(),
                    child: Row(
                      children: [
                        _keyCell('Part'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Delay'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('Block'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('0'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('.'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('@'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('-'),
                        SizedBox(width: keyUnitGap),
                        _keyButton2U('ENTER ↵', kind: KeyKind.green),
                        SizedBox(width: keyUnitGap),
                        _keyCell('◀︎'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('▼'),
                        SizedBox(width: keyUnitGap),
                        _keyCell('▶︎'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            // Right independent vertical column
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        // Left sub-column: CUE ◀︎ and CUE ▶︎ vertical buttons
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(child: _keyButton('CUE ▲')),
                              SizedBox(height: keyUnitGap),
                              Expanded(child: _keyButton('CUE ▼')),
                            ],
                          ),
                        ),
                        SizedBox(width: keyUnitGap),
                        // Center sub-column: A/B cross indicator stub
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'A / B',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'cross\n(stub)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: keyUnitGap),
                        // Right sub-column: STOP and GO vertical buttons
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(child: _keyButton('STOP', kind: KeyKind.red)),
                              SizedBox(height: keyUnitGap),
                              Expanded(child: _keyButton('GO', kind: KeyKind.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _keyCell(String label) {
    return Expanded(
      child: _KeyButton(
        label: label,
      ),
    );
  }

  Widget _keyIconCell(IconData icon) {
    return Expanded(
      child: _KeyButton(
        label: '',
        icon: icon,
      ),
    );
  }

  Widget _keyButton2U(String label, {KeyKind kind = KeyKind.normal}) {
    return Expanded(
      flex: 2,
      child: _KeyButton(
        label: label,
        kind: kind,
      ),
    );
  }

  Widget _keyButton(String label, {KeyKind kind = KeyKind.normal}) {
    return _KeyButton(
      label: label,
      kind: kind,
    );
  }
}

enum KeyKind { normal, red, green, blue, rec }

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.label,
    this.kind = KeyKind.normal,
    this.icon,
  });

  final String label;
  final KeyKind kind;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final baseShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(width: 1),
    );

    final bool multiline = label.contains('\n');
    final bool compact = label.startsWith('Select') || label.startsWith('TRACK');
    final EdgeInsetsGeometry keyPadding = compact
        ? const EdgeInsets.symmetric(horizontal: 6, vertical: 6)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 8);

    final bool longLabel = label.startsWith('Select') || label.startsWith('TRACK');
    final double labelFontSize = (multiline && longLabel) ? 12 : 14;

    ButtonStyle style;
    switch (kind) {
      case KeyKind.red:
        style = ElevatedButton.styleFrom(
          shape: baseShape,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: keyPadding,
        );
        break;
      case KeyKind.green:
        style = ElevatedButton.styleFrom(
          shape: baseShape,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: keyPadding,
        );
        break;
      case KeyKind.blue:
        style = ElevatedButton.styleFrom(
          shape: baseShape,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: keyPadding,
        );
        break;
      case KeyKind.rec:
        style = ElevatedButton.styleFrom(
          shape: baseShape,
          backgroundColor: Colors.red.shade400,
          foregroundColor: Colors.white,
          padding: keyPadding,
        );
        break;
      case KeyKind.normal:
        style = OutlinedButton.styleFrom(
          shape: baseShape,
          padding: keyPadding,
        );
        break;
    }

    final Widget child;
    if (icon != null && label.isNotEmpty) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
              fontSize: labelFontSize,
              fontWeight: (kind == KeyKind.normal) ? FontWeight.w600 : FontWeight.w900,
              height: 1.05,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      child = Icon(icon, size: 18);
    } else {
      child = Text(
        label,
        textAlign: TextAlign.center,
        softWrap: multiline,
        overflow: TextOverflow.clip,
        maxLines: multiline ? 3 : 1,
        style: TextStyle(
          fontSize: labelFontSize,
          fontWeight: (kind == KeyKind.normal) ? FontWeight.w600 : FontWeight.w900,
          height: 1.05,
        ),
      );
    }

    // No-op
    if (kind == KeyKind.normal) {
      return SizedBox.expand(
        child: OutlinedButton(
          onPressed: () {},
          style: style,
          child: child,
        ),
      );
    } else {
      return SizedBox.expand(
        child: ElevatedButton(
          onPressed: () {},
          style: style,
          child: child,
        ),
      );
    }
  }
}