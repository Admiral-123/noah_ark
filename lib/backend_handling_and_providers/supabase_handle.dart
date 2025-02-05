import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHandle extends ChangeNotifier {
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

    notifyListeners();
  }

  Future<dynamic> writeUserName(String username) async {
    try {
      await Supabase.instance.client
          .from('profile')
          .insert({"uid": await currentUser(), "user_name": username});
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<dynamic> updatePfp(File? img, String path, String bucket) async {
    try {
      await Supabase.instance.client.storage.from(bucket).upload(path, img!);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<dynamic> currentUser() async {
    var currentuser = Supabase.instance.client.auth.currentUser!.id.toString();
    return currentuser;
  }

  Future<dynamic> postComments(String txt, String postId) async {
    await Supabase.instance.client.from('post_comments').insert({
      "post_id": postId,
      "user_id": await currentUser(),
      "comments": txt,
      "likes": []
    });
    notifyListeners();
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

  String postImage(File image, String path) {
    Supabase.instance.client.storage.from('pfp').upload(path, image);
    return path;
  }

  Future<dynamic> post(String? text, String? imagePath) async {
    await Supabase.instance.client.from('post').insert({
      "created_by": await currentUser(),
      "post_text": text,
      "post_image": imagePath,
      "post_upvotes": [],
      "post_downvotes": []
    });
    notifyListeners();
  }

  String? postImageUrl(String? path) {
    if (path == null) {
      return null;
    }
    return Supabase.instance.client.storage.from('pfp').getPublicUrl(path);
  }

  dynamic isPostLiked(String postId) async {
    final response = await Supabase.instance.client
        .from('post')
        .select('post_upvotes')
        .eq('id', postId)
        .single();

    if (response.isEmpty) {
      return false;
    }

    final postUpvotes = List<String>.from(response['post_upvotes'] ?? []);
    final currentuser = await currentUser();

    return postUpvotes.contains(currentuser);
  }
}
