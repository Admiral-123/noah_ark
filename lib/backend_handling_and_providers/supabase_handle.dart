import 'dart:ffi';
import 'dart:io';

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
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication);
  }

  Future<dynamic> writeUserName(String username) async {
    try {
      await Supabase.instance.client
          .from('profile')
          .insert({"uid": await currentUser(), "user_name": username});
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updatePfp(File? img, String path, String bucket) async {
    try {
      await Supabase.instance.client.storage.from(bucket).upload(path, img!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> currentUser() async {
    var currentuser = Supabase.instance.client.auth.currentUser!.id.toString();
    return currentuser;
  }

  Future<dynamic> postTxt(String txt) async {
    await Supabase.instance.client.from('post').insert({
      // "created_at": DateTime.now(),
      "created_by": await currentUser(),
      "post_text": txt,
      "post_image": null,
      "post_upvotes": [],
      "post_downvotes": [],
      // "post_comments": [],
    });
  }

  Future<dynamic> postComments(String txt, String postId) async {
    await Supabase.instance.client.from('post_comments').insert({
      "post_id": postId,
      "user_id": await currentUser(),
      "comments": txt,
      "likes": []
    });
  }

  SupabaseStreamFilterBuilder postStream() {
    return Supabase.instance.client.from('post').stream(primaryKey: ['id']);
  }

  String pfpUrlGiver(String userId) {
    return Supabase.instance.client.storage
        .from('pfp')
        .getPublicUrl('pfpUpload/$userId');
  }

  Future<String> postUserName(String userId) async {
    final x = await Supabase.instance.client
        .from('profile')
        .select('user_name')
        .eq('uid', userId)
        .single();

    return x['user_name'];
  }
}
