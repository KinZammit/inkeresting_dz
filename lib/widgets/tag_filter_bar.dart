import 'package:flutter/material.dart';

class TagFilterBar extends StatelessWidget {
  final List<String> tags;
  final String? activeTag;
  final void Function(String) onTagSelected;

  const TagFilterBar({
    super.key,
    required this.tags,
    required this.activeTag,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isActive =
              tag == 'All' ? activeTag == null : activeTag == tag; // fixed
          return FilterChip(
            label: Text(tag),
            selected: isActive,
            onSelected: (_) => onTagSelected(tag),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}