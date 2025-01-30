import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
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
    );
  }
}
