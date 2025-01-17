import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling/supabase_handle.dart';
import 'package:noah_ark/home.dart';
import 'package:noah_ark/log_sign/login.dart';
import 'package:noah_ark/log_sign/user_name_pfp.dart';
import 'package:provider/provider.dart';

class EmailVerify extends StatefulWidget {
  final String email;
  final String password;
  const EmailVerify({super.key, required this.email, required this.password});

  @override
  State<EmailVerify> createState() => _EmailVerifyPage();
}

class _EmailVerifyPage extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "click the link sent to",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.email,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("and click on the button below",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await context
                          .read<SupabaseHandle>()
                          .loginWithEmail(widget.email, widget.password);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserNamePfp()));
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Proceed")),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "if you didnt received email in 2 minutes\nyou might be already registered try",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    ),

                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.pushReplacement(context,
                    //           MaterialPageRoute(builder: (context) => Login()));
                    //     },
                    //     child: Text(
                    //       "Login",
                    //       style: TextStyle(
                    //           color: const Color.fromARGB(255, 75, 174, 255)),
                    //     ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
