// lib/app/desk_shell.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F1-3: TopBar統合（Live/Blind二重表示の解消）
// + 文脈保持: 作業文脈(Live/Blind) と 表示文脈(Ch/Fader) を分離・保持

import 'dart:async';
import 'package:flutter/material.dart';

/// 大モード（全部モード移動）
enum DeskMode {
  live,
  blind,
  effect,
  sub,
  setting,
}

/// 作業文脈（Effect/Sub/Setting に行っても保持される）
enum WorkWorld {
  live,
  blind,
}

/// Live/Blind 内の表示文脈（2択でロック）
enum WorldView {
  ch,
  fader,
}

@immutable
class WorldContext {
  const WorldContext({required this.view});

  final WorldView view;

  WorldContext copyWith({WorldView? view}) {
    return WorldContext(view: view ?? this.view);
  }
}

class DeskShell extends StatefulWidget {
  const DeskShell({super.key});

  @override
  State<DeskShell> createState() => _DeskShellState();
}

class _DeskShellState extends State<DeskShell> {
  // ===== 層A: 現在の大モード =====
  DeskMode mode = DeskMode.live;

  // ===== 層B: 最後の作業文脈（Live/Blind） =====
  WorkWorld lastWorkWorld = WorkWorld.live;

  // ===== 層C: Live/Blind それぞれの表示文脈（独立記憶） =====
  WorldContext liveCtx = const WorldContext(view: WorldView.fader);
  WorldContext blindCtx = const WorldContext(view: WorldView.ch);

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

  // ===== Mode selection (single entry point) =====
  void _selectMode(DeskMode m) {
    setState(() {
      mode = m;

      // Live/Blind は作業文脈そのものなので、移動したら lastWorkWorld を更新
      if (m == DeskMode.live) lastWorkWorld = WorkWorld.live;
      if (m == DeskMode.blind) lastWorkWorld = WorkWorld.blind;

      // Effect/Sub/Setting は「表示の移動」であり、作業文脈は保持
      // （ここでは lastWorkWorld を触らない）
    });
  }

  // ===== View switching inside world (independent memory) =====
  void _setWorldView(WorkWorld world, WorldView view) {
    setState(() {
      if (world == WorkWorld.live) {
        liveCtx = liveCtx.copyWith(view: view);
      } else {
        blindCtx = blindCtx.copyWith(view: view);
      }
    });
  }

  WorldContext _ctxFor(WorkWorld w) => (w == WorkWorld.live) ? liveCtx : blindCtx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              mode: mode,
              onSelectMode: _selectMode,
              clockText: _clockText,
            ),
            Expanded(
              child: _MainAreaStub(
                mode: mode,
                lastWorkWorld: lastWorkWorld,
                liveCtx: liveCtx,
                blindCtx: blindCtx,
                onSetWorldView: _setWorldView,
              ),
            ),
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
  });

  final DeskMode mode;
  final ValueChanged<DeskMode> onSelectMode;
  final String clockText;

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
          _RightStatus(clockText: clockText),
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        _chip('Live', DeskMode.live),
        _chip('Blind', DeskMode.blind),
        _chip('Effect', DeskMode.effect),
        _chip('Sub', DeskMode.sub),
        _chip('Setting', DeskMode.setting),
      ],
    );
  }

  Widget _chip(String label, DeskMode value) {
    final selected = mode == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelect(value),
    );
  }
}

class _RightStatus extends StatelessWidget {
  const _RightStatus({required this.clockText});

  final String clockText;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        _pill('Saved*'),
        _pill('Online'),
        _pill('DMX'),
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

class _MainAreaStub extends StatelessWidget {
  const _MainAreaStub({
    required this.mode,
    required this.lastWorkWorld,
    required this.liveCtx,
    required this.blindCtx,
    required this.onSetWorldView,
  });

  final DeskMode mode;
  final WorkWorld lastWorkWorld;
  final WorldContext liveCtx;
  final WorldContext blindCtx;
  final void Function(WorkWorld world, WorldView view) onSetWorldView;

  String _modeLabel(DeskMode m) => switch (m) {
        DeskMode.live => 'Live',
        DeskMode.blind => 'Blind',
        DeskMode.effect => 'Effect',
        DeskMode.sub => 'Sub',
        DeskMode.setting => 'Setting',
      };

  String _worldLabel(WorkWorld w) => (w == WorkWorld.live) ? 'LIVE' : 'BLIND';

  String _viewLabel(WorldView v) => (v == WorldView.fader) ? 'FADER' : 'CH';

  @override
  Widget build(BuildContext context) {
    final currentModeText = _modeLabel(mode);

    // 作業文脈（Effect/Sub/Setting中でも保持される）
    final workWorldText = _worldLabel(lastWorkWorld);

    // 作業文脈側の表示文脈（Live/Blind で独立記憶）
    final activeCtx = (lastWorkWorld == WorkWorld.live) ? liveCtx : blindCtx;
    final activeViewText = _viewLabel(activeCtx.view);

    final inWorldMode = (mode == DeskMode.live || mode == DeskMode.blind);
    final currentWorld = (mode == DeskMode.live) ? WorkWorld.live : WorkWorld.blind;

    // 画面が Live/Blind のときは、その世界線の view を直接切替できる（stub UI）
    final ctxForCurrentWorld = (currentWorld == WorkWorld.live) ? liveCtx : blindCtx;

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main Area (Shared Space)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text('MODE = $currentModeText'),
          Text('WorkWorld (kept) = $workWorldText'),
          Text('WorkWorld View (kept) = $activeViewText'),
          const SizedBox(height: 12),
          if (inWorldMode) ...[
            const Divider(height: 1),
            const SizedBox(height: 12),
            Text(
              'View in ${_worldLabel(currentWorld)} (same cue, display only)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Ch'),
                  selected: ctxForCurrentWorld.view == WorldView.ch,
                  onSelected: (_) => onSetWorldView(currentWorld, WorldView.ch),
                ),
                ChoiceChip(
                  label: const Text('Fader'),
                  selected: ctxForCurrentWorld.view == WorldView.fader,
                  onSelected: (_) =>
                      onSetWorldView(currentWorld, WorldView.fader),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            const Text(
              'Effect/Sub/Setting: display moved, but WorkWorld is kept.',
            ),
          ],
        ],
      ),
    );
  }
}