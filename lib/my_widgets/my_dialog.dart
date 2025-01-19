import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final String content;
  final bool isCircular;
  // final BuildContext context;

  const MyDialog({super.key, required this.content, required this.isCircular});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
          child: Container(
        width: 220,
        height: 125,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isCircular
                  ? const CircularProgressIndicator()
                  : Container(),
              Text(
                widget.content,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 14.0),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
