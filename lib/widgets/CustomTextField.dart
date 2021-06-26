import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomTextField extends StatelessWidget {

  CustomTextField({required this.labelName, required this.hintTextName,
    required this.onChangedFunction,
    this.errorText,
    this.limit,
    this.validateFunction,
    required this.textInputType, this.onPressed, this.icon, this.obscureTextTy= false});

  final String labelName;
  final String hintTextName;
  final String? errorText;
  final TextInputType textInputType;

  final ValueChanged  onChangedFunction;
  final FormFieldValidator<String>? validateFunction;
final int? limit;
  final Function()? onPressed;
  final IconData? icon;
  final bool obscureTextTy;

  @override
  Widget build(BuildContext context) {
    return  Column(
//              mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text(labelName, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w700, fontSize: 18),),),
        TextFormField(
          keyboardType: textInputType,
          // autofocus: true,
          decoration: InputDecoration(
            errorText: errorText,
            hintStyle: TextStyle(color: Colors.red, fontSize: 17),
            hintText: hintTextName,

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),

            ),
            //isDense: true,                      // Added this
            //  contentPadding: EdgeInsets.all(15),
            suffixIcon: IconButton(
              icon: Icon(icon),
              onPressed: onPressed,
            ),

          ),
          onChanged: onChangedFunction,
          obscureText: obscureTextTy,
          validator: validateFunction,
            inputFormatters: [
              LengthLimitingTextInputFormatter(limit),
            ]

        ),
      ],
    );
  }
}