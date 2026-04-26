import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const InkerestingApp());
}

class InkerestingApp extends StatelessWidget {
  const InkerestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkeresting',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'serif',
      ),
      home: const RootScreen(),
    );
  }
}