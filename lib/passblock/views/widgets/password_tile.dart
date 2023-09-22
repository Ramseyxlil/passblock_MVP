//
//  password_manager
//  password_tile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../../shared/utils/common.dart';
import '../../../shared/utils/copy_to_clipboard.dart';
import '../../../shared/utils/extensions.dart';
import '../../state/autofill_bloc.dart';
import '../../state/password_action_bloc.dart';
import '../pages/password.dart';

class PasswordTile extends StatelessWidget {
  const PasswordTile({
    required this.id,
    required this.title,
    required this.url,
    required this.email,
    required this.password,
    super.key,
  });

  final String id;
  final String title;
  final String url;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final actionBloc = PasswordActionBloc();
    final autofillBloc = BlocProvider.of<AutofillBloc>(context);
    return BlocProvider(
      create: (context) => actionBloc,
      child: BlocBuilder<AutofillBloc, AutofillState>(
        builder: (context, autofillSt) {
          return RelativeBuilder(
            builder: (context, height, width, sy, sx) {
              return GestureDetector(
                onTap: () async {
                  if (autofillSt is AutofillRequested) {
                    print('masuk sini naha euy');
                    await autofillBloc.autofillList(
                      PwDataset(
                        label: email,
                        username: email,
                        password: password,
                      ),
                    );
                  } else {
                    await context.goTo(
                      page: PasswordPage(id: id),
                    );
                  }
                },
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    bottom: sy(10),
                  ),
                  leading: Container(
                    height: sy(40),
                    width: sy(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        // image: AssetImage(asset),
                        image: NetworkImage(
                          getFaviconUrl(url),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      color: PbColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: sy(10),
                    ),
                  ),
                  subtitle: Text(
                    email,
                    style: TextStyle(
                      color: PbColors.textGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: sy(8),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      actionBloc.use(id);
                      copyToClipboard(password);
                    },
                    child: ImageIcon(
                      const AssetImage(
                        'assets/icons/copy.png',
                      ),
                      color: PbColors.black,
                      size: sy(15),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
