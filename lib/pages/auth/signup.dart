import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/pages/auth/authcontroller.dart';
import 'package:fitness_app/pages/auth/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    
    List images = [
      'google.jpg',
      'twitter.png',
      'facebook.png'
    ];

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
                  fit: BoxFit.cover,
                  ),
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    "assets/profilePic.jpg"
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      ),                      focusedBorder: OutlineInputBorder(
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
                      obscureText: true,
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
                
                  const SizedBox( height: 60),
                
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                      },
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
                          child: Text('Sign Up', 
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: RichText(text: TextSpan(
                      text: "Have an account?",
                      style: const TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 15
                      ),
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: const TextStyle(
                              color: Color.fromRGBO(30, 215, 96, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => Get.back(result: () => const SignInPage()),
                        ),
                      ],
                    ),
                    ),
                  ),

                  const SizedBox( height: 45),

                  Center(
                    child: RichText(text: const TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                        color: Color.fromRGBO(30, 215, 96, 1),
                        fontSize: 15
                      )
                    )
                  )
                ),

                      const SizedBox( height: 10,),
                      Center(
                        child: Wrap(
                          children: List<Widget>.generate(
                              3,
                                  (index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(blurRadius: 7.5, color: Color.fromRGBO(30, 215, 96, 1), spreadRadius: 2.5)],
                                      ),
                                      child: GestureDetector(
                                        onTap: (){
                                          FirebaseService()._googleSignIn.signIn().then((value) => null);
                                          },
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                              'assets/' + images[index]
                                          ),
                                        ),
                                      ),
                                    )
                                );
                              }
                              ),
                        ),
                      )
                    ],
                  ),
                ),
            SizedBox(height: w * 0.1,),
          ],
        ),
      ),
    );
  }
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}