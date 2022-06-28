import 'package:flutter/material.dart';

class TextFormInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  // ignore: prefer_typing_uninitialized_variables
  final textInputType;
  const TextFormInputField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.textInputType,
      this.obscure = false})
      : super(key: key);

  @override
  State<TextFormInputField> createState() => _TextFormInputFieldState();
}

class _TextFormInputFieldState extends State<TextFormInputField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure == true ? visible : false,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        suffixIcon: widget.obscure == true
            ? GestureDetector(
                onTap: () {
                  setState(() => visible = !visible);
                },
                child: Icon(
                  visible == true ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: Colors.blueGrey.shade500,
                ))
            : null,
        hintText: widget.hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        border: formOutlineInputBorder(Colors.black),
        focusedBorder: formOutlineInputBorder(Colors.blue),
        enabledBorder: formOutlineInputBorder(Colors.black),
        disabledBorder: formOutlineInputBorder(Colors.grey),
        errorBorder: formOutlineInputBorder(Colors.red),
        focusedErrorBorder: formOutlineInputBorder(Colors.red),
      ),
    );
  }
}

formOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color.withOpacity(.5), width: 1),
    // borderRadius: const BorderRadius.all(Radius.circular(24)),
  );
}
