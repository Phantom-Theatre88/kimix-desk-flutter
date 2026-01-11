// lib/app/desk_shell.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F1-3: TopBar統合（Live/Blind二重表示の解消）
// Phase F1-4: モード色で「実行中モード」判別（暫定）
// Phase F2-2: DeskShell state を DeskContextVM に集約（挙動維持）
// Phase F2-3: 画面分割テンプレ導入 + Ch墓石スタブ建設

import 'dart:async';
import 'package:flutter/material.dart';
import 'desk_context_vm.dart';
import '../ui/desk_main_area.dart';
import '../ui/keypad_area.dart';

class DeskShell extends StatefulWidget {
  const DeskShell({super.key});

  @override
  State<DeskShell> createState() => _DeskShellState();
}

class _DeskShellState extends State<DeskShell> {
  // ===== 状態はVMに集約（挙動維持） =====
  DeskContextVM vm = const DeskContextVM(
    mode: DeskMode.live,
    lastWorkWorld: WorkWorld.live,
    liveCtx: WorldContext(view: WorldView.fader),
    blindCtx: WorldContext(view: WorldView.ch),
  );

  late final Timer _clockTimer;
  String _clockText = _formatClock(DateTime.now());

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final t = _formatClock(DateTime.now());
      if (t != _clockText) {
        setState(() => _clockText = t);
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  static String _formatClock(DateTime dt) {
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  void _selectMode(DeskMode m) {
    setState(() {
      var next = vm.copyWith(mode: m);
      if (m == DeskMode.live) next = next.copyWith(lastWorkWorld: WorkWorld.live);
      if (m == DeskMode.blind) next = next.copyWith(lastWorkWorld: WorkWorld.blind);
      vm = next;
    });
  }

  void _setWorldView(WorkWorld world, WorldView view) {
    setState(() {
      if (world == WorkWorld.live) {
        vm = vm.copyWith(liveCtx: vm.liveCtx.copyWith(view: view));
      } else {
        vm = vm.copyWith(blindCtx: vm.blindCtx.copyWith(view: view));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              mode: vm.mode,
              onSelectMode: _selectMode,
              clockText: _clockText,
              lastWorkWorld: vm.lastWorkWorld,
            ),

            // Middle: MainArea (Ch/Fader + Cue/CmdLine)
            Expanded(
              child: DeskMainArea(
                mode: vm.mode,
                lastWorkWorld: vm.lastWorkWorld,
                liveCtx: vm.liveCtx,
                blindCtx: vm.blindCtx,
                onSetWorldView: _setWorldView,
              ),
            ),

            // Bottom: 10Key (stub)
            const KeypadArea(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.mode,
    required this.onSelectMode,
    required this.clockText,
    required this.lastWorkWorld,
  });

  final DeskMode mode;
  final ValueChanged<DeskMode> onSelectMode;
  final String clockText;
  final WorkWorld lastWorkWorld;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const _LeftBrand(),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _ModeTabs(
                  mode: mode,
                  onSelect: onSelectMode,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _RightStatus(
            clockText: clockText,
            lastWorkWorld: lastWorkWorld,
          ),
        ],
      ),
    );
  }
}

class _LeftBrand extends StatelessWidget {
  const _LeftBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.theater_comedy, size: 18),
        SizedBox(width: 8),
        Text(
          'Kimix Desk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _ModeTabs extends StatelessWidget {
  const _ModeTabs({required this.mode, required this.onSelect});

  final DeskMode mode;
  final ValueChanged<DeskMode> onSelect;

  static Color _modeColor(DeskMode m) {
    // 仮色（美学は後でルールロックしてから詰める）
    switch (m) {
      case DeskMode.live:
        return Colors.red;
      case DeskMode.blind:
        return Colors.blue;
      case DeskMode.effect:
        return Colors.purple;
      case DeskMode.sub:
        return Colors.green;
      case DeskMode.setting:
        return Colors.orange;
    }
  }

  static String _label(DeskMode m) {
    switch (m) {
      case DeskMode.live:
        return 'Live';
      case DeskMode.blind:
        return 'Blind';
      case DeskMode.effect:
        return 'Effect';
      case DeskMode.sub:
        return 'Sub';
      case DeskMode.setting:
        return 'Setting';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        _chip(DeskMode.live),
        _chip(DeskMode.blind),
        _chip(DeskMode.effect),
        _chip(DeskMode.sub),
        _chip(DeskMode.setting),
      ],
    );
  }

  Widget _chip(DeskMode value) {
    final selected = mode == value;
    final c = _modeColor(value);

    return ChoiceChip(
      label: Text(_label(value)),
      selected: selected,
      onSelected: (_) => onSelect(value),
      selectedColor: c.withOpacity(0.85),
      backgroundColor: Colors.transparent,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: selected ? Colors.white : c,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: c,
          width: selected ? 2.0 : 1.0,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
    );
  }
}

class _RightStatus extends StatelessWidget {
  const _RightStatus({
    required this.clockText,
    required this.lastWorkWorld,
  });

  final String clockText;
  final WorkWorld lastWorkWorld;

  @override
  Widget build(BuildContext context) {
    final ww = (lastWorkWorld == WorkWorld.live) ? 'LIVE' : 'BLIND';
    return Wrap(
      spacing: 6,
      children: [
        _pill('Saved*'),
        _pill('Online'),
        _pill('DMX'),
        _pill('WW:$ww'),
        _pill(clockText),
      ],
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}