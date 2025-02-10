import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyAccount"),
      ),
      // body: Center(
      //   child: TextButton(
      //       onPressed: () {
      //         context.read<ThemeProvider>().changeThemeToDard();
      //       },
      //       child: Text("dark mode")),
      // ),
    );
  }
}
