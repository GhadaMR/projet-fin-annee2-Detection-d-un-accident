import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ;
  final TextEditingController mycontroller ;
  final String? Function(String?)? validator;
  final bool password;
  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller, required this.validator,required this.password});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: password,
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
          hintText: hinttext, hintStyle:   TextStyle(color: Colors.grey[400]),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey)
          )
      ),
    );
  }
}
