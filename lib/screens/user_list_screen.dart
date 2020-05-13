import 'package:crud/providers/user_provider.dart';
import 'package:crud/routes/app_routes.dart';
import 'package:crud/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.USER_FORM),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, index) {
          return UserTile(user: users.byIndex(index));
        },
      ),
    );
  }
}
