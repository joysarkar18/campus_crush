import 'package:campus_crush/core/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();

  factory LoadingOverlay() {
    return _instance;
  }

  LoadingOverlay._internal();

  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    if (_overlayEntry != null) {
      // If already showing, do nothing
      return;
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Container(
            color: Colors.black
                .withValues(alpha: 0.5), // Optional background color
            child: Center(
              child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryBlue),
                  child: (const CupertinoActivityIndicator(
                    color: Colors.amber,
                    radius: 16,
                  ))), // Your loading indicator
            ),
          ),
        ],
      ),
    );
  }
}
