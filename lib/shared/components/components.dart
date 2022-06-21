import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backGround = Colors.blue,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: backGround),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  final ValueChanged? onSubmit,
  final ValueChanged? onChange,
  //required Function validate,
  required IconData prefix,
  required String validatorText,
  required String label,
  IconData? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
  VoidCallback? suffixIconPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText.toString();
        }
        return null;
      },
      obscureText: isPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixIconPressed,
                )
              : null,
          labelText: label,
          border: const OutlineInputBorder()),
    );
