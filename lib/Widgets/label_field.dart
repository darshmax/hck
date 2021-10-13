import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/styles.dart';
import 'package:hck_case_management/Widgets/text_input_box.dart';

class LabelField extends StatelessWidget {
  final String label;
  final String hintText;
  final Color color;
  final double size;
  final TextEditingController mCtrl;
  final bool isEnabled;
  final maxLength;
  final int maxLines;
  final String keytype;



  const LabelField({Key key, this.label, this.hintText, this.color = Colors.white, this.size = 12, this.maxLines = 1, this.isEnabled = true, this.mCtrl, this.maxLength,this.keytype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType tp;
    if(keytype=="Number"){
      tp=TextInputType.number;
    }
    else{
      tp=TextInputType.text;
    }
    print(tp);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size,),
        label != null ? Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(label, style: Style.labelTextStyle,),
        ): SizedBox.shrink(),

          Container(color: isEnabled == false ? Colors.grey.shade100 : color, child: InputBox(hintText: hintText != null ? hintText : label != null ? "Enter " + label.replaceAll("Member", "") : "fill",maxLines: maxLines, isEnabled: isEnabled,mCtrl: mCtrl, maxLength: maxLength, tp: tp,))


      ],
    );
  }
}
