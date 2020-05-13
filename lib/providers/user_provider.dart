import 'dart:math';

import 'package:crud/data/dummy_users.dart';
import 'package:crud/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final Map<String, UserModel> _items = {...DUMMY_USERS};

  List<UserModel> get all => [..._items.values];

  int get count => _items.length;

  UserModel byIndex(int i) => _items.values.elementAt(i);

  void put(UserModel user) {
    if (user == null) {
      return;
    }

    //alterar
    if (user.id != null && _items.containsKey(user.id)) {
      _items.update(
        user.id.toString(),
        (value) => UserModel(id: user.id, name: user.name, email: user.email, avatarUrl: user.avatarUrl),
      );
    } else {
      // adicionar
      final id = Random().nextInt(1000).toString();
      _items.putIfAbsent(
        id,
        () => UserModel(id: id, name: user.name, email: user.email, avatarUrl: user.avatarUrl),
      );
    }

    notifyListeners();
  }

  void remove(UserModel user) {
    if (user != null && user.id != null) {
      _items.remove(user.id.toString());

      notifyListeners();
    }
  }
}
