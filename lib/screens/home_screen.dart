import 'package:fal_hafez/screens/poem_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

import '../services/theme_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> ad() async {
    String adId = await TapsellPlus.instance
        .requestStandardBannerAd("--", TapsellPlusBannerType.BANNER_320x50);

    await TapsellPlus.instance.showStandardBannerAd(adId,
        TapsellPlusHorizontalGravity.BOTTOM, TapsellPlusVerticalGravity.CENTER,
        margin: const EdgeInsets.only(bottom: 1), onOpened: (map) {
      // Ad opened
    }, onError: (map) {
      // Error when showing ad
    });
  }

  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      //await ad();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

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
              ElevatedButton(onPressed: () {}, child: const Text("نیت کردم")),
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
