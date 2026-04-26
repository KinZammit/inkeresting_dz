import 'package:flutter/material.dart';
import '../data/tattoo_data.dart';
import '../models/tattoo.dart';
import '../widgets/tattoo_card.dart';
import '../widgets/tag_filter_bar.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Set<String> savedIds;
  final Future<void> Function(String id) onToggleSaved;

  const HomeScreen({
    super.key,
    required this.savedIds,
    required this.onToggleSaved,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _activeTag;

  List<Tattoo> get _filtered {
    if (_activeTag == null) return kTattoos;
    return kTattoos.where((t) => t.tags.contains(_activeTag)).toList();
  }

  List<String> get _allTags {
    final tags = <String>{};
    for (final t in kTattoos) {
      tags.addAll(t.tags);
    }
    return ['All', ...tags.toList()..sort()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inkeresting',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: TagFilterBar(
            tags: _allTags,
            activeTag: _activeTag,
            onTagSelected: (tag) {
              setState(() => _activeTag = tag == 'All' ? null : tag);
            },
          ),
        ),
      ),
      body: _filtered.isEmpty
          ? const Center(child: Text('No tattoos for this style.'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.72,
              ),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final tattoo = _filtered[index];
                return TattooCard(
                  tattoo: tattoo,
                  isSaved: widget.savedIds.contains(tattoo.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          tattoo: tattoo,
                          isSaved: widget.savedIds.contains(tattoo.id),
                          onToggleSaved: widget.onToggleSaved,
                          ),
                        ),
                    );
                  },
                );
              },
            ),
    );
  }
}