import 'dart:convert';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:dandy/components/loadingscreen.dart';
import 'package:dandy/json_models/character.dart';
import 'package:dandy/page.dart';
import 'package:dandy/pages/charview.dart';
import 'package:dandy/pages/newchar.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharacterSelectionPage extends BasePage {
  CharacterSelectionPage({super.key});

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  Database? _database;
  late Future<bool> _initializer = initialize();

  List<Character> _characters = [];

  Future<bool> initialize() async {
    // databaseFactory.deleteDatabase(join(await getDatabasesPath(), "dandy.db")); // TODO: REMOVE THIS
    _database = await getDb();
    List<Map<String, dynamic>> rows = await _database!.query("characters");
    _characters = List.generate(rows.length, (i) {
      Character char = Character.fromJson(jsonDecode(rows[i]["json"]));
      char.dbId = rows[i]["id"];
      return char;
    });
    return true;
  }

  void refresh() {
    _initializer = initialize();
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
              characterSelector(context),
              // 'new character' button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      bool? changed = await Navigator.push(context,
                        MaterialPageRoute<bool>(builder: (context) => NewCharacterPage(_database!)));
                      if (changed == true) {
                        setState(refresh);
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

  Widget characterSelector(BuildContext context) {
    return Column(
      children: _characters.isNotEmpty
        ? _characters.map((char) => ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: char.imageBase64.isEmpty
              ? const Icon(Icons.person, size: 56)
              : Image.memory(base64Decode(char.imageBase64)),
          ),
          minLeadingWidth: 64,
          title: Text(char.name),
          subtitle: Text("Level ${char.person?.level ?? "LEVEL"} ${char.person?.race ?? "RACE"} ${char.person?.classs ?? "CLASS"}"),
          onTap: () {
            // TODO: refresh if something changed
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => CharacterViewPage(char)));
          },
          trailing: PopupMenuButton(
            child: const Icon(Icons.more_vert),
            onSelected: (selected) {
              if (selected == "delete") {
                deleteCharacter(char, context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [Icon(Icons.delete_forever), Text("Delete")],
                ),
              ),
            ],
          ),
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
          "CREATE TABLE characters(id INTEGER PRIMARY KEY, json TEXT)");
      }
    );
  }

  Future<void> deleteCharacter(Character char, BuildContext context) async {
    if (await confirm(
      context,
      title: const Text("Are you sure?"),
      content: Text("Are you sure you want to delete ${char.name}?"),
    )) {
      await _database!.delete("characters", where: "id = ?", whereArgs: [char.dbId]);
      setState(refresh);
    }
  }
}
