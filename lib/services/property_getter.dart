import 'package:dandy/json_models/character.dart';

class PropertyGetter {
  late final Map<String, dynamic> _character;

  final Map<String, Map<String, dynamic>> _memory = {};

  PropertyGetter(Character character) {
    _character = character.toJson();
  }

  String getProperty(String key) {
    if (!key.contains('/')) {
      return _character[key].toString();
    }
    var split = key.split('/');
    Map<String, dynamic>? sub = _memory[split[0]];
    if (sub == null) {
      Map<String, dynamic> newSub = _character[split[0]].toJson();
      _memory[split[0]] = newSub;
      sub = newSub;
    }
    return sub[split[1]].toString();
  }
}