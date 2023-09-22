//
//  password_manager
//  pb_button
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../configs/colors.dart';

class PbButton extends StatefulWidget {
  const PbButton({
    required this.text,
    this.txtColor = PbColors.white,
    this.btnColor = PbColors.black,
    this.disabledBtnColor = PbColors.grey,
    this.onTap,
    this.isDisabled = false,
    super.key,
  });

  final String text;
  final Color txtColor;
  final Color btnColor;
  final Color disabledBtnColor;
  final VoidCallback? onTap;
  final bool isDisabled;

  @override
  State<PbButton> createState() => _PbButtonState();
}

class _PbButtonState extends State<PbButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return GestureDetector(
          onTap: () {
            log('onTap: ${widget.onTap}');
            log('isDisabled: ${widget.isDisabled}');
            if (widget.onTap != null && !widget.isDisabled) {
              widget.onTap?.call();
              HapticFeedback.lightImpact();
            }
          },
          child: Listener(
            onPointerDown: (event) => setState(() {
              isPressed = true;
            }),
            onPointerUp: (event) => setState(() {
              isPressed = false;
            }),
            child: AnimatedContainer(
              duration: 200.milliseconds,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(10),
              ),
              decoration: BoxDecoration(
                color: !widget.isDisabled
                    ? isPressed
                        ? widget.btnColor.withOpacity(0.7)
                        : widget.btnColor
                    : widget.disabledBtnColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.txtColor,
                  fontWeight: FontWeight.w500,
                  fontSize: sy(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
