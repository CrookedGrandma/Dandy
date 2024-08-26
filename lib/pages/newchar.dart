import 'dart:convert';
import 'dart:io';

import 'package:dandy/json_models/abilities.dart';
import 'package:dandy/json_models/character.dart';
import 'package:dandy/json_models/person.dart';
import 'package:dandy/models/named_field.dart';
import 'package:dandy/constants.dart';
import 'package:dandy/page.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class NewCharacterPage extends BasePage {
  final Database database;

  NewCharacterPage(this.database, {super.key}) : super(title: "New Character");

  @override
  State<NewCharacterPage> createState() => _NewCharacterPageState();
}

class _NewCharacterPageState extends State<NewCharacterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  Image? _profilePic;
  File? _profilePicFile;

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
                IconButton.outlined(
                  onPressed: selectImage,
                  icon: _profilePic ?? const Icon(Icons.person),
                  iconSize: 48,
                  style: const ButtonStyle(shape: WidgetStatePropertyAll(ContinuousRectangleBorder())),
                  padding: _profilePic == null ? null : const EdgeInsets.all(4),
                ),
                ...inputFields(),
                ElevatedButton.icon(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    Character newChar = parseFields();
                    widget.database.insert("characters", {
                      "json": jsonEncode(newChar)
                    })
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

  Future<void> selectImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null)
      return;
    setState(() {
      _profilePicFile = File(image.path);
      _profilePic = Image.file(
        _profilePicFile!,
        width: 52,
      );
    });
  }

  List<Widget> inputFields() {
    return Constants.fields.entries.map((entry) => Row(
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
    List<NamedField> allFields = Constants.fieldsFlat;
    return Character(
      allFields.find("name").value(),
      _profilePicFile != null
        ? base64Encode(_profilePicFile!.readAsBytesSync())
        : "",
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
