import 'package:fal_hafez/models/fal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:just_audio/just_audio.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

class FalScreen extends StatefulWidget {
  static const String routeName = "PoemScreen";
  const FalScreen({super.key});

  @override
  State<FalScreen> createState() => _FalScreenState();
}

class _FalScreenState extends State<FalScreen> {
  late Fal _fal;
  final player = AudioPlayer();
  bool _isPlaying = false;
  Future<void> ad() async {
    String adId = await TapsellPlus.instance
        .requestInterstitialAd("63fcf8036f61060ce6dfc19c");

    await TapsellPlus.instance.showInterstitialAd(adId, onOpened: (map) {
      // Ad opened
    }, onError: (map) {
      // Error when showing ad
    });
  }

  bool _isInit = true;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _fal = ModalRoute.of(context)!.settings.arguments as Fal;
      await ad();

      var f = intl.NumberFormat("000");
      try {
        await player.setUrl(
            'https://fal-hafez.s3.ir-thr-at1.arvanstorage.ir/Hafez---${f.format(_fal.Id)}.mp3',
            preload: true);
      } catch (ex) {
        //sound not loaded
        //internet problem of notfound
      }
      setState(() {
        _isInit = false;
      });
    }

    super.didChangeDependencies();
  }

  Future togglePlay() async {
    if (_isPlaying) {
      setState(() {
        _isPlaying = !_isPlaying;
      });
      await player.pause();
    } else {
      setState(() {
        _isPlaying = !_isPlaying;
      });
      await player.play();
    }
  }

  Future stopAudio() async {
    player.stop();
    player.seek(Duration.zero);

    _isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Card(
            elevation: 1.5,
            margin: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 40,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "غزل شماره ${_fal.Id}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ..._fal.PoemParts.map((e) => e.isNotEmpty
                          ? Text(
                              e,
                              style: const TextStyle(
                                  fontFamily: "Nastaliq", fontSize: 34),
                            )
                          : Container()).toList(),
                      Divider(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        thickness: 1,
                      ),
                      Text(
                        _fal.Interpretation,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                child: _isInit
                    ? const CircularProgressIndicator()
                    : player.duration == null
                        ? const Text("برای شنیدن صوت، به اینترنت متصل شوید.")
                        : Row(children: [
                            IconButton(
                              onPressed: togglePlay,
                              icon: _isPlaying
                                  ? const Icon(Icons.pause_circle)
                                  : const Icon(Icons.play_circle),
                              iconSize: 50,
                            ),
                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: StreamBuilder(
                                    initialData: const Duration(seconds: 0),
                                    stream: player.positionStream,
                                    builder: (ctx, snapshot) {
                                      double currentDuration = snapshot.hasData
                                          ? (snapshot.data as Duration)
                                              .inMilliseconds
                                              .toDouble()
                                          : 0;
                                      if (currentDuration >=
                                          player.duration!.inMilliseconds) {
                                        stopAudio().then((value) {
                                          setState(() {});
                                        });
                                      }
                                      return Slider(
                                        value: currentDuration,
                                        min: 0,
                                        max: player.duration!.inMilliseconds
                                            .toDouble(),
                                        onChanged: (val) {
                                          setState(() {
                                            player.seek(Duration(
                                                milliseconds: val.toInt()));
                                          });
                                          // Jump to the 10 second position
                                        },
                                      );
                                    }),
                              ),
                            )
                          ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
