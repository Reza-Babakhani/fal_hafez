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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Ok"),
                                      )
                                    ],
                                    content: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Text(
                                              "صوت به‌کار رفته در برنامه متعلق به استاد سیدعلی موسوی گرمارودی است"),
                                          Divider(),
                                          Text(
                                            "تهیه شده توسط محمدرضا باباخانی",
                                          ),
                                        ],
                                      ),
                                    ));
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.info_outline),
                        ),
                      ),
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
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(
                    side: BorderSide(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      "نیت کردم",
                      style: TextStyle(fontFamily: "Nastaliq", fontSize: 50),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context)
                          .pushNamed(PoemListScreen.routeName);
                    },
                    child: const Text("مشاهده همه اشعار"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
