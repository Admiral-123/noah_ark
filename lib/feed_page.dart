import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/backend_handling_and_providers/theme_provider.dart';
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
    var isDarkMode = context.read<ThemeProvider>().isDark;
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
                final postId = doc["id"];
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
                                            color: Colors.black,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FutureBuilder(
                                            future: context
                                                .read<SupabaseHandle>()
                                                .isPostLiked(postId),
                                            builder: (context, snapshot) {
                                              Color col;

                                              if (snapshot.data == null) {
                                                col = Colors.grey;
                                              } else if (snapshot.data! ==
                                                  true) {
                                                col = Colors.green;
                                              } else {
                                                col = Colors.grey;
                                              }

                                              return IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<SupabaseHandle>()
                                                      .upvotePost(postId);
                                                },
                                                icon: Icon(
                                                  Icons.arrow_upward,
                                                  color: col,
                                                ),
                                              );
                                            }),
                                        FutureBuilder(
                                            future: context
                                                .read<SupabaseHandle>()
                                                .totalCount(postId),
                                            builder: (context, snapshot) {
                                              var count = snapshot.data ?? 0;
                                              return Text(
                                                count.toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              );
                                            }),
                                        Expanded(
                                          child: FutureBuilder(
                                              future: context
                                                  .read<SupabaseHandle>()
                                                  .isPostDisliked(postId),
                                              builder: (context, snapshot) {
                                                Color col;

                                                if (snapshot.data == null) {
                                                  col = Colors.grey;
                                                } else if (snapshot.data! ==
                                                    true) {
                                                  col = Colors.red;
                                                } else {
                                                  col = Colors.grey;
                                                }

                                                return IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<SupabaseHandle>()
                                                        .downvotePost(postId);
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_downward,
                                                    color: col,
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.comment)),
                                  ),
                                ],
                              ),
                            )
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
      endDrawer: Drawer(
          width: 270,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Dark Mode", style: TextStyle(fontSize: 18)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              context.read<ThemeProvider>().darkThemeToggle();
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: isDarkMode
                                    ? Colors.green
                                    : const Color.fromARGB(255, 221, 218, 218)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
