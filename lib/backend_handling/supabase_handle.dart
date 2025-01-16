import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHandle extends ChangeNotifier {
  // Future<dynamic> createUserWithPhone(String num, String password) async { // depreciated
  //   try {
  //     await Supabase.instance.client.auth
  //         .signUp(phone: num, password: password);
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  // }

  // Future<void> verifyPhone(String otp, String num) async {
  //   await Supabase.instance.client.auth
  //       .verifyOTP(type: OtpType.signup, token: otp, phone: num);

  //   notifyListeners();
  // }

  Future<dynamic> createUseWithEmail(String email, String password) async {
    await Supabase.instance.client.auth
        .signUp(email: email, password: password);

    notifyListeners();
  }
  // new page, verify email then click on a button to proceed to home page

  Future<dynamic> loginWithEmail(String email, String password) async {
    await Supabase.instance.client.auth
        .signInWithPassword(email: email, password: password);
    notifyListeners();
  }

  // Future<dynamic> signUpWithDiscord() async {
  //   await Supabase.instance.client.auth.signUp();
  // }

  Future<dynamic> loginWithDiscord() async {
    await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.discord,
        redirectTo: 'noahark.scheme://noahark-host',
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication);
  }
}
