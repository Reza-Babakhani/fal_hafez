import 'dart:math';

import 'package:fal_hafez/screens/poem_list_screen.dart';
import 'package:fal_hafez/services/fal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/theme_manager.dart';
import 'fal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 85),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<ThemeNotifier>(
                builder: (context, theme, _) => IconButton(
                  onPressed: () {
                    if (theme.isDarkMode()) {
                      theme.setLightMode();
                    } else {
                      theme.setDarkMode();
                    }
                  },
                  icon: Icon(
                      theme.isDarkMode() ? Icons.light_mode : Icons.dark_mode),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var id = Random().nextInt(495) + 1;

                    FalService.GetById(id).then((fal) async {
                      await Navigator.of(context)
                          .pushNamed(FalScreen.routeName, arguments: fal);
                    });
                  },
                  child: const Text("نیت کردم")),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed(PoemListScreen.routeName);
                  },
                  child: const Text("لیست"))
            ],
          ),
        ),
      ),
    );
  }
}
