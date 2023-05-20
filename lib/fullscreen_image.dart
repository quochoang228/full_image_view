import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_image.dart';

class AppHaptics {
  static bool debugSound = kDebugMode && enableDebugLogs;
  static bool debugLog = kDebugMode && enableDebugLogs;
  static bool enableDebugLogs = false;

  static Future<void> lightImpact() {
    _debug('lightImpact');
    return HapticFeedback.lightImpact();
  }

  static void _debug(String label) {
    if (debugLog) debugPrint('Haptic.$label');
    if (debugSound) {
      // SystemSound.play(SystemSoundType.alert); // only plays on desktop
      // SystemSound.play(SystemSoundType.click); // only plays on mobile
    }
  }
}

class FullscreenUrlImgViewer extends StatefulWidget {
  const FullscreenUrlImgViewer({
    Key? key,
    required this.urls,
    this.index = 0,
    this.label,
    this.iconClose,
    this.backgroudColor,
  }) : super(key: key);

  final List<String> urls;
  final int index;
  final String? label;
  final Widget? iconClose;
  final Color? backgroudColor;

  static const double imageScale = 2.5;

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBackPressed() =>
      Navigator.pop(context, _controller.page!.round());

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: _isZoomed,
      builder: (_, __) {
        final bool enableSwipe = !_isZoomed.value && widget.urls.length > 1;
        return PageView.builder(
          physics: enableSwipe
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: widget.urls.length,
          // itemBuilder: (_, index) => Container(
          //   color: Colors.amber,
          //   height: 400,
          //   width: 400,
          // ),
          itemBuilder: (_, index) => _Viewer(widget.urls[index], _isZoomed),
          onPageChanged: (_) => AppHaptics.lightImpact(),
        );
      },
    );

    content = Semantics(
      label: widget.label,
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return Container(
      color: widget.backgroudColor ?? Colors.white,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          SafeArea(
            child: GestureDetector(
              onTap: _handleBackPressed,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: widget.iconClose ??
                    const Icon(
                      Icons.close,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer(this.url, this.isZoomed, {Key? key}) : super(key: key);

  final String url;
  final ValueNotifier<bool> isZoomed;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> with SingleTickerProviderStateMixin {
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Reset zoom level to 1 on double-tap
  void _handleDoubleTap() => _controller.value = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        // transformationController: _controller,
        // onInteractionEnd: (_) =>
        //     widget.isZoomed.value = _controller.value.getMaxScaleOnAxis() > 1,
        // minScale: 1,
        // maxScale: 5,
        child: Hero(
          tag: widget.url,
          child: AppImage(
            image: NetworkImage(
             
              widget.url,
            ),
            fit: BoxFit.contain,
            scale: FullscreenUrlImgViewer.imageScale,
            progress: true,
          ),
        ),
      ),
    );
  }
}
