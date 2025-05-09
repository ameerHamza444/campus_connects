import 'package:flutter/material.dart';
import 'package:campus_connects/widgets/commonModel/selection_popup_model.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
        this.alignment,
        this.width,
        this.focusNode,
        this.icon,
        this.autofocus = true,
        this.textStyle,
        this.items,
        this.hintText,
        this.hintStyle,
        this.dropDownStyle,
        this.prefix,
        this.prefixConstraints,
        this.suffix,
        this.suffixConstraints,
        this.contentPadding,
        this.borderDecoration,
        this.fillColor,
        this.filled = true,
        this.validator,
        this.onChanged,
        this.value,
        this.boxDecorationContainer});

  final Alignment? alignment;

  final BoxDecoration? boxDecorationContainer;

  final double? width;

  final FocusNode? focusNode;

  final Widget? icon;

  final bool? autofocus;

  final TextStyle? textStyle;

  final List<SelectionPopupModel>? items;

  final String? hintText;

  final TextStyle? hintStyle;

  final TextStyle? dropDownStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<SelectionPopupModel>? validator;

  final Function(SelectionPopupModel)? onChanged;

  final SelectionPopupModel? value;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: dropDownWidget(context),
    )
        : dropDownWidget(context);
  }

  Widget dropDownWidget(BuildContext context) => Container(
    width: width ?? double.maxFinite,
    decoration: boxDecorationContainer ?? BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).iconTheme.color!.withOpacity(0.1),
          offset: const Offset(0, 2),
          spreadRadius: 1.5,
          blurRadius: 0.5,
        ),
      ],
    ),
    child: DropdownButtonFormField<SelectionPopupModel>(
      focusNode: focusNode ?? FocusNode(),
      icon: icon,
      isExpanded: true,
      value: value,
      autofocus: autofocus!,
      style: textStyle ?? Theme.of(context).textTheme.titleSmall!,
      dropdownColor: Theme.of(context).colorScheme.surface,
      items: items?.map((SelectionPopupModel item) {
        return DropdownMenuItem<SelectionPopupModel>(
          value: item,
          child: Text(
            item.title,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: dropDownStyle ?? Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w700
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? Theme.of(context).textTheme.titleSmall,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.only(left: 19, top: 19, bottom: 19),
        fillColor: fillColor ?? Theme.of(context).colorScheme.primary,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
      ),
      validator: validator,
      onChanged: (value) {
        onChanged!(value!);
      },
    ),
  );
}
