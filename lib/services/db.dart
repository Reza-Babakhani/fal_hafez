import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static const String _dbName = "HafezDb.db";

  static bool _isInitialized = false;

  static Future<String> _getDbPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return p.join(documentsDirectory.path, _dbName);
  }

  static Future _initializeDataBase() async {
    // Construct a file path to copy database to
    String path = await _getDbPath();

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(p.join('assets', 'db', _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
    }

    _isInitialized = true;
  }

  static Database? _dbInstance;
  static Future<Database> getInstance() async {
    if (!_isInitialized) {
      await _initializeDataBase();
    }

    if (_dbInstance == null) {
      String path = await _getDbPath();
      _dbInstance = await openDatabase(path);
    }

    return _dbInstance!;
  }
}
