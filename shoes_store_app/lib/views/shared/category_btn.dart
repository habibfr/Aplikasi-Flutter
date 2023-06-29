import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.label});

  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => null,
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: buttonClr, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(12, buttonClr, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
