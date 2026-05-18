import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  final AuthServices authServices = AuthServices();

  bool isHidden = true;
  bool isHidden2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 20),

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
                    "Bergabung Dengan SmartCash",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004532),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Mulai perjalanan finansial\nberkah Anda",
                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 35),

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
                      //nama
                      TextFormField(
                        controller: namaController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama Wajib diisi";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",

                          hintText: "Masukkan nama lengkap",

                          prefixIcon: const Icon(Icons.person),

                          filled: true,
                          fillColor: Colors.grey.shade100,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

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

                      const SizedBox(height: 20),

                      //password
                      TextFormField(
                        controller: passwordController,

                        obscureText: isHidden,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password wajib diisi";
                          }

                          if (value.length < 6) {
                            return "Password minimal 6 Karakter";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Password",

                          hintText: "Masukkan password",

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

                      const SizedBox(height: 20),

                      //konfirmasi password
                      TextFormField(
                        controller: confirmController,

                        obscureText: isHidden2,

                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Password tidak sama";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: "Konfirmasi Password",

                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),

                            onPressed: () {
                              setState(() {
                                isHidden2 = !isHidden2;
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

                      const SizedBox(height: 28),

                      //button
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
                              String? error = await authServices.register(
                                email: emailController.text,
                                password: passwordController.text,
                                nama: namaController.text,
                              );

                              if (error == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Register Berhasil"),
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,

                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
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
                            "Daftar Sekarang",

                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text("Sudah punya akun?"),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      "Masuk",

                      style: TextStyle(
                        color: Color(0xFF004532),
                        fontWeight: FontWeight.bold,
                      ),
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
}
