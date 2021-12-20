import 'package:flutter/material.dart';
import 'package:flutter_calculator/size_config.dart';

class CustomButton extends StatelessWidget {
  final Color bgColor;
  final Color color;
  final text;
  final onTap;
  final orientation;

  const CustomButton({
    required this.bgColor,
    required this.color,
    required this.text,
    required this.onTap,
    required this.orientation
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: EdgeInsets.all(2),
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return bgColor; 
          }),
        ),
        autofocus: true,
        child: Center(
          child: text == 'DEL'
              ? Icon(
                  Icons.backspace,
                  color: color,
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: orientation == Orientation.portrait
                        ? SizeConfig.safeBlockHorizontal * 7
                        : SizeConfig.safeBlockVertical * 5),
                  ),
                ),
        )
      );

  }
}
