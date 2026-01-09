// lib/app/desk_shell.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F1-3: TopBar統合（Live/Blind二重表示の解消）

import 'dart:async';
import 'package:flutter/material.dart';

enum DeskMode {
  live,
  blind,
}

enum TopTab {
  live,
  blind,
  effect,
  sub,
  setting,
}

class DeskShell extends StatefulWidget {
  const DeskShell({super.key});

  @override
  State<DeskShell> createState() => _DeskShellState();
}

class _DeskShellState extends State<DeskShell> {
  DeskMode mode = DeskMode.live;
  TopTab tab = TopTab.live;

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

  void _selectTab(TopTab t) {
    setState(() {
      tab = t;
      if (t == TopTab.live) mode = DeskMode.live;
      if (t == TopTab.blind) mode = DeskMode.blind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              tab: tab,
              onSelectTab: _selectTab,
              clockText: _clockText,
            ),
            Expanded(
              child: _MainAreaStub(
                tab: tab,
                mode: mode,
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
    required this.tab,
    required this.onSelectTab,
    required this.clockText,
  });

  final TopTab tab;
  final ValueChanged<TopTab> onSelectTab;
  final String clockText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // Left: 卓名称 / ロゴ（仮）
          const _LeftBrand(),

          const SizedBox(width: 12),

          // Center-left: モードタブ群
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _TopTabs(
                  tab: tab,
                  onSelect: onSelectTab,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Right: ステータス
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

class _TopTabs extends StatelessWidget {
  const _TopTabs({required this.tab, required this.onSelect});

  final TopTab tab;
  final ValueChanged<TopTab> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        _tabChip('Live', TopTab.live),
        _tabChip('Blind', TopTab.blind),
        _tabChip('Effect', TopTab.effect),
        _tabChip('Sub', TopTab.sub),
        _tabChip('Setting', TopTab.setting),
      ],
    );
  }

  Widget _tabChip(String label, TopTab value) {
    final selected = tab == value;
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
  const _MainAreaStub({required this.tab, required this.mode});

  final TopTab tab;
  final DeskMode mode;

  @override
  Widget build(BuildContext context) {
    final tabText = switch (tab) {
      TopTab.live => 'Live',
      TopTab.blind => 'Blind',
      TopTab.effect => 'Effect',
      TopTab.sub => 'Sub',
      TopTab.setting => 'Setting',
    };
    final modeText = (mode == DeskMode.live) ? 'LIVE' : 'BLIND';

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        'Main Area (Shared Space)\nTAB = $tabText\nmode = $modeText',
      ),
    );
  }
}
