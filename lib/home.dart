import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat/services/auth.dart';
import 'package:we_chat/signIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () async {
                  AuthService().signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  });
                },
                child: Icon(Icons.exit_to_app))
          ],
          title: Container(
            child: Center(
              child: Text(
                'We Chat ',
              ),
            ),
          )),
      drawer: Drawer(),
    );
  }
}
