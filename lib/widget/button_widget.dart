import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Widget label;
  final VoidCallback callback;
  final double? elevation;
  final double? height;
  final double? width;
  final double? radius;
  final double? padding;
  final Color? bgColor;
  final Color? borderColor;

  const AppButton(
    this.label,
    this.callback, {
    super.key,
    double this.elevation = 0.0,
    this.height,
    this.radius,
    this.padding,
    this.bgColor,
    this.borderColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(
            bgColor ?? AppColor.white,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              side:
                  BorderSide(color: borderColor ?? AppColor.black, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
            ),
          ),
        ),
        onPressed: callback,
        child: label,
      ),
    );
  }
}
