//
//  pb_text_field
//  password_manager
//
//  Created by Ngonidzashe Mangudya on 22/8/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../configs/colors.dart';

class PbTextField extends StatelessWidget {
  const PbTextField({
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;

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
            style: TextStyle(
              color: PbColors.black,
              fontWeight: FontWeight.w400,
              fontSize: sy(9),
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: PbColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: sy(9),
              ),
              border: InputBorder.none,
            ),
            keyboardType: keyboardType,
            readOnly: readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
          ),
        );
      },
    );
  }
}
