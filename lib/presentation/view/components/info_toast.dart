import 'package:flutter/material.dart';

class InfoToast extends StatefulWidget {
  final String message;
  final Color backgroundColor;

  const InfoToast({
    super.key,
    required this.message,
    required this.backgroundColor,
  });

  @override
  State<InfoToast> createState() => _InfoToastState();

  static void show(BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => InfoToast(
        message: message,
        backgroundColor: backgroundColor,
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _InfoToastState extends State<InfoToast> {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);
  final Duration _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: ValueListenableBuilder<bool>(
          valueListenable: _isVisible,
          builder: (context, visible, child) => AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: _animationDuration,
            child: child,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    _isVisible.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      _isVisible.value = false;
      Future.delayed(_animationDuration, () {});
    });
  }
}
