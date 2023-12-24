
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          image TEXT,
          age INTEGER,
          phone TEXT
        )
      ''');
    });
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User> getUser(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }

    throw Exception("User not found");
  }

  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}

class User {
  int? id;
  String? image;
  int? age;
  String? phone;

  User({this.id, this.image, this.age, this.phone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'age': age,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      image: map['image'],
      age: map['age'],
      phone: map['phone'],
    );
  }
}



