import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
  });

  final List<String> sizes;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final s in sizes)
          _SizeChip(
            label: s,
            isSelected: s == selected,
            onTap: () => onSelected(s),
          ),
      ],
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? const Color(0xFF9C6A52) : const Color(0xFFF3F3F3);
    final fg = isSelected ? Colors.white : Colors.black87;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w700, color: fg, fontSize: 13),
        ),
      ),
    );
  }
}
