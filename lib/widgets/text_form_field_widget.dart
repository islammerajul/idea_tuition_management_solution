
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {Key? key,
      this.borderRadius = 5,
      this.validator,
      this.controller,
      this.suffixIcon,
      this.prefix,
      this.obscureText = false,
      this.headerName,
      this.keyboardType,
      this.style,
      this.onTap,
      this.sizedboxHeight,
      this.hintStyle,
      this.hint,
      this.onSaved,
      this.containerHeight,
      this.minLines,
      this.obscuringCharacter,
      this.maxLines,
      this.readOnly,
      this.initialValue,
      this.maxLength})
      : super(key: key);
  TextEditingController? controller;
  double? borderRadius, sizedboxHeight, containerHeight;
  dynamic validator, onTap;
  String? headerName, hint, obscuringCharacter, initialValue;
  Widget? suffixIcon, prefix;
  bool? obscureText, invisibleBorderSide = false, readOnly;
  TextInputType? keyboardType;
  TextStyle? style, hintStyle;
  int? maxLength, minLines, maxLines;
  Function? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(headerName!,
                  style: style
                      ?? CustomTextStyle.icontitle
                          .copyWith(color: CustomColors.White)
                      )),
          SizedBox(
            height: sizedboxHeight ?? 11,
          ),
          Container(
            height: containerHeight != null ? 56 : containerHeight,
            width: double.infinity,
            child: TextFormField(
              readOnly: readOnly ?? false,
              initialValue: initialValue,
              controller: controller,
              //onSaved: onSaved,
              validator: validator,
              obscureText: obscureText ?? false,
              obscuringCharacter: obscuringCharacter ?? '*',
              keyboardType: keyboardType,
              onTap: onTap,
              maxLength: maxLength,
              maxLines: maxLines ?? null,
              minLines: minLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: hintStyle ?? CustomTextStyle.icontitle
                    .copyWith(color: CustomColors.White),
                counterText: "",
                filled: true,
                fillColor: const Color(0xff492E51),
                border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(borderRadius!),
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
                prefix: prefix,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
