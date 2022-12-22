import 'package:flutter/material.dart';
import 'package:tiktok/controller/AuthController.dart';
import 'package:tiktok/view/screens/auth/Signup.dart';
import 'package:tiktok/view/widgets/TextInputField.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

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
                  const Text("Shorts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: (){
                        AuthController.instance.login(emailController.text, passwordController.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          child: const Text("Login")
                      )
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account ?"),
                      TextButton(onPressed: (){
                        Get.off(const SignupScreen());
                      }, child: const Text("Create Account")),
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