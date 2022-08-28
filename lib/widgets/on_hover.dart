import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHover({
    Key? key,
    required this.builder,
    required this.isNav,
  }) : super(key: key);
  final bool isNav;

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final nav_hovered = Matrix4.identity()..translate(-5, -5, 0);
    final hovered = widget.isNav ? nav_hovered : Matrix4.identity()
      ..translate(10, 0, 0);
    final transform = isHovered ? hovered : Matrix4.identity();

    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: Container(
        // duration: const Duration(seconds: 1),
        transform: Matrix4.identity(),
        child: widget.builder(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
