import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaktus_toon/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  bool isloading = false;

  late SharedPreferences logindata;
  late bool newRegis;
  void checkRegis() async {
    logindata = await SharedPreferences.getInstance();
    newRegis = logindata.getBool('regis') ?? true;
    if (newRegis == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkRegis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Register new\naccount',
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/accent.png',
                            width: 200,
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      child: Column(
                        children: [
                          textField(
                            controller: _emailController,
                            lable: 'Email',
                            valid: (value) {
                              if (value!.isEmpty) {
                                return 'Enter some Email';
                              } else if (value.length < 4) {
                                return 'Enter at least 4 Characters';
                              }
                              return null;
                            },
                            boolean: false,
                          ),
                          textField(
                            controller: _passwordController,
                            lable: 'PassWord',
                            valid: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be null';
                              } else if (value.length < 8) {
                                return 'Enter at least 8 Characters';
                              }
                              return null;
                            },
                            boolean: _passwordVisible1,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              },
                              icon: Icon(
                                _passwordVisible1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          textField(
                            controller: _passwordConfirmController,
                            lable: 'Confirm Password',
                            valid: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be null';
                              } else if (value.length < 8) {
                                return 'Enter at least 8 Characters';
                              } else if (value != _passwordController.text) {
                                return 'Password must be the same';
                              }
                              return null;
                            },
                            boolean: _passwordVisible2,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              },
                              icon: Icon(
                                _passwordVisible2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(400, 50)),
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String pass = _passwordConfirmController.text.trim();
                          if (formKey.currentState!.validate()) {
                            logindata.setString('email', email);
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: pass);
                              logindata.setBool('regis', false);
                              await Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const HomePage();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return Align(
                                        child: SizeTransition(
                                          sizeFactor: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 750),
                                  ),
                                  (route) => false);
                              setState(() {
                                isloading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title:
                                      const Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Okay'),
                                    )
                                  ],
                                ),
                              );
                            }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                        child: const Text(
                          'Register',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Lato-bold'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontStyle: FontStyle.normal),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String lable,
    required String? Function(String?)? valid,
    required bool boolean,
    Widget? icon,
  }) {
    return TextFormField(
      obscureText: boolean,
      validator: valid,
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
        hintText: lable,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        border: const UnderlineInputBorder(),
        isDense: true,
        suffixIcon: icon,
      ),
    );
  }
}
