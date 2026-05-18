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
      backgroundColor: const Color(0xFFF8F9FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 30),

              //logo
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,

                    child: Image.asset("assets/images/logo.png"),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "SmartCash Santri",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004532),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Kelola keuangan pesantren\ndengan disiplin dan berkah",
                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              //login
              Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),

                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 15),
                  ],
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [
                      //email
                      TextFormField(
                        controller: emailController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email wajib diisi";
                          }

                          if (!value.contains("@")) {
                            return "Format email tidak valid";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Email",

                          hintText: "contoh@gmail.com",

                          prefixIcon: const Icon(Icons.email),

                          filled: true,
                          fillColor: Colors.grey.shade100,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      //password
                      TextFormField(
                        controller: passwordController,
                        obscureText: isHidden,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password wajib diisi";
                          }

                          if (value.length < 6) {
                            return "Password minimal 6 karakter";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Password",

                          hintText: "••••••",

                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),

                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                          ),

                          filled: true,
                          fillColor: Colors.grey.shade100,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {},

                          child: const Text(
                            "Lupa Password",
                            style: TextStyle(color: Color(0xFF004532)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      //button login
                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004532),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(18),
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

                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                "Masuk ke Akun",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 8),

                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text("Belum punya akun?"),

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
                      "Daftar",
                      style: TextStyle(
                        color: Color(0xFF004532),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //bento card
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 140,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        image: const DecorationImage(
                          image: AssetImage("assets/images/ekosistem.png"),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Container(
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,

                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),

                        alignment: Alignment.bottomLeft,

                        child: const Text(
                          "Ekosistem\nSantri",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Container(
                      height: 140,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        image: const DecorationImage(
                          image: AssetImage("assets/image/keuangan.png"),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Container(
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,

                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),

                        alignment: Alignment.bottomLeft,

                        child: const Text(
                          "Keuangan\nBerkah",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              //footer
              Column(
                children: [
                  const Text(
                    "© 2026 SmartCash Santri",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      TextButton(
                        onPressed: () {},

                        child: const Text(
                          "Privasi",
                          style: TextStyle(color: Colors.black45, fontSize: 12),
                        ),
                      ),

                      const Text("•", style: TextStyle(color: Colors.black45)),

                      TextButton(
                        onPressed: () {},

                        child: const Text(
                          "Syarat",
                          style: TextStyle(color: Colors.black45, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
