import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/post.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  final currentPageState = PageStorageBucket();

  @override
  bool get wantKeepAlive =>
      true; // Whether the current instance should be kept alive.

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("NoahArk"),
      ),
      body: StreamBuilder(
          key: PageStorageKey('feedState'),
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
                //final postId = doc["id"];
                final String? postImagePath = doc["post_image"];
                final String? postImageUrl =
                    context.read<SupabaseHandle>().postImageUrl(postImagePath);
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
                                  Color(0xffffd700),
                                  Color(0xff98fb98)
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
                            postText != ''
                                ? Padding(
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
                                        )))
                                : SizedBox(
                                    height: 1,
                                  ),
                            postImagePath != null
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      // constraints: BoxConstraints(
                                      //     maxHeight: 380, maxWidth: 400),
                                      height: 380, width: 400,
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          border: Border.all(
                                              color: Colors.black87)),
                                      child: Image.network(
                                        postImageUrl!,
                                        loadingBuilder: // child is the file,
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            // if loadingProgress is completed(which means it doesnt exist now then return child)
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            // FutureBuilder(
                            //     future: context
                            //         .read<SupabaseHandle>()
                            //         .isPostLiked(postId),
                            //     builder: (context, snapshot) {
                            //       // final x = snapshot.data;

                            //       if (snapshot.data == null) {
                            //         return Container(
                            //           color: Colors.grey,
                            //         );
                            //       } else if (snapshot.data == true) {
                            //         return Container(
                            //           color: Colors.green,
                            //         );
                            //       } else {
                            //         return Container(
                            //           color: Colors.amber,
                            //         );
                            //       }
                            //     })
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
              builder: (context) {
                return Post();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
