import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:coronadetect/Model/Note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestNote2.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE Notes(id INTEGER PRIMARY KEY, title TEXT, gender TEXT, number TEXT)",);
        });
  }

  newClient(Client newClient) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Notes");
    int id = table.first["id"];
    var raw = await db.rawInsert("INSERT Into Notes (id,title,gender,number)"
        " VALUES (?,?,?)", [id, newClient.name, newClient.number]);
    return raw;
  }

  blockOrUnblock(Client client) async {
    final db = await database;
    Client blocked = Client(
        id: client.id, name: client.name, number: client.number);
    var res = await db.update(
        "Notes", blocked.toMap(), where: "id = ?", whereAr`gs: [client.id]);
    return res;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update(
        "Notes", newClient.toMap(), where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Notes", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    final List<Map<String, dynamic>> res = await db.query('Notes');
    List<Client> list = res.isNotEmpty ? res.map((c) => Client.fromMap(c))
        .toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Notes", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Notes");
  }
}
