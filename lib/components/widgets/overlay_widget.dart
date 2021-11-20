import 'package:flutter/material.dart';

class OverlayController extends ValueNotifier<bool> {
  OverlayController() : super(false);
  void show() {
    value = true;
  }

  void hide() {
    value = false;
  }
}

class OverlayBack extends StatefulWidget {
  final OverlayController controller;
  final Widget? child;

  OverlayBack({Key? key, this.child, required this.controller})
      : super(key: key);

  @override
  _OverlayBackState createState() => _OverlayBackState();
}

class _OverlayBackState extends State<OverlayBack> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value
        ? Material(
            color: Colors.transparent,
            elevation: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          )
        : SizedBox();
  }
}
