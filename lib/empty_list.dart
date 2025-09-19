import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.list_alt, size: 48, color: cs.outline),
          SizedBox(height: 8),
          Text(
            'No activities yet',
            style: TextStyle(
              color: cs.outline,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Type one above or tap a quick suggestion',
            style: TextStyle(color: cs.outline),
          ),
        ],
      ),
    );
  }
}
