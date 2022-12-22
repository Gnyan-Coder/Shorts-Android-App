import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controller/AuthController.dart';
import 'package:tiktok/view/screens/auth/Login.dart';
import 'package:tiktok/view/widgets/TextInputField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController conPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome To Shorts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  const SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      AuthController.instance.pickImage();
                    },
                    child: Stack(
                      children:const [
                        CircleAvatar(
                          backgroundImage: NetworkImage("https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 0,
                            right: 0,
                            child: Icon(Icons.camera_alt,)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(controller: userNameController, myIcon: Icons.account_circle, myLabelText: "User Name")
                  ),
                  const SizedBox(height: 25,),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(controller: emailController, myIcon: Icons.email, myLabelText: "Email")
                  ),
                  const SizedBox(height: 25,),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(controller: passwordController, myIcon: Icons.lock, myLabelText: "Password",isHide: true,)
                  ),
                  const SizedBox(height: 25,),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(controller: conPasswordController, myIcon: Icons.lock, myLabelText: "Confirm Password",isHide: true,)
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: (){
                        AuthController.instance.signUp(userNameController.text, emailController.text, passwordController.text,AuthController.instance.proImg);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          child: const Text("Sign Up")
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("If you have account ?"),
                      TextButton(
                          onPressed: (){
                            Get.off(const LoginScreen());
                          },
                          child:const Text("Login")
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}