
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
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bee.png"),
            Text("My Memo",
            style: TextStyle(fontSize: 40,)),
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/google icon.png",height: 30,width: 30,),
                SizedBox(width: 5),
                OutlinedButton(

                    onPressed: () async{

                      GoogleSignInAccount? _account = await _googleSignIn.signIn();
                      print(_account?.email);


                      //todo 경우 1 : 기존유저 없음 -> 회원가입 요청후 가입된 회원정보 가져오기
                      //todo 경우 2 : 이미 가입된 회원이라면 -> 회원가입 없이 회원정보 가져오기
                    },
                    child: Text('Google Login')
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}
