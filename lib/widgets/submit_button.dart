import 'package:campus_crush/core/app_text_styles.dart';
import 'package:campus_crush/core/color_scheme.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton(
      {required this.onTap,
      required this.lable,
      this.loading = false,
      this.colors = const [
        AppColors.primaryBlue,
        AppColors.primaryBlue,
        AppColors.lightPurple,
      ],
      this.height = 53.0,
      this.width = double.infinity,
      this.labelsize = 15.0,
      this.tapable = true,
      this.isAtBottom = false,
      this.labelColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.loaderColor = Colors.white,
      this.showShadow = false,
      this.borderRadius = 6,
      this.margin = 2,
      this.icon,
      this.iconAtFront = true,
      super.key});

  final void Function() onTap;
  final String lable;
  final bool loading;
  final List<Color> colors;
  final double height;
  final double width;
  final bool showShadow;
  final double labelsize;
  final bool tapable;
  final bool isAtBottom;
  final Color labelColor;
  final Color borderColor;
  final Color loaderColor;
  final double borderRadius;
  final double margin;
  final Widget? icon;
  final bool iconAtFront;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool tapped = false;
  double margin = 0.0;
  @override
  Widget build(BuildContext context) {
    if (widget.isAtBottom) {
      setState(() {
        margin = 15;
      });
    } else {
      margin = widget.margin;
    }
    return Container(
      margin: EdgeInsets.only(
        bottom: margin,
        top: widget.isAtBottom ? 2 : margin,
        left: margin,
        right: margin,
      ),
      child: InkWell(
        onHighlightChanged: (change) {
          setState(() {
            tapped = change;
          });
        },
        highlightColor: Colors.white,
        onTap: widget.tapable ? widget.onTap : null,
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          padding: tapped
              ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2)
              : null,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(double.parse('${widget.borderRadius}')),
          ),
          child: Container(
            height: tapped ? widget.height - 0 : widget.height,
            width: tapped ? widget.width - 0 : widget.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.colors,
                ),
                border: Border.all(color: widget.borderColor),
                borderRadius: BorderRadius.circular(
                    double.parse('${widget.borderRadius}')),
                boxShadow: widget.showShadow
                    ? const [
                        BoxShadow(
                          color: AppColors.primaryBlue,
                          blurRadius: 15,
                        )
                      ]
                    : null),
            child: widget.loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: widget.loaderColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.iconAtFront) widget.icon ?? Container(),
                      if (widget.iconAtFront && widget.icon != null)
                        const SizedBox(
                          width: 8,
                        ),
                      Text(
                        widget.lable,
                        style: AppTextStyles.monserrat600(
                            letterSpacing: 0.0,
                            color: widget.tapable
                                ? widget.labelColor
                                : AppColors.myGrey,
                            fontSize: double.parse('${widget.labelsize}')),
                      ),
                      if (!widget.iconAtFront && widget.icon != null)
                        const SizedBox(
                          width: 8,
                        ),
                      if (!widget.iconAtFront) widget.icon ?? Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
