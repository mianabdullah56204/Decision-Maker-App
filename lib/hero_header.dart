import 'package:decision_maker/arc_painter.dart';
import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  final String? selected;
  const HeroHeader({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: ArcPainter(color: Colors.white.withOpacity(.15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
