import 'package:fal_hafez/models/fal.dart';
import 'package:fal_hafez/services/db.dart';

class FalService {
  static Future<List<Fal>> GetList() async {
    var db = await Db.getInstance();

    var fals = await db.query("Fals");
    return fals
        .map((e) => Fal(
            e["Id"] as int,
            e["Poem"] as String,
            e["Interpretation"] as String,
            e["Poem"].toString().split("\\r\\n").first))
        .toList();
  }

  static Future<Fal> GetById(int id) async {
    var db = await Db.getInstance();

    var fals = await db.query("Fals", where: "Id = $id");

    if (fals.isEmpty) {
      return Fal(0, "", "", "");
    } else {
      return Fal(
          fals[0]["Id"] as int,
          fals[0]["Poem"] as String,
          fals[0]["Interpretation"] as String,
          fals[0]["Poem"].toString().split("\\r\\n").first);
    }
  }
}
