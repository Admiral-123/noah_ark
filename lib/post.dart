import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostPage();
}

class _PostPage extends State<Post> {
  TextEditingController txtPost = TextEditingController();

  File? _img;

  Future<dynamic> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _img = File(image.path);
      });
    }
  }

  void flushImage() {
    setState(() {
      _img = null;
    });
  }

  Future<dynamic> postImage() async {
    if (_img == null) {
      return;
    }

    final userName = await context.read<SupabaseHandle>().currentUser();
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final postTitle = txtPost.text.toString();

    final imgFileName = userName + postTitle + currentTime;

    final imagePath = 'images/$imgFileName';

    try {
      // ignore: use_build_context_synchronously
      final imageName =
          // ignore: use_build_context_synchronously
          context.read<SupabaseHandle>().postImage(_img!, imagePath);
      return imageName;
    } catch (e) {
      // ignore: use_build_context_synchronously
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    //  context.read<SupabaseHandle>().postImage(image, path)
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: txtPost,
            maxLines: 4,
            decoration: InputDecoration(
                hintText: "write what you feel",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: const Color.fromARGB(255, 107, 105, 105)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: 170, maxWidth: 200, minHeight: 20, minWidth: 50),
                child: _img != null
                    ? (Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.file(_img!),
                          GestureDetector(
                            onTap: () => flushImage(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(5.0)),
                                width: 55,
                                height: 20,
                                child: Center(
                                  child: Text(
                                    'remove',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () async {
                              await pickImage();
                            },
                            icon: Icon(
                              Icons.image,
                              color: Theme.of(context).primaryColor,
                            )))),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).primaryColor,
                )),
            ElevatedButton(
                onPressed: () async {
                  if (txtPost.toString() == '' && _img == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cant post empty stuff')));
                  }

                  if (_img != null) {
                    final path = await postImage();
                    print(path);
                    context
                        .read<SupabaseHandle>()
                        .post(txtPost.text.trim(), path);
                  }

                  if (_img == null) {
                    // ignore: use_build_context_synchronously
                    context
                        .read<SupabaseHandle>()
                        .post(txtPost.text.trim(), null);
                  }
                },
                child: Text('post'))
          ],
        )
      ],
    );
  }
}
