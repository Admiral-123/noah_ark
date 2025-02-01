import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/my_widgets/my_dialog.dart';
import 'package:noah_ark/my_widgets/my_txt_field.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // String getUser(String x) await {
  //   return context.read<SupabaseHandle>().postUserName(x);
  // }
  File? _img;

  Future<dynamic> pickImage(StateSetter updateState) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (_img != null) {
      setState(() {
        _img = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoahArk"),
      ),
      body: StreamBuilder(
          stream: context.read<SupabaseHandle>().postStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("no data"),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("no data"),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            }

            final data = snapshot.data!;

            return ListView.builder(
              itemBuilder: (context, index) {
                final doc = data[index];
                final postText = doc["post_text"];
                final postUser = doc["created_by"];
                final postUserPfp =
                    context.read<SupabaseHandle>().pfpUrlGiver(postUser);

                final userName =
                    context.read<SupabaseHandle>().postUserName(postUser);

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft,
                                colors: [
                                  Color(0xff33ccff),
                                  Color(0xff48BF91)
                                ])),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.network(postUserPfp),
                              ),
                              title: FutureBuilder(
                                  future: userName,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center();
                                    }
                                    if (snapshot.hasError) {
                                      return Center();
                                    }
                                    final username = snapshot.data!.toString();

                                    return Text("a/$username",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300));
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28, bottom: 10, top: 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    postText,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: data.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    scrollable: true,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "write what you feel",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 107, 105, 105)),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                        Container(
                            // height: 100,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     border: Border.all(color: Colors.black)),
                            child: _img != null
                                ? (Image.file(_img!))
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("click on image icon below"),
                                  ))
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            await pickImage(setState);
                          },
                          icon: Icon(
                            Icons.image,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
