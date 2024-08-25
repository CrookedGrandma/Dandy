import 'dart:convert';

import 'package:dandy/components/loadingscreen.dart';
import 'package:dandy/models/character.dart';
import 'package:dandy/page.dart';
import 'package:dandy/pages/newchar.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharacterSelectionPage extends BasePage {
  const CharacterSelectionPage({super.key});

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  Database? database;
  late Future<bool> _initializer;

  List<Character> characters = [];

  _CharacterSelectionPageState() {
    _initializer = initialize();
  }

  Future<bool> initialize() async {
    // databaseFactory.deleteDatabase(join(await getDatabasesPath(), "dandy.db")); // TODO: REMOVE THIS
    database = await getDb();
    List<Map<String, dynamic>> rows = await database!.query("characters");
    characters = List.generate(rows.length, (i) {
      Character char = Character.fromJson(jsonDecode(rows[i]["json"]));
      char.imageBase64 = rows[i]["image"];
      return char;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializer,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != true) {
          return basicScaffold(context, widget, body: const LoadingScreenInCenter());
        }

        return basicScaffold(context, widget, body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              characterSelector(),
              // 'new character' button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      bool? changed = await Navigator.push(context,
                        MaterialPageRoute<bool>(builder: (context) => NewCharacterPage(database!)));
                      if (changed == true) {
                        setState(() {
                          _initializer = initialize();
                        });
                      }
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text("New character"),
                  ),
                ],
              ),
            ],
          )
        ));
      },
    );
  }

  Widget characterSelector() {
    return Column(
      children: characters.isNotEmpty
        ? characters.map((char) => ListTile(
          leading: Image.memory(base64Decode(char.imageBase64)),
          title: Text(char.name),
          subtitle: Text("Level ${char.person?.level ?? "LEVEL"} ${char.person?.race ?? "RACE"} ${char.person?.classs ?? "CLASS"}"),
        )).toList()
        : [
          const Text("No characters yet"),
        ],
    );
  }

  Future<Database> getDb() async {
    String path = join(await getDatabasesPath(), "dandy.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE characters(id INTEGER PRIMARY KEY, json TEXT, image VARCHAR(64000000))");
      }
    );
  }
}
