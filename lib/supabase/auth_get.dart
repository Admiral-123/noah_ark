// import 'package:flutter/material.dart';
// import 'package:noah_ark/home.dart';
// import 'package:noah_ark/log_sign/login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthGet extends StatelessWidget {
//   const AuthGet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: Supabase.instance.client.auth.onAuthStateChange,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             var session = snapshot.hasData ? snapshot.data!.session : null;

//             if (session != null) {
//               return Home();
//             } else {
//               return Login();
//             }
//           }),
//     );
//   }
// }
