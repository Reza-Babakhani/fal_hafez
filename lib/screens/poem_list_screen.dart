import 'package:fal_hafez/models/fal.dart';
import 'package:fal_hafez/screens/fal_screen.dart';
import 'package:fal_hafez/services/fal_service.dart';
import 'package:flutter/material.dart';

class PoemListScreen extends StatefulWidget {
  static const String routeName = "PoemList";
  const PoemListScreen({super.key});

  @override
  State<PoemListScreen> createState() => _PoemListScreenState();
}

class _PoemListScreenState extends State<PoemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
        ),
        child: FutureBuilder(
          future: FalService.GetList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    prototypeItem: PoemListItem(snapshot.data!.first),
                    cacheExtent: 30,
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    addSemanticIndexes: true,
                    itemBuilder: (ctx, i) {
                      Fal fal = snapshot.data![i];
                      return PoemListItem(fal);
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}

class PoemListItem extends StatelessWidget {
  final Fal fal;
  const PoemListItem(
    this.fal, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 5, right: 12, left: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text("غزل شماره ${fal.Id}"),
        subtitle: Text(fal.Title),
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(FalScreen.routeName, arguments: fal);
        },
      ),
    );
  }
}
