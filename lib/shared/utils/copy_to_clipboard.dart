//
//  password_manager
//  copy_to_clipboard
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
    msg: 'Copied',
  );
}
