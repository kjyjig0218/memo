import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  void init() async{

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () async{
                  GoogleSignInAccount? _account = await _googleSignIn.signIn();
                  print(_account?.email);
                },
                child: Text('Google Login')
            )

          ],
        ),
      ),
    );
  }
}
