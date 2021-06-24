import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/helper/sharedpref.dart';
import 'package:we_chat/home.dart';
import 'package:we_chat/services/dataBase.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    return await auth.currentUser;
  }

  static Future signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final gogleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final credential =
        await FirebaseAuth.instance.signInWithCredential(gogleCredential);

    User userDetails = credential.user;
    if (credential != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);
// Map is a key value pairs
      Map<String, dynamic> userInfoMap = {
        'email': userDetails.email,
        'username': userDetails.email.replaceAll('@gmail.com', ''),
        'name': userDetails.displayName,
        'imgUrl': userDetails.photoURL,
      };

      // in database when it call a
      Database()
          .addUserDetailsToDatabase(userDetails.uid, userInfoMap)
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }
}
