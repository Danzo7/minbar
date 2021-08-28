import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minbar_fl/static/colors.dart';

class InputBox extends StatefulWidget {
  final String hint, helper, label, type;

  InputBox(
      {this.hint = "",
      this.helper = "",
      this.label = "",
      this.type = "Default"});

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    void _toggle() {
      setState(() {
        print(_obscureText);
        print("ss");

        _obscureText = !_obscureText;
        print(_obscureText);
      });
    }

    return Container(
        child: TextField(
            obscureText: _obscureText,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(
                color: DColors.blueGray,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: DColors.blueGray,
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: DColors.orange, width: 2),
              ),
              prefixIcon: GestureDetector(
                  onTap: _toggle,
                  child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      child: SvgPicture.asset(
                        'assets/icons/hide.svg',
                        color: DColors.blueGray,
                        fit: BoxFit.fitWidth,
                      ))),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: widget.label,
              labelStyle: TextStyle(
                  color: DColors.blueGray,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.8),
              hintText: widget.hint,
              helperText: widget.helper,
              hintStyle: const TextStyle(
                  color: DColors.blueGray,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
              contentPadding: const EdgeInsets.only(
                right: 30.0,
                left: 30.0,
                top: 30.0,
              ),
            )));
  }
}
