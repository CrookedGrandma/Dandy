import 'dart:convert';

import 'package:dandy/models/abilities.dart';
import 'package:dandy/models/character.dart';
import 'package:dandy/models/person.dart';
import 'package:dandy/page.dart';
import 'package:dandy/widgets.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NewCharacterPage extends BasePage {
  final Database database;

  const NewCharacterPage(this.database, {super.key});

  @override
  State<NewCharacterPage> createState() => _NewCharacterPageState();
}

class _NewCharacterPageState extends State<NewCharacterPage> {
  Map<String, List<NamedField>> fields = {
    "Basics": [
      NamedField<String>("Character name", "name"),
    ],
    "Person": [
      NamedField<int>("Level", "person/level"),
      NamedField<String>("Race", "person/race"),
      NamedField<String>("Class", "person/class"),
    ],
    "Abilities": [
      NamedField<int>("Strength", "abilities/strength"),
      NamedField<int>("Dexterity", "abilities/dexterity"),
      NamedField<int>("Constitution", "abilities/constitution"),
      NamedField<int>("Intelligence", "abilities/intelligence"),
      NamedField<int>("Wisdom", "abilities/wisdom"),
      NamedField<int>("Charisma", "abilities/charisma"),
    ]
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return basicScaffold(context, widget, body: Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ...inputFields(),
                ElevatedButton.icon(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    Character newChar = parseFields();
                    widget.database.insert("characters", { "json": jsonEncode(newChar) })
                      .then((result) {
                        Navigator.pop(context, true);
                      });
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Done!"),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  List<Widget> inputFields() {
    return fields.entries.map((entry) => Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(entry.key, style: const TextStyle(fontSize: 20)),
              ]
              + entry.value.map((field) => Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: textField(field),
                    ),
                  ),
                ],
              )).toList(),
            ),
          ),
        ),
      ],
    )).toList();
  }

  TextFormField textField(NamedField field) {
    return TextFormField(
      controller: field.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: field.name,
        label: Text(field.name),
      ),
      keyboardType: switch (field) {
        NamedField<String> _ => TextInputType.name,
        NamedField<int> _ => TextInputType.number,
        _ => throw "Non-supported input field type",
      },
      validator: (value) {
        if (value == null || value == "") {
          return "Must contain a value";
        }
        if (field is NamedField<int> && int.tryParse(value) == null) {
          return "Must contain an integer";
        }
        return null;
      },
    );
  }

  Character parseFields() {
    List<NamedField> allFields = fields.entries.selectMany((entry, i) => entry.value).toList();
    return Character(
      allFields.find("name").value(),
      "imageBase64",
      Person(
        allFields.find("person/level").value(),
        allFields.find("person/race").value(),
        allFields.find("person/class").value(),
      ),
      Abilities(
        allFields.find("abilities/strength").value(),
        allFields.find("abilities/dexterity").value(),
        allFields.find("abilities/constitution").value(),
        allFields.find("abilities/intelligence").value(),
        allFields.find("abilities/wisdom").value(),
        allFields.find("abilities/charisma").value(),
      )
    );
  }
}

extension NamedFieldListExtensions on List<NamedField> {
  NamedField find(String logicalName) {
    var found = where((f) => f.logicalName == logicalName);
    if (found.isEmpty) {
      throw "Logical name not found in any field";
    }
    if (found.length > 1) {
      throw "Multiple fields found with this logical name";
    }
    return found.first;
  }
}

class NamedField<T> {
  final String name;
  final String logicalName;
  final TextEditingController controller = TextEditingController();

  NamedField(this.name, this.logicalName);

  T value() {
    if (T == String) {
      return controller.text as T;
    }
    if (T == int) {
      return int.parse(controller.text) as T;
    }
    throw "Return type of field '$logicalName' not yet supported";
  }
}
