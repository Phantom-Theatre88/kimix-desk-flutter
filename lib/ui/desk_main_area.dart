// lib/ui/desk_main_area.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-3: 画面分割テンプレ（MainArea）導入

import 'package:flutter/material.dart';
import '../app/desk_context_vm.dart';
import 'ch_fader_area.dart';
import 'cue_area.dart';

class DeskMainArea extends StatelessWidget {
  const DeskMainArea({
    super.key,
    required this.mode,
    required this.lastWorkWorld,
    required this.liveCtx,
    required this.blindCtx,
    required this.onSetWorldView,
    required this.cmdBufferText,
  });

  final DeskMode mode;
  final WorkWorld lastWorkWorld;
  final WorldContext liveCtx;
  final WorldContext blindCtx;
  final void Function(WorkWorld world, WorldView view) onSetWorldView;
  final String cmdBufferText;

  bool get _inWorkWorld => mode == DeskMode.live || mode == DeskMode.blind;

  WorkWorld get _currentWorld {
    if (mode == DeskMode.live) return WorkWorld.live;
    return WorkWorld.blind;
  }

  WorldContext _ctxFor(WorkWorld w) =>
      (w == WorkWorld.live) ? liveCtx : blindCtx;

  @override
  Widget build(BuildContext context) {
    // DeskTemplateの「中段 MainArea」：左が作業（Ch/Fader）、右がCue系（CueLine + CommandLine）
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: ChFaderArea(
              enabled: _inWorkWorld,
              world: _currentWorld,
              ctx: _ctxFor(_currentWorld),
              onSetWorldView: onSetWorldView,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: CueArea(
              // CommandLineは「見た目はCue直下」「意味は入力エコー寄り」：ロックどおり二重定義で扱う
              enabled: true,
              mode: mode,
              lastWorkWorld: lastWorkWorld,
              cmdBufferText: cmdBufferText,
            ),
          ),
        ],
      ),
    );
  }
}
