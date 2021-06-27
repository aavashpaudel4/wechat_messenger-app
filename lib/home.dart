import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat/helper/sharedpref.dart';
import 'package:we_chat/services/auth.dart';
import 'package:we_chat/signIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
  String myName, myProfilePic, myUserName, myEmail;
  TextEditingController searchtextEditingController = TextEditingController();

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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                        onTap: () {
                          isSearching = false;
                          searchtextEditingController.text = '';
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.arrow_back)),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'username'),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              isSearching = true;
                              setState(() {});
                            },
                            child: Icon(Icons.search))
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),

      // drawer: Drawer(),
    );
  }
}
