import 'package:flutter/material.dart';
import 'package:minbar_fl/static/colors.dart';

class InputBox extends StatelessWidget {
  final String hint, helper, label;
  InputBox({this.hint = "", this.helper = "", this.label = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
            style: const TextStyle(
                color: DColors.blueGray,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: DColors.orange,
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.orange, width: 2),
              ),
              labelText: label,
              labelStyle: TextStyle(
                  color: DColors.blueGray,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.8),
              hintText: hint,
              helperText: helper,
              hintStyle: const TextStyle(
                  color: DColors.blueGray,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700),
              contentPadding: const EdgeInsets.only(
                right: 30.0,
                left: 30.0,
                top: 30.0,
              ),
            )));
  }
}
