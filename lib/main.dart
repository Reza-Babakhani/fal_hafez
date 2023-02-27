import 'package:fal_hafez/screens/fal_screen.dart';
import 'package:fal_hafez/screens/home_screen.dart';
import 'package:fal_hafez/screens/poem_list_screen.dart';
import 'package:fal_hafez/services/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ));

  const appId = "----";
  TapsellPlus.instance.initialize(appId);
  TapsellPlus.instance.setGDPRConsent(true);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: HomeScreen(),
        routes: {
          PoemListScreen.routeName: (context) => const PoemListScreen(),
          FalScreen.routeName: (context) => const FalScreen(),
        },
      );
    });
  }
}
