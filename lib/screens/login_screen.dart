import 'package:flutter/material.dart';
import 'package:smartcash_santri/screens/register_screen.dart';
import 'home_screen.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthServices authServices = AuthServices();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8EF),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const SizedBox(height: 30),

                  //logo
                  Image.asset("assets/images/logo.png", width: 140),

                  const SizedBox(height: 20),

                  //title
                  const Text(
                    "SmartCash Santri",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D5C3B),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Kelola Keuangan Santri Dengan Bijak",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const SizedBox(height: 40),

                  //email
                  TextFormField(
                    controller: emailController,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email Wajib diisi";
                      }

                      if (!value.contains("@")) {
                        return "Format email tidak valid";
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //password
                  TextFormField(
                    controller: passwordController,
                    obscureText: isHidden,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pasword wajib diisi";
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Password",

                      prefixIcon: const Icon(Icons.lock),

                      suffixIcon: IconButton(
                        icon: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility,
                        ),

                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  //button login
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D5C3B),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String? error = await authServices.login(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          if (error == null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                          }
                        }
                      },

                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      "Belum Punya Akun? Daftar",
                      style: TextStyle(color: Color(0xFF0D5C3B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
