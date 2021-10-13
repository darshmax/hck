import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {

  final String hintText;
  final TextEditingController mCtrl;
  final bool isPass;
  final bool isEnabled;
  final int maxLines;
  final maxLength;
  final TextInputType tp;
  const InputBox({Key key,  this.hintText,  this.mCtrl, this.isPass = false, this.maxLines = 1, this.isEnabled = true, this.maxLength, TextInputType keyboardType, this.tp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mCtrl,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: isPass,
      keyboardType: tp,
      style: TextStyle(fontSize: 16,),
      decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          // counter: SizedBox.shrink(),
          counterText: "",
          enabled: isEnabled,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12)
      ),
    );
  }
}
