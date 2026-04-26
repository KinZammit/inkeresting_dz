import 'package:flutter/material.dart';
import '../services/saved_service.dart';
import 'home_screen.dart';
import 'saved_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  Set<String> _savedIds = {};

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final ids = await SavedService.loadSaved();
    setState(() => _savedIds = ids);
  }

  Future<void> _onToggleSaved(String id) async {
    final updated = await SavedService.toggle(id);
    setState(() => _savedIds = updated);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(savedIds: _savedIds, onToggleSaved: _onToggleSaved),
      SavedScreen(savedIds: _savedIds, onToggleSaved: _onToggleSaved),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_rounded),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}