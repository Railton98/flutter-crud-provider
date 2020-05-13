import 'package:crud/models/user_model.dart';
import 'package:crud/providers/user_provider.dart';
import 'package:crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orangeAccent),
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: user),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Provider.of<UserProvider>(context, listen: false).remove(user);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim')),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Não'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
