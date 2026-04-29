import 'package:flutter/material.dart';

class ParallaxWrapper extends StatefulWidget {
  final Widget child;
  final double intensity;

  const ParallaxWrapper({
    super.key,
    required this.child,
    this.intensity = 20.0,
  });

  @override
  State<ParallaxWrapper> createState() => _ParallaxWrapperState();
}

class _ParallaxWrapperState extends State<ParallaxWrapper> {
  double _x = 0.0;
  double _y = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final size = MediaQuery.of(context).size;
        setState(() {
          _x = (event.position.dx - size.width / 2) / (size.width / 2);
          _y = (event.position.dy - size.height / 2) / (size.height / 2);
        });
      },
      onExit: (_) {
        setState(() {
          _x = 0.0;
          _y = 0.0;
        });
      },
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: Offset.zero, end: Offset(_x, _y)),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        builder: (context, offset, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(offset.dx * 0.1)
              ..rotateX(-offset.dy * 0.1)
              ..translate(
                offset.dx * widget.intensity,
                offset.dy * widget.intensity,
              ),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
