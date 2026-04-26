import 'package:shared_preferences/shared_preferences.dart';

class SavedService 
{
  static const _key = 'saved_tattoo_ids';

  static Future<Set<String>> loadSaved() async
  {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.toSet();
  }

  static Future<Set<String>> toggle(String id) async
  {
    final prefs = await SharedPreferences.getInstance();
    final current = (prefs.getStringList(_key) ?? []).toSet();
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    await prefs.setStringList(_key, current.toList());
    return current;
  }

  static Future<bool> isSaved(String id) async
  {
    final saved = await loadSaved();
    return saved.contains(id);
  }

}