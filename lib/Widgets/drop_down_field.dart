
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/styles.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/court_hall_model.dart';
import 'package:hck_case_management/Models/judge_model.dart';


class DropDownFiled<T> extends StatelessWidget {
  final T dropdownValue;
  final Function onChanged;
  final List<T> dropDownArray;
  final String label;
  final String hintText;
  final Color color;
  final bool isEnabled;
  final String from;
  final double size;

  const DropDownFiled({Key key, this.dropdownValue, this.onChanged, this.dropDownArray, this.label, this.hintText, this.color = Colors.white, this.size = 12, this.from, this.isEnabled = true}) : super(key: key);



  getValue(T value){

    switch(from){
      case "case_type":
        Case_types r = value as Case_types;
        return r.typeName;
      case "bench":
        BenchModel m = value as BenchModel;
        return m.bench;
      case "searchby" :
        return value;
      case "judge":
        Judge_name j = value as Judge_name;
        return j.judgeName;
      case "court":
        CourtHallModel ch = value as CourtHallModel;
        return ch.name;

      default:
        String val = value as String;
        return val;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size,),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(label, style: Style.labelTextStyle,),
            ),
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 12),
              child: DropdownButton<T>(

                value: dropdownValue,
                style: TextStyle(fontSize: 16, color: Colors.black87),
                isDense: true,
                underline: SizedBox.shrink(),
                hint: Text(hintText != null ? hintText : "Choose " + label),
                isExpanded: true,
                onChanged: !isEnabled ? null :  (T newValue) {onChanged(newValue);},
                items: dropDownArray.map((T value) {
                  String val;
                  val = getValue(value);
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(val),
                  );
                }).toList(),
              ),
            )
          ],
        ),

      ],
    );
  }
}
