import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTxtField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final bool enable;
  // final Float? txtSize;
  const MyTxtField(
      {super.key,
      required this.label,
      required this.controller,
      required this.obscure,
      required this.enable
      // this.txtSize
      });

  @override
  State<MyTxtField> createState() => _MyTxtFieldState();
}

class _MyTxtFieldState extends State<MyTxtField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscure,
        decoration: InputDecoration(
            label: Text(widget.label),
            enabled: widget.enable,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}
