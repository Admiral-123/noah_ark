import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:noah_ark/backend_handling/supabase_handle.dart';
import 'package:noah_ark/log_sign/email_verify.dart';
import 'package:noah_ark/log_sign/login.dart';
import 'package:noah_ark/my_widgets/my_txt_field.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInPage();
}

class _SignInPage extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController phonePasswordController = TextEditingController();
  // TextEditingController phoneOTPController = TextEditingController();
  // bool otpEnable = false;
  //bool phoneEnable = true;
  // void toggleEnablers() {
  //   setState(() {
  //     otpEnable = !otpEnable;
  //     //phoneEnable = !phoneEnable;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => SignInWitEmail()));
              //     },
              //     child: Text("Email")),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(Buttons.Google, onPressed: () {
                    print("to be implemented");
                  })),

              // Padding(   // because of twillio free trial limitaion we're depreciating phone numbers
              //     padding: EdgeInsets.all(8.0),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         showModalBottomSheet(
              //           elevation: 70.0,
              //           context: context,
              //           builder: (context) {
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 children: [
              //                   MyTxtField(
              //                     label: "phone number",
              //                     controller: phoneController,
              //                     obscure: false,
              //                     enable: true,
              //                   ),
              //                   MyTxtField(
              //                     label: "password",
              //                     controller: phonePasswordController,
              //                     obscure: false,
              //                     enable: true,
              //                   ),
              //                   MyTxtField(
              //                     label: "OTP",
              //                     controller: phoneOTPController,
              //                     obscure: true,
              //                     enable: true,
              //                   ),
              //                   ElevatedButton(
              //                       onPressed: () {
              //                         context
              //                             .read<SupabaseHandle>()
              //                             .createUserWithPhone(
              //                                 phoneController.text.trim(),
              //                                 phonePasswordController.text);
              //                       },
              //                       child: Text("Send OTP")),
              //                   ElevatedButton(
              //                       onPressed: () {
              //                         context
              //                             .read<SupabaseHandle>()
              //                             .verifyPhone(
              //                                 phoneOTPController.text.trim(),
              //                                 phoneController.text.trim());
              //                       },
              //                       child: Text("verify")),
              //                 ],
              //               ),
              //             );
              //           },
              //         );
              //       },
              //       // style: ElevatedButton.styleFrom(
              //       //   backgroundColor: Theme.of(context).primaryColor,
              //       //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //       // ),
              //       child: Text(
              //         "Register with Phone Number",
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     )),

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
                      child: TextField(
                        obscureText: true,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            label: Text("Confirm Password"),
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
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              try {
                                await context
                                    .read<SupabaseHandle>()
                                    .createUseWithEmail(
                                      emailController.text.trim(),
                                      passwordController.text,
                                    );

                                Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailVerify(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text)));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                                return;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("password doesnt match")));
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already a user ?",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                "Login",
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
      ),
    );
  }
}
