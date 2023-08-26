import 'package:flutter/material.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';
import 'package:ososs/core/shared_widgets/link_button.dart';
import '../services/api/error_types.dart';

// ignore: must_be_immutable
class SimpleErrorWidget extends StatefulWidget {
  final ErrorType type;

  final Function? tryAgainFunction;
  final bool canClose;
  final Color? backgroundColor;
  final Color? textColor;
  final bool withBorder;
  final bool isForLogin;

  String? body;

  SimpleErrorWidget(
      {Key? key,
      required this.type,
      this.tryAgainFunction,
      this.body,
      this.canClose = true,
      this.backgroundColor,
      this.textColor,
      this.withBorder = true,
      this.isForLogin = false})
      : super(key: key);

  @override
  State<SimpleErrorWidget> createState() => _SimpleErrorWidgetState();
}

class _SimpleErrorWidgetState extends State<SimpleErrorWidget> {
  @override
  Widget build(BuildContext context) {
    widget.body ??= errorTypeMsg[widget.type];
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Material(
          color: widget.backgroundColor ?? AppColors.white,
          elevation: (widget.backgroundColor != null)
              ? (widget.backgroundColor == Colors.transparent)
                  ? 0
                  : 5
              : 5,
          child: Container(
            decoration: BoxDecoration(
                border: widget.withBorder
                    ? Border.all(color: AppColors.accentColor)
                    : null),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                if (widget.canClose)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (widget.canClose) Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.darkGrey.withOpacity(0.5),
                            )),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.body ?? 'Error, please try again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.textColor ?? AppColors.black,
                          fontSize: 18)),
                ),
                if (widget.tryAgainFunction != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    child: LinkButton(
                      title: 'Try Again',
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        widget.tryAgainFunction!();
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
