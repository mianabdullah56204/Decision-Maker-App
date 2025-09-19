import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  const HintCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates_outlined, size: 28),
          SizedBox(width: 12),

          Expanded(
            child: Text(
              'Add a few activities below, then tap “What should I do?”',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
