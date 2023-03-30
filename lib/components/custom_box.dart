import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';

class Custom_Box extends StatelessWidget {
  final Image photo;
  late bool visible;
  late Color background;
  final Function(bool) setActive;

  Custom_Box(
      {super.key,
      required this.photo,
      required this.visible,
      required this.setActive,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setActive(!visible),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5),
          borderRadius: BorderRadius.circular(10),
          color: visible ? background : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Visibility(
            child: photo,
            visible: visible,
          ),
        ),
      ),
    );
  }
}
