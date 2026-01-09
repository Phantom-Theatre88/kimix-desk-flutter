import 'package:flutter/material.dart';

enum DeskMode {
  live,
  blind,
}

class DeskShell extends StatefulWidget {
  const DeskShell({super.key});

  @override
  State<DeskShell> createState() => _DeskShellState();
}

class _DeskShellState extends State<DeskShell> {
  DeskMode mode = DeskMode.live;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _TopHeaderStub(),
            _ModeBar(
              mode: mode,
              onSelect: (m) => setState(() => mode = m),
            ),
            Expanded(child: _MainAreaStub(mode: mode)),
          ],
        ),
      ),
    );
  }
}

class _TopHeaderStub extends StatelessWidget {
  const _TopHeaderStub();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: const Text(
        'Kimix Desk — Phase F1 (Skeleton)',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ModeBar extends StatelessWidget {
  const _ModeBar({
    required this.mode,
    required this.onSelect,
  });

  final DeskMode mode;
  final ValueChanged<DeskMode> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: [
          _chip(label: 'LIVE', value: DeskMode.live),
          _chip(label: 'BLIND', value: DeskMode.blind),
        ],
      ),
    );
  }

  Widget _chip({required String label, required DeskMode value}) {
    final selected = mode == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelect(value),
    );
  }
}

class _MainAreaStub extends StatelessWidget {
  const _MainAreaStub({required this.mode});

  final DeskMode mode;

  @override
  Widget build(BuildContext context) {
    final modeText = mode == DeskMode.live ? 'LIVE' : 'BLIND';

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text('Main Area (Shared Space)\nmode = $modeText'),
    );
  }
}

