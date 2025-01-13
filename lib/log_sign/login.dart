import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

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
                padding: EdgeInsets.all(8.0),
                child: SignInButton(Buttons.Google, onPressed: () {
                  print("to be implemented");
                })),

            Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("to be implemented");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    "Login with Phone Number",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )),

            // Padding(
            //   padding: const EdgeInsets.only(
            //     right: 325.0,
            //   ),
            //   child: Text(
            //     "Email",
            //     textAlign: TextAlign.left,
            //   ),
            // ),

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
                    child:
                        ElevatedButton(onPressed: () {}, child: Text("Login")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "new to NoahArk",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {},
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
