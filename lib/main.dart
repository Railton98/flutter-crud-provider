import 'package:crud/providers/user_provider.dart';
import 'package:crud/routes/app_routes.dart';
import 'package:crud/screens/user_form.dart';
import 'package:crud/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Multi Providers
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crud Simples',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserListScreen(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
    // Simple Provider
    // return ChangeNotifierProvider(
    //   create: (ctx) => UserProvider(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Crud Simples',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //     home: UserListScreen(),
    //   ),
    // );
  }
}
