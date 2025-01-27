import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
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
                            gradient: RadialGradient(
                                radius: 5.0,
                                colors: [Colors.green, Colors.blue])),
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
                                    final username = snapshot.data;
                                    return Text(username!);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(postText),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final x = await context
                                      .read<SupabaseHandle>()
                                      .postUserName(postUser);

                                  print(x);
                                },
                                child: Text('data'))
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
    );
  }
}
