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
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => SafeArea(
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 50),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: theme.isDarkMode()
                        ? const AssetImage("assets/img/bg-dark.jpg")
                        : const AssetImage("assets/img/bg-light.jpg"),
                    fit: BoxFit.fitHeight)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PreferredSize(
                  preferredSize: const Size(double.infinity, 85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        onPressed: () {
                          if (theme.isDarkMode()) {
                            theme.setLightMode();
                          } else {
                            theme.setDarkMode();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(theme.isDarkMode()
                              ? Icons.light_mode
                              : Icons.dark_mode),
                        ),
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
