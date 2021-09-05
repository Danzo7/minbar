import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';

typedef Void = void Function();

class Button extends StatelessWidget {
  final Void? onClick;
  final String value;
  final Color color;
  Button({this.onClick, this.value = "text", this.color = DColors.green});
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        //  width: MediaQuery.of(context).size.width * 0.85,
        child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(DColors.white),
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55.0),
                      side: BorderSide(color: color)))),
          child: Text(
            value,
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            onClick!();
          },
        ),
      ),
    );
  }
}
