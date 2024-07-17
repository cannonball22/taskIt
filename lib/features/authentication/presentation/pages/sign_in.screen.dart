//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/primary_button.dart';
import '../../../../presentation/widgets/secondary_button.dart';
import '../../../home/presentation/pages/bottom_navigation.screen.dart';
import '../../domain/repositories/AuthService.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class SignInScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SignInScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  'Sign in & Get started 🚀',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'AvantGarde Bk BT',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.64,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Start managing your project and get to the finish line!',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                  isObscure: true,
                  controller: _formController.controller("password"),
                  hintText: "Password",
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
                  height: 112,
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: 'Sign in',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user = await AuthService()
                            .signInWithEmailAndPassword(
                                _formController.controller("email").text.trim(),
                                _formController.controller("password").text,
                                context);
                        if (user != null) {
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
                  child: SecondaryButton(
                    title: 'Sign Up',
                    onPressed: () {
                      Navigator.pushNamed(context, "/signUpScreen");
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
