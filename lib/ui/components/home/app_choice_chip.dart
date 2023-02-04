import 'package:flutter/material.dart';

class AppChoiceChip extends StatelessWidget {
  AppChoiceChip({
    Key? key,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.width = 100,
  }) : super(key: ValueKey(index));

  final int index;
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;
  final num width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ChoiceChip(
        key: ValueKey(index),
        selected: isSelected,
        onSelected: onSelected,
        label: SizedBox(
          height: 20,
          width: width.toDouble(),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
