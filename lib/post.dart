import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostPage();
}

class _PostPage extends State<Post> {
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
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
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        )
      ],
    );
  }
}
