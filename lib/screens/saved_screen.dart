import 'package:flutter/material.dart';
import '../data/tattoo_data.dart';
import '../models/tattoo.dart';
import '../widgets/tattoo_card.dart';
import 'detail_screen.dart';
import '../widgets/empty_board.dart';

class SavedScreen extends StatelessWidget {
  final Set<String> savedIds;
  final Future<void> Function(String id) onToggleSaved;

  const SavedScreen({
    super.key,
    required this.savedIds,
    required this.onToggleSaved,
  });

  List<Tattoo> get _savedTattoos =>
      kTattoos.where((t) => savedIds.contains(t.id)).toList();

  @override
  Widget build(BuildContext context) {
    final saved = _savedTattoos;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Board',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: false,
      ),
      body: saved.isEmpty
          ? const EmptyBoard()
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.72,
              ),
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final tattoo = saved[index];
                return TattooCard(
                  tattoo: tattoo,
                  isSaved: true,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          tattoo: tattoo,
                          isSaved: true,
                          onToggleSaved: onToggleSaved,
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