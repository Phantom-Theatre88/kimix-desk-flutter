// lib/app/desk_context_vm.dart
// 根拠: Kimix v3.0 Flutter移行 ― 作業手順書 v1(通勤対応)🔐
// Phase F2-1: 状態の意味を「箱」として固定（UI配線は後工程）

import 'package:flutter/foundation.dart';

/// 大モード（全部モード移動）
enum DeskMode { live, blind, effect, sub, setting }

/// 作業文脈（Effect/Sub/Setting に行っても保持される）
enum WorkWorld { live, blind }

/// Live/Blind 内の表示文脈（2択でロック）
enum WorldView { ch, fader }

@immutable
class WorldContext {
  const WorldContext({required this.view});

  final WorldView view;

  WorldContext copyWith({WorldView? view}) {
    return WorldContext(view: view ?? this.view);
  }
}

/// DeskShellが必要とする「状態の意味」を束ねる箱（F2でVM駆動へ進む足場）
@immutable
class DeskContextVM {
  const DeskContextVM({
    required this.mode,
    required this.lastWorkWorld,
    required this.liveCtx,
    required this.blindCtx,
    required this.cmdBufferText,
  });

  final DeskMode mode;
  final WorkWorld lastWorkWorld;
  final WorldContext liveCtx;
  final WorldContext blindCtx;

  /// CommandLine: inputEcho（生テキスト）。解釈は後工程。
  final String cmdBufferText;

  DeskContextVM copyWith({
    DeskMode? mode,
    WorkWorld? lastWorkWorld,
    WorldContext? liveCtx,
    WorldContext? blindCtx,
    String? cmdBufferText,
  }) {
    return DeskContextVM(
      mode: mode ?? this.mode,
      lastWorkWorld: lastWorkWorld ?? this.lastWorkWorld,
      liveCtx: liveCtx ?? this.liveCtx,
      blindCtx: blindCtx ?? this.blindCtx,
      cmdBufferText: cmdBufferText ?? this.cmdBufferText,
    );
  }
}
