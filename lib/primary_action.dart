import 'package:flutter/material.dart';

class PrimaryAction extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  const PrimaryAction({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  State<PrimaryAction> createState() => _PrimaryActionState();
}

class _PrimaryActionState extends State<PrimaryAction> {
  double _tilt = 0;

  void _animate() {
    setState(() => _tilt = .08);
    Future.delayed(Duration(milliseconds: 140), () {
      if (mounted) setState(() => _tilt = 0);
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _tilt),
      duration: Duration(milliseconds: 140),
      builder: (context, value, child) =>
          Transform.rotate(angle: value, child: child),
      child: ElevatedButton.icon(
        onPressed: _animate,
        icon: Icon(widget.icon, size: 26),
        label: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
