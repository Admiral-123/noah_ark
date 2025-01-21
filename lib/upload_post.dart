import 'package:flutter/material.dart';
import 'package:noah_ark/backend_handling/supabase_handle.dart';
import 'package:noah_ark/my_widgets/my_txt_field.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostPage();
}

class _UploadPostPage extends State<UploadPost> {
  TextEditingController uploadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UploadPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTxtField(
                  label: 'upload txt',
                  controller: uploadController,
                  obscure: false,
                  enable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<SupabaseHandle>()
                        .post(uploadController.text.trim());
                  },
                  child: Text('upload')),
            )
          ],
        ),
      ),
    );
  }
}
