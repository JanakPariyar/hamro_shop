import 'package:flutter/material.dart';
import 'package:hamropasal/pages/signUp_page.dart';
import 'package:hamropasal/reusable_widgets/login_signUp_button.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';

import '../reusable_widgets/image_box.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.purpleAccent,
              Colors.deepPurple,
            ],
            begin: Alignment.topCenter,end: Alignment.bottomRight,
          )
        ),
        child: Padding(
          padding:EdgeInsets.symmetric(vertical: height*0.1,horizontal: 10.0),
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.only(top: 30.0 ),
                child: logoWidget("assets/image_assets/logo.png"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              reusableTextField("Phone Number", false, phoneNumberController),
              const SizedBox(
                height: 30.0,
              ),
              reusableTextField("Password",  true, passwordController),
              const SizedBox(
                height: 30.0,
              ),
              LoginSignupButton(context, "Log In", (){},width*0.3,Colors.greenAccent),
              SigninOptions()
            ],
          ),
        ),
      ),
    );
  }

Row SigninOptions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("don't have an account?",style: TextStyle(color: Colors.white),),
        GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder:(context)=> SignUpPage()));
          },
          child: const Text("SignUp for free",style: TextStyle(color: Colors.blue),),
        )
      ],
    );
}
}
