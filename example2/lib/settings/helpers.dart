import 'package:flutter/material.dart';

//* Helpers --------------------------------------------------------------------

class SliderListTile extends StatelessWidget {
  const SliderListTile({super.key,
    required this.value,
    required this.title,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  });

  final double value;
  final String title;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    final String label = value.toString();

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('$title ($label)'),
      ),
      contentPadding: const EdgeInsets.only(top: 8),
      subtitle: Slider(
        min: min,
        max: max,
        value: value,
        label: label,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
