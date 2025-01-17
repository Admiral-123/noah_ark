import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noah_ark/backend_handling/supabase_handle.dart';
import 'package:noah_ark/home.dart';
import 'package:noah_ark/my_widgets/my_txt_field.dart';
import 'package:provider/provider.dart';

class UserNamePfp extends StatefulWidget {
  const UserNamePfp({super.key});

  @override
  State<UserNamePfp> createState() => _UserNamePfpState();
}

class _UserNamePfpState extends State<UserNamePfp> {
  final TextEditingController userNameController = TextEditingController();
  File? _pfPImage;
  // File defImage = =
  // final defImage = Icon(Icons.person);

  Future<dynamic> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pfPImage = File(image.path);
      });
    }
    // else{
    //   setState(() {
    //     _pfPImage = ;
    //   });
    // }
  }

  Future<dynamic> uploadImage() async {
    if (_pfPImage == null) {
      return;
    }
    final String fileName = await context.read<SupabaseHandle>().currentUser();
    final path = 'pfpUpload/$fileName';
    // print(path);

    try {
      await context
          .read<SupabaseHandle>()
          .updatePfp(_pfPImage, path, 'pfp')
          .then((val) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('successfully uploaded pfp'))));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
              child: _pfPImage != null
                  ? GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: CircleAvatar(
                          foregroundColor:
                              const Color.fromARGB(255, 224, 224, 224),
                          radius: 60.0,
                          child: Image.file(
                            _pfPImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: CircleAvatar(
                          foregroundColor:
                              const Color.fromARGB(255, 224, 224, 224),
                          radius: 60.0,
                          child: SizedBox(
                            child: Text(
                              'click',
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //       onPressed: () {
          //         try {
          //           uploadImage();
          //         } catch (e) {
          //           ScaffoldMessenger.of(context)
          //               .showSnackBar(SnackBar(content: Text(e.toString())));
          //         }
          //       },
          //       child: Text("upload Image")),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTxtField(
                label: "UserName",
                controller: userNameController,
                obscure: false,
                enable: true),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  if (userNameController.text != '') {
                    try {
                      uploadImage();
                      context
                          .read<SupabaseHandle>()
                          .writeUserName(userNameController.text.trim());

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: Text('upload')),
          )
        ],
      )),
    );
  }
}
