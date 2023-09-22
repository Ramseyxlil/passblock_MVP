//
//  pb_dropdown_button
//  password_manager
//
//  Created by Ngonidzashe Mangudya on 22/8/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../configs/colors.dart';

class HkDropdownButton<T> extends StatelessWidget {
  const HkDropdownButton({
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    super.key,
  });

  final T? value;
  final List<T> items;
  final String label;
  final String hint;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: PbColors.black,
                fontWeight: FontWeight.w400,
                fontSize: sy(10),
              ),
            ),
            SizedBox(
              height: sy(5),
            ),
            Container(
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(3),
              ),
              decoration: const BoxDecoration(
                color: PbColors.white,
              ),
              child: DropdownButtonFormField<T>(
                isExpanded: true,
                value: value,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: PbColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(9),
                  ),
                  border: InputBorder.none,
                ),
                items: items.map((T e) {
                  return DropdownMenuItem<T>(
                    value: e,
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        color: PbColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: sy(9),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                selectedItemBuilder: (BuildContext context) {
                  return items.map<Widget>((T item) {
                    return Text(
                      item.toString(),
                      style: TextStyle(
                        color: PbColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: sy(9),
                      ),
                    );
                  }).toList();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator,
              ),
            ),
          ],
        );
      },
    );
  }
}
