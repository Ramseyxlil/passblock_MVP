//
//  password_manager
//  edit_profile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../providers.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/widgets/pb_button.dart';
import '../../../shared/widgets/pb_sensitive_text_field.dart';
import '../../../shared/widgets/pb_text_field.dart';
import '../../state/profile_bloc.dart';
import '../../state/profile_edit_bloc.dart';
import '../../utils/show_accounts_modal.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late ProfileBloc profileBloc;
  late ProfileEditBloc profileEditBloc;

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileEditBloc = ProfileEditBloc();
    profileBloc.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => profileBloc),
        BlocProvider(create: (context) => profileEditBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, profileSt) {
              if (profileSt is ProfileLoaded) {
                firstNameController.text = profileSt.res.firstName ?? '';
                lastNameController.text = profileSt.res.lastName ?? '';
                emailController.text = profileSt.res.email ?? '';
                passwordController.text = profileSt.res.password ?? '';
              }
            },
          ),
          BlocListener<ProfileEditBloc, ProfileEditState>(
            listener: (context, profileEditSt) {
              if (profileEditSt is ProfileEditLoaded) {
                Fluttertoast.showToast(
                  msg: 'Profile successfully updated',
                  backgroundColor: PbColors.green,
                );
              }
            },
          ),
        ],
        child: RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: sy(12),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        showIOSAccountsModal(context);
                      } else {
                        showAndroidAccountsModal(context);
                      }
                    },
                    icon: ImageIcon(
                      const AssetImage('assets/icons/switch.png'),
                      size: sy(15),
                    ),
                  ),
                ],
              ),
              body: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileSt) {
                  return Container(
                    width: context.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (profileSt is ProfileLoaded) ...[
                            Center(
                              child: Hero(
                                tag: 'profile-image',
                                child: Container(
                                  height: sy(70),
                                  width: sy(70),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: !selectedImage.isNull
                                          ? FileImage(selectedImage!)
                                          : !profileSt.res.photo.isNull
                                              ? NetworkImage(
                                                  '${profileSt.res.photo}',
                                                ) as ImageProvider
                                              : const AssetImage(
                                                  'assets/images/memoji.png',
                                                ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final XFile? img = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (!img.isNull) {
                                    setState(() {
                                      selectedImage = File(img!.path);
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sx(20),
                                    vertical: sy(5),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PbColors.border),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      color: PbColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: sy(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sy(20),
                            ),
                            Text(
                              'First Name',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(5),
                            ),
                            PbTextField(
                              controller: firstNameController,
                              hint: 'First Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Text(
                              'Last Name',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(5),
                            ),
                            PbTextField(
                              controller: lastNameController,
                              hint: 'Last Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(5),
                            ),
                            PbTextField(
                              controller: emailController,
                              hint: 'Email',
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(5),
                            ),
                            PbSensitiveTextField(
                              controller: passwordController,
                              hint: 'Password',
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            SizedBox(
                              height: sy(20),
                            ),
                            PbButton(
                              text: 'Update Profile',
                              onTap: () {
                                profileEditBloc.fetch(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  photo: selectedImage,
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
