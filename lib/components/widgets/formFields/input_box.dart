import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';

class InputBox extends StatefulWidget {
  final String hint, helper, label;
  final TextDirection willingDir;
  final IconData? icon;
  final TextFieldType type;
  InputBox(
      {this.hint = "",
      this.helper = "",
      this.label = "",
      this.type = TextFieldType.password,
      this.icon,
      this.willingDir = TextDirection.ltr});

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscureText = true;
  bool hasFocus = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _focused(bool hasFucus) {
    setState(() {
      this.hasFocus = hasFucus;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget iconContainer = Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        child: widget.icon != null
            ? Icon(widget.icon, size: 16)
            : (_obscureText
                ? Icon(SodaIcons.visibility, size: 21)
                : Icon(SodaIcons.visibility_off, size: 21)));
    Widget? prefix = widget.type == TextFieldType.password
        ? InkWell(
            onTap: _toggle,
            child: iconContainer,
            splashColor: DColors.grayBrown,
          )
        : widget.icon != null
            ? iconContainer
            : null;

    return Container(
        child: Directionality(
            textDirection: widget.willingDir,
            child: Focus(
                child: TextField(
                    textAlign: hasFocus ? TextAlign.left : TextAlign.right,

                    //IF PASSWORDFIELD
                    obscureText: (widget.type == TextFieldType.password)
                        ? _obscureText
                        : false,
                    enableSuggestions: !(widget.type == TextFieldType.password),
                    autocorrect: !(widget.type == TextFieldType.password),

                    //INSTANTS
                    style: const TextStyle(
                        color: DColors.blueGray,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      suffixIcon: prefix,
                      filled: true,
                      fillColor: DColors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: DColors.green, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: DColors.orange, width: 2),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.label,
                      helperText: widget.helper,
                      hintStyle: const TextStyle(
                          color: DColors.blueGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 0.8),
                      contentPadding: const EdgeInsets.all(15),
                    )),
                onFocusChange: _focused)));
  }
}
