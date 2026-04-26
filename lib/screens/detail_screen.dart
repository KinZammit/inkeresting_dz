import 'package:flutter/material.dart';
import '../models/tattoo.dart';
import '../widgets/tag_chip.dart';

class DetailScreen extends StatefulWidget {
  final Tattoo tattoo;
  final bool isSaved;
  final Future<void> Function(String id) onToggleSaved;

  const DetailScreen({
    super.key,
    required this.tattoo,
    required this.isSaved,
    required this.onToggleSaved,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isSaved;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
  }

  Future<void> _handleToggle() async {
    setState(() => _isLoading = true);
    await widget.onToggleSaved(widget.tattoo.id);
    setState(() {
      _isSaved = !_isSaved;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tattoo = widget.tattoo;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Semantics(
                label: 'Tattoo image of ${tattoo.title}',
                image: true,
                child: Image.asset(
                  tattoo.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image_rounded, size: 60),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Semantics(
                        label: _isSaved
                            ? 'Remove ${tattoo.title} from board'
                            : 'Save ${tattoo.title} to board',
                        button: true,
                        child: IconButton(
                          tooltip: _isSaved ? 'Remove from saved' : 'Save',
                          icon: Icon(
                            _isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: _isSaved
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                          ),
                          onPressed: _handleToggle,
                        ),
                      ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tattoo.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.brush_rounded, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        tattoo.artist,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'About this piece',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          letterSpacing: 0.8,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tattoo.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Styles',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          letterSpacing: 0.8,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tattoo.tags
                        .map((tag) => TagChip(label: tag))
                        .toList(),
                  ),
                  const SizedBox(height: 32),
                  Semantics(
                    label: _isSaved
                        ? 'Remove ${tattoo.title} from board'
                        : 'Pin ${tattoo.title} to board',
                    button: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isLoading ? null : _handleToggle,
                        icon: Icon(
                          _isSaved
                              ? Icons.bookmark_remove_rounded
                              : Icons.bookmark_add_rounded,
                        ),
                        label: Text(
                          _isSaved ? 'Remove from Board' : 'Pin to Board',
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}