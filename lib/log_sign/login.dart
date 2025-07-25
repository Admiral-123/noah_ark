import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/log_sign/discord_login_waiting.dart';
import 'package:noah_ark/home.dart';
import 'package:noah_ark/log_sign/sign_in.dart';
import 'package:noah_ark/my_widgets/my_dialog.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => LoginWitEmail()));
            //     },
            //     child: Text("Email")),
            Padding(
                padding: EdgeInsets.all(2.0),
                child: InkWell(
                  splashColor: Colors.amber,
                  highlightColor: Colors.amber,
                  onTap: () async {
                    await context.read<SupabaseHandle>().loginWithDiscord();
                    Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DiscordLoginWaiting()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2.0),
                      borderRadius: BorderRadius.circular(
                        4.5,
                      ),
                    ),
                    child: Image.asset(
                      'assets/discord.png',
                      fit: BoxFit.scaleDown,
                      scale: 1.3,
                    ),
                  ),
                )),

            Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 150,
                    color: Colors.black12,
                  ),
                  Text("  OR  "),
                  Container(
                    height: 1,
                    width: 150,
                    color: Colors.black12,
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: Text("Email"),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10.0),
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyDialog(
                                    content: "it'll take few seconds",
                                    isCircular: true);
                              },
                            );
                            await context.read<SupabaseHandle>().loginWithEmail(
                                emailController.text.trim(),
                                passwordController.text);

                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            showDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                builder: (context) {
                                  return MyDialog(
                                      content: e.toString(), isCircular: false);
                                });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "new to NoahArk ?",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
