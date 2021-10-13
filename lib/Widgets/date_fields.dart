import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/styles.dart';

class DateFields<T> extends StatelessWidget {
  final Function func;
  final  String label;
  final String hintText;
  final Color color;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const DateFields({Key key, this.func, this.label, this.hintText, this.color = Colors.white, this.initialDate, this.firstDate, this.lastDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(label, style: Style.labelTextStyle,),
            ),
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),


              child: DateTimeFormField(

                dateTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
                initialValue: initialDate,
                firstDate: firstDate,
                lastDate: lastDate,
                decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0),),borderSide: BorderSide.none,
                      ),
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: Icon(Icons.event_note),
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  onDateSelected:func,

              ),

            ),
          ],
        ),
      ],
    );
  }




}