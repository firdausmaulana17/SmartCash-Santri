import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),

                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Text(
                            "SmartCash",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004532),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "PONDOK DIGITAL ECOSYSTEM",
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    width: double.infinity,
                    height: 350,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),

                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20),
                      ],
                    ),

                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),

                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),

                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                              colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 20,
                          right: 20,

                          child: Container(
                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: const [
                                Text(
                                  "Tabungan Aktif",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),

                                SizedBox(height: 5),

                                Text(
                                  "Rp 1.250.000",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004532),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Kelola Keuangan Santri\nLebih Aman",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF191C1D),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Ekosistem digital terpadu untuk\nkemandirian finansial dan berkah\ndi lingkungan pondok",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        width: 30,
                        height: 8,

                        decoration: BoxDecoration(
                          color: const Color(0xFF004532),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      const SizedBox(width: 6),

                      _dot(),
                      _dot(),
                    ],
                  ),

                  const SizedBox(height: 25),

                  //button
                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004532),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "Mulai Sekarang",
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

                  const SizedBox(height: 15),

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
                      "Sudah punya akun? Masuk",
                      style: TextStyle(
                        color: Color(0xFF004532),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  //footer
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.security, size: 16, color: Colors.black38),

                      SizedBox(width: 5),

                      Text(
                        "Secure SSL",
                        style: TextStyle(fontSize: 11, color: Colors.black38),
                      ),

                      SizedBox(width: 20),

                      Icon(Icons.shield, size: 16, color: Colors.black38),

                      SizedBox(width: 5),

                      Text(
                        "Syariah Compliance",
                        style: TextStyle(fontSize: 11, color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 8,
      height: 8,

      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
