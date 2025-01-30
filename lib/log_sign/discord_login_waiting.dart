import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/home.dart';
import 'package:noah_ark/log_sign/user_name_pfp.dart';
import 'package:provider/provider.dart';

class DiscordLoginWaiting extends StatefulWidget {
  const DiscordLoginWaiting({super.key});

  @override
  State<DiscordLoginWaiting> createState() => _DiscordLoginWaitingPage();
}

class _DiscordLoginWaitingPage extends State<DiscordLoginWaiting> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (Timer x) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: context.read<SupabaseHandle>().currentUser().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final x = snapshot.data!;

              return StreamBuilder(
                  stream:
                      context.read<SupabaseHandle>().postUserName(x).asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const UserNamePfp();
                    } else {
                      return const Home();
                    }
                  });
            }));
  }
}
