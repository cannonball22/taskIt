import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_it/Data/Repositories/team.repo.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Team/team.model.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../presentation/utils/SnackBar/snackbar.helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    XFile? profileImage,
    required BuildContext context,
  }) async {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Invalid email address'), title: 'Invalid email');
      return false;
    }

    if (password.length < 6) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Password must be at least 6 characters long'),
          title: 'Invalid password');
      return false;
    }

    if (fullName.isEmpty) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Full name cannot be empty'),
          title: 'Invalid name');
      return false;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? pictureURL;

      if (profileImage != null) {
        final String userId = userCredential.user!.uid;
        final Reference storageRef = _storage
            .ref()
            .child('profile_images')
            .child('$userId/${profileImage.name}');
        final UploadTask uploadTask =
            storageRef.putFile(File(profileImage.path));
        final TaskSnapshot taskSnapshot = await uploadTask;
        pictureURL = await taskSnapshot.ref.getDownloadURL();
      }
      String teamId = IdGeneratingService.generate();
      await TeamRepo().createSingle(
          Team(
            id: teamId,
            teamOwnerId: userCredential.user!.uid,
            membersIds: [userCredential.user!.uid],
          ),
          itemId: teamId);
      await MemberRepo().createSingle(
        Member(
          id: userCredential.user!.uid,
          email: email,
          fullName: fullName,
          pictureURL: pictureURL,
          teamId: teamId,
        ),
        itemId: userCredential.user!.uid,
      );

      return true;
    } catch (e) {
      SnackbarHelper.showTemplated(context,
          content: Text('Error: ${e.toString()}'), title: 'Signup Error');
      return false;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarHelper.showTemplated(context,
            content: const Text('No user found for that email.'),
            title: "Invalid User");
      } else if (e.code == 'wrong-password') {
        SnackbarHelper.showTemplated(context,
            title: 'Wrong password.',
            content: const Text("Wrong password provided for that user."));
      }
      return null;
    } catch (e) {
      print('Sign in failed: $e');
      return null;
    }
  }

  Stream<User?> isUserLoggedIn() {
    return _auth.authStateChanges();
  }

  String getCurrentUserId() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
