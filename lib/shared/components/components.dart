import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool obsecure = false,
  VoidCallback? suffixIconPressed,
  VoidCallback? onTab,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: obsecure,
      onTap: onTab,
      enabled: isClickable,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixIconPressed,
                )
              : null,
          border: const OutlineInputBorder()),
    );

Widget buildTaskItem(Map models) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${models['time']}'),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${models['title']}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${models['date']}',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
