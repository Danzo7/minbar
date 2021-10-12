import 'package:flutter/material.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class Snaps {
  static SnapScrollPhysics profileHeaderSnap() {
    return SnapScrollPhysics(parent: BouncingScrollPhysics(), snaps: [
      Snap(300,
          distance:
              50), // If the scroll offset is expected to stop between 150-250 the scroll will snap to 200,
      Snap(300,
          leadingDistance:
              50), // If the scroll offset is expected to stop  between 150-200 the scroll will snap to 200,
      Snap(300,
          trailingDistance:
              50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
      Snap.avoidZone(0,
          300), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
      Snap.avoidZone(0, 300,
          delimiter:
              50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
    ]);
  }
}
