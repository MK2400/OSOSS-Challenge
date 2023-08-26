import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final Color? textColor;
  final VoidCallback? onPressed;
  final String? title;
  final TextStyle? textStyle;

  const LinkButton({Key? key, this.textStyle,this.textColor, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
          child: Text(title??'',
            style: textStyle??Theme.of(context).textTheme.button!.apply(
              color: textColor,
              decoration: TextDecoration.underline
            ),
          )),
    );
  }
}
