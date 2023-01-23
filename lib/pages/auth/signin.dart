import 'package:fitness_app/pages/auth/authcontroller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/auth/signup.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 50, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/signInBackground.png',
                  fit: BoxFit.contain,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Hello', 
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  const Text('Sign into your account', 
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(30, 215, 96, 0.5)
                    ),
                  ),
                  const SizedBox( height: 50,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          color: Color.fromRGBO(30, 215, 96, 0.5)
                        ),
                      ],
                      color: const Color.fromRGBO(40, 40, 40, 1)
                    ),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: Colors.white,),
                      hintText: 'Email...', 
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.25)
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(40, 40, 40, 1)
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.25)
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox( height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          color: Color.fromRGBO(30, 215, 96, 0.5)
                        ),
                      ],
                      color: const Color.fromRGBO(40, 40, 40, 1)
                    ),
                    child: TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                      hintText: 'Password...', 
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.25)
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(40, 40, 40, 1)
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.25)
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox( height: 20,),
                  Row(
                    children: [
                      Expanded(child: Container(),),
                      const Text('Forgot your Password?', 
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(30, 215, 96, 0.5)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox( height: 60,),
                  Center(
                    child: GestureDetector(
                      onTap: (() {
                        AuthController.instance.signIn(emailController.text.trim(), passwordController.text.trim());
                      }),
                      child: Container(
                        width: w*0.5,
                        height: h*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/signInBackground.png"
                            ),
                            fit: BoxFit.cover
                          )
                        ),
                        child: const Center(
                          child: Text('Sign In', 
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: w * 0.1,),
            RichText(text: TextSpan(
              text: "Don't have an account?",
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.15),
                fontSize: 15
                ),
                children: [
                  TextSpan(
                    text: " Create",
                    style: const TextStyle(
                      color: Color.fromRGBO(30, 215, 96, 0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => const SignUpPage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}