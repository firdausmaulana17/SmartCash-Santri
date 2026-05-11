import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF5F8EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D5C3B),
        title: const Text("Daftar Akun"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const SizedBox(height: 30),

                Image.asset("assets/images/logo.png", width: 120),
                const SizedBox(height: 20),

                const Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D5C3B),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Daftar untuk mulai mengelola keuangan santri",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                //nama
                TextFormField(
                  controller: namaController,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama wajib diisi";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    hintText: "Nama Lengkap",

                    prefixIcon: const Icon(Icons.person),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

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
                      return "Email tidak valid";
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

                //pasword
                TextFormField(
                  controller: passwordController,
                  obscureText: isHidden,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Pasword wajib diisi";
                    }

                    if (value.length < 6) {
                      return "Pasword minimal 6 karakter";
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
                    hintText: "Konfirmasi Password",

                    prefixIcon: const Icon(Icons.lock),

                    suffixIcon: IconButton(
                      icon: Icon(
                        isHidden2 ? Icons.visibility_off : Icons.visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          isHidden2 = !isHidden2;
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

                //button Daftar
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
                        String? error = await authServices.register(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (error == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Register berhasil")),
                          );

                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(error)));
                        }
                      }
                    },

                    child: const Text(
                      "Daftar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
