import 'package:flutter/material.dart';
import 'app/desk_shell.dart';

void main() {
  runApp(const KimixApp());
}

class KimixApp extends StatelessWidget {
  const KimixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeskShell(),
    );
  }
}
