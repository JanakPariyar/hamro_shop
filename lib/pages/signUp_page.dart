import 'package:flutter/material.dart';
import 'package:hamropasal/pages/signUp_page.dart';
import 'package:hamropasal/pages/signin_page.dart';
import 'package:hamropasal/reusable_widgets/login_signUp_button.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';

import '../reusable_widgets/image_box.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

TextEditingController phoneNumberController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [

                Colors.purpleAccent,
                Colors.deepPurple,
                Colors.white,
              ],
              begin: Alignment.topCenter,end: Alignment.bottomRight,
            )
        ),
        child: Padding(
          padding:EdgeInsets.symmetric(vertical: height*0.1,horizontal: 10.0),
          child: Column(
            children:<Widget> [

              const SizedBox(
                height: 30.0,
              ),
              reusableTextField("Phone Number",  false, phoneNumberController),
              const SizedBox(
                height: 30.0,
              ),
              reusableTextField("userName",  false, userNameController),
              const SizedBox(
                height: 30.0,
              ),
              reusableTextField("Password",true, passwordController),
              const SizedBox(
                height: 30.0,
              ),
              LoginSignupButton(context, "Sign Up", (){},width*0.3,Colors.greenAccent),
              const SizedBox(
                height: 30.0,
              ),
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
        const Text("Already have an account?",style: TextStyle(color: Colors.white),),
        GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder:(context)=> SignInPage()));
          },
          child: const Text("SignUp for free",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

}
