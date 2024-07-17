//t2 Core Packages Imports
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_it/features/home/presentation/pages/bottom_navigation.screen.dart';

import '../../../../core/Services/Imaging/imaging.service.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/primary_button.dart';
import '../../../../presentation/widgets/tertiary_button.dart';
import '../../domain/repositories/AuthService.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class SignUpScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SignUpScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  final _formKey = GlobalKey<FormState>();

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    _formController = FormController();

    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --State
    //t2 --State
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION
  XFile? profileImage;

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 56,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 56.0),
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: double.infinity,
                      height: 138.84,
                    ),
                  ),
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'AvantGarde Bk BT',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.64,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          profileImage =
                              await ImagingService.captureSingleImages();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF1EAFE),
                          radius: 36,
                          child: profileImage == null
                              ? const Icon(
                                  Icons.person_outlined,
                                  size: 48,
                                  color: Color(0xff824AFD),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(profileImage!.path),
                                    fit: BoxFit.cover,
                                    width: 72,
                                    height: 72,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Upload avatar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  controller: _formController.controller("name"),
                  hintText: "Full name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: _formController.controller("email"),
                  hintText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: _formController.controller("password"),
                  hintText: "Password",
                  isObscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: 'Join us now!',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await AuthService()
                            .signUpWithEmailAndPassword(
                                email: _formController
                                    .controller("email")
                                    .text
                                    .trim(),
                                password:
                                    _formController.controller("password").text,
                                fullName:
                                    _formController.controller("name").text,
                                profileImage: profileImage,
                                context: context);
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const BottomNavigationScreen(
                                firstTime: true,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TertiaryButton(
                    title: 'I already have an account',
                    onPressed: () {
                      Navigator.pushNamed(context, "/signInScreen");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    _formController.dispose();
    //!SECTION
    super.dispose();
  }
}
