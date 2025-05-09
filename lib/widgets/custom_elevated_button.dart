import 'package:flutter/material.dart';
import 'package:campus_connects/constants/utils/size_utils.dart';
import 'package:campus_connects/widgets/base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onTap,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    FocusNode? focusNode,
    required super.text,
    this.crossAlignment,
    this.mainAlignment,
    this.extraSpace,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final crossAlignment;

  final mainAlignment;

  final extraSpace;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: Container(
              height: height ?? getVerticalSize(55),
              width: width ?? double.maxFinite,
              margin: margin,
              decoration: decoration,
              child: ElevatedButton(
                focusNode: focusNode,
                style: buttonStyle,
                onPressed: isDisabled ?? false ? null : onTap ?? () {},
                child: Row(
                  mainAxisAlignment: mainAlignment ?? MainAxisAlignment.center,
                  crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.center,
                  children: [
                    extraSpace ?? const SizedBox.shrink(),
                    leftIcon ?? const SizedBox.shrink(),
                    Text(
                      text,
                      style: buttonTextStyle ?? Theme.of(context).textTheme.titleSmall,
                    ),
                    rightIcon ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          )
        : Container(
            height: height ?? getVerticalSize(55),
            width: width ?? double.maxFinite,
            margin: margin,
            decoration: decoration,
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: isDisabled ?? false ? null : onTap ?? () {},
              child: Row(
                mainAxisAlignment: mainAlignment ?? MainAxisAlignment.center,
                crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.center,
                children: [
                  extraSpace ?? const SizedBox.shrink(),
                  leftIcon ?? const SizedBox.shrink(),
                  extraSpace ?? const SizedBox.shrink(),
                  Text(
                    text,
                    style: buttonTextStyle ?? Theme.of(context).textTheme.titleSmall!,
                  ),
                  extraSpace ?? const SizedBox.shrink(),
                  rightIcon ?? const SizedBox.shrink(),
                ],
              ),
            ),
          );
  }
}
