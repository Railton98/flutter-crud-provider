import 'dart:convert';

import 'package:crud/data/dummy_users.dart';
import 'package:crud/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  static const _baseUrl = 'https://cod3r-crud-flutter-provider.firebaseio.com/';

  Map<String, UserModel> _items = {...DUMMY_USERS};

  List<UserModel> get all => [..._items.values];

  int get count => _items.length;

  UserModel byIndex(int i) => _items.values.elementAt(i);

  Future<void> put(UserModel user) async {
    if (user == null) {
      return;
    }

    //alterar
    if (user.id != null && _items.containsKey(user.id)) {
      await http.patch(
        '$_baseUrl/users/${user.id}.json',
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );

      _items.update(
        user.id,
        (value) => UserModel(id: user.id, name: user.name, email: user.email, avatarUrl: user.avatarUrl),
      );
    } else {
      // adicionar
      final response = await http.post(
        '$_baseUrl/users.json',
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );

      final id = json.decode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => UserModel(id: id, name: user.name, email: user.email, avatarUrl: user.avatarUrl),
      );
    }

    notifyListeners();
  }

  Future<void> remove(UserModel user) async {
    if (user != null && user.id != null) {
      await http.delete('$_baseUrl/users/${user.id}.json');
      _items.remove(user.id.toString());

      notifyListeners();
    }
  }
}
