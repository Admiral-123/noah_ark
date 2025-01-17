import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noah_ark/backend_handling/supabase_handle.dart';
import 'package:noah_ark/my_widgets/my_txt_field.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserNamePfp extends StatefulWidget {
  const UserNamePfp({super.key});

  @override
  State<UserNamePfp> createState() => _UserNamePfpState();
}

class _UserNamePfpState extends State<UserNamePfp> {
  final TextEditingController userNameController = TextEditingController();
  File? _pfPImage;
  

  Future<dynamic> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pfPImage = File(image.path);
      });
    }
  }

  Future<dynamic> uploadImage() async {
    final String fileName = await context.read<SupabaseHandle>().currentUser();
    final path = 'pfp/$fileName';

    // ignore: use_build_context_synchronously
    context
        .read<SupabaseHandle>()
        .updatePfp(_pfPImage, path, 'pfp')
        .then((val) =>
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: val)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                foregroundColor: const Color.fromARGB(255, 224, 224, 224),
                child: Image.file(_pfPImage ?? )
              )),
          MyTxtField(
              label: "UserName",
              controller: userNameController,
              obscure: false,
              enable: true)
        ],
      )),
    );
  }
}
