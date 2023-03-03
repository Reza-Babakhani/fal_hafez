import 'package:fal_hafez/screens/fal_screen.dart';
import 'package:fal_hafez/screens/home_screen.dart';
import 'package:fal_hafez/screens/poem_list_screen.dart';
import 'package:fal_hafez/services/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ));

  const appId =
      "mmsabppftckebnfkmopsdiihmelecnogodeoflmiibdmtktfqattljpcpncginhrnfeqor";
  TapsellPlus.instance.initialize(appId);
  TapsellPlus.instance.setGDPRConsent(true);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> ad() async {
    String adId = await TapsellPlus.instance.requestStandardBannerAd(
        "63fcf6d9b96efa3785450390", TapsellPlusBannerType.BANNER_320x50);

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
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        await ad();
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: const HomeScreen(),
        routes: {
          PoemListScreen.routeName: (context) => const PoemListScreen(),
          FalScreen.routeName: (context) => const FalScreen(),
        },
      );
    });
  }
}
