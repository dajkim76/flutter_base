import 'dart:async';

import 'settings_databse.dart';

class SettingString {
  final String _key;
  String _value;
  final String _defaultValue;

  SettingString(this._key, this._defaultValue);

  Future<String> getValue() async {
    if (_value != null) {
      return _value;
    }

    final value = await SettingsDatabase.instance.getValue(_key);
    if (value != null) {
      _value = value;
      return _value;
    }
    return _value = _defaultValue;
  }

  void setValue(String value) async {
    if (value == null) {
      value = "";
    }

    if (_value != value) {
      _value = value;
      SettingsDatabase.instance.setValue(_key, _value);
    }
  }
}

class SettingInt {
  final String _key;
  int _value;
  final int _defaultValue;

  SettingInt(this._key, this._defaultValue);

  Future<int> getValue() async {
    if (_value != null) {
      return _value;
    }

    final value = await SettingsDatabase.instance.getValue(_key);
    if (value != null) {
      _value = int.parse(value);
      return _value;
    }
    return _value = _defaultValue;
  }

  void setValue(int value) async {
    if (value == null) {
      value = 0;
    }

    if (_value != value) {
      _value = value;
      SettingsDatabase.instance.setValue(_key, _value.toString());
    }
  }
}

class SettingDouble {
  final String _key;
  double _value;
  final double _defaultValue;

  SettingDouble(this._key, this._defaultValue);

  Future<double> getValue() async {
    if (_value != null) {
      return _value;
    }

    final value = await SettingsDatabase.instance.getValue(_key);
    if (value != null) {
      _value = double.parse(value);
      return _value;
    }
    return _value = _defaultValue;
  }

  void setValue(double value) async {
    if (value == null) {
      value = 0.0;
    }

    if (_value != value) {
      _value = value;
      SettingsDatabase.instance.setValue(_key, _value.toString());
    }
  }
}

class SettingBoolean {
  final String _key;
  bool _value;
  final bool _defaultValue;

  SettingBoolean(this._key, this._defaultValue);

  Future<bool> getValue() async {
    if (_value != null) {
      return _value;
    }

    final value = await SettingsDatabase.instance.getValue(_key);
    if (value != null) {
      _value = value == "true";
      return _value;
    }
    return _value = _defaultValue;
  }

  void setValue(bool value) async {
    if (value == null) {
      value = false;
    }

    if (_value != value) {
      _value = value;
      SettingsDatabase.instance.setValue(_key, _value.toString());
    }
  }
}
