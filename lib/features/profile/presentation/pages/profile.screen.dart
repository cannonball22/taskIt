//t2 Core Packages Imports
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_it/Data/Model/Member/member.model.dart';
import 'package:task_it/Data/Repositories/user.repo.dart';

import '../../../../core/Services/Imaging/imaging.service.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../authentication/domain/repositories/AuthService.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class ProfileScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;

  //!SECTION
  //
  const ProfileScreen({
    Key? key,
    required this.member,
  }) : super(
    key: key,
  );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text("My profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.48,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFF1EAFE),
                  radius: 36,
                  child: (widget.member.pictureURL == null)
                      ? const Icon(
                    Icons.person_outlined,
                    color: Color(0xff824AFD),
                    size: 36,
                  )
                      : ClipOval(
                    child: Image.network(
                      widget.member.pictureURL!,
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    profileImage = await ImagingService.captureSingleImages();
                    String? pictureURL;

                    if (profileImage != null) {
                      final FirebaseStorage storage = FirebaseStorage.instance;
                      final Reference storageRef = storage
                          .ref()
                          .child('profile_images')
                          .child('${widget.member.id}/${profileImage!.name}');
                      final UploadTask uploadTask =
                      storageRef.putFile(File(profileImage!.path));
                      final TaskSnapshot taskSnapshot = await uploadTask;
                      pictureURL = await taskSnapshot.ref.getDownloadURL();
                    }

                    widget.member.pictureURL = pictureURL;

                    await MemberRepo()
                        .updateSingle(widget.member.id, widget.member);
                    setState(() {});
                  },
                  child: Text(
                    'Upload avatar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: 16,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      widget.member.pictureURL = null;
                      MemberRepo()
                          .updateSingle(widget.member.id, widget.member);
                      setState(() {});
                    },
                    child: const Text(
                      'Remove avatar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF234D),
                        fontSize: 16,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.16,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              isEnabled: false,
              hintText: widget.member.fullName,
            ),
            // TextFormField(
            //   enabled: false,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: const BorderSide(
            //         width: 2,
            //         color: Color(0xFFF2F2F2),
            //       ),
            //     ),
            //     filled: true,
            //     fillColor: const Color(0xFFFCFCFC),
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              isEnabled: false,
              hintText: widget.member.email,
            ),
            // TextFormField(
            //   enabled: false,
            //   decoration: InputDecoration(
            //     hintText: widget.member.email,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: const BorderSide(
            //         width: 2,
            //         color: Color(0xFFF2F2F2),
            //       ),
            //     ),
            //     filled: true,
            //     fillColor: const Color(0xFFFCFCFC),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 80, right: 80),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF244D),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFFF234D)),
            ),
          ),
          onPressed: () async {
            await AuthService().signOut(context);
            Navigator.pushReplacementNamed(context, "/signInScreen");
          },
          child: const Text(
            'Sign out',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
        ),
      ),
    );
    //!SECTION
  }
}
