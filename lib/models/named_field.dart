import 'package:flutter/material.dart';

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
