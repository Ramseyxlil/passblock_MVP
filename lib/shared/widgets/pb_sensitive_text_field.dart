//
//  pb_sensitive_text_field
//  password_manager
//
//  Created by Ngonidzashe Mangudya on 22/8/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../configs/colors.dart';

class PbSensitiveTextField extends StatefulWidget {
  const PbSensitiveTextField({
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputType keyboardType;

  @override
  State<PbSensitiveTextField> createState() => _PbSensitiveTextFieldState();
}

class _PbSensitiveTextFieldState extends State<PbSensitiveTextField> {
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: sx(20),
            vertical: sy(3),
          ),
          decoration: BoxDecoration(
            color: PbColors.white,
            border: Border.all(
              color: PbColors.border.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: widget.controller,
            style: TextStyle(
              color: PbColors.black,
              fontWeight: FontWeight.w400,
              fontSize: sy(9),
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: PbColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: sy(9),
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: toggleObscureText,
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: PbColors.grey,
                ),
              ),
            ),
            obscureText: widget.readOnly || obscureText,
            keyboardType: widget.keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            readOnly: widget.readOnly,
          ),
        );
      },
    );
  }
}
