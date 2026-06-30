import 'package:flutter/material.dart';
import 'package:lab7/ui/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:lab7/di/service_locator.dart';
import 'package:lab7/providers/note_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab7/auth/firebase_options.dart';

const clientId = 'YOUR_CLIENT_ID';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLocator(); // Set up our dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (context) => NoteProvider()..fetchNotes(), // Create and fetch initial data
    child: MaterialApp(
      title: 'Sqflite Note Saver',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const AuthGate(clientId: clientId),
    ),
  );
  }
}