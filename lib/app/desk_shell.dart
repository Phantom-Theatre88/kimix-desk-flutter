// lib/app/desk_shell.dart
import 'package:flutter/material.dart';

class DeskShell extends StatelessWidget {
  const DeskShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            _TopHeaderStub(),
            Expanded(child: _MainAreaStub()),
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

class _MainAreaStub extends StatelessWidget {
  const _MainAreaStub();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Text('Main Area (Shared Space)'),
    );
  }
}
