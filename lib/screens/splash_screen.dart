import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8EE),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bg_masjid.png',
              fit: BoxFit.cover,
              height: 320,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),

                Center(
                  child: Image.asset('assets/images/logo.png', width: 190),
                ),

                const SizedBox(height: 20),

                const Text(
                  "SmartCash",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B4F33),
                  ),
                ),

                const Text(
                  "Santri",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5BAF4C),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Catatan Keuangan Harian",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Untuk Santri",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.green.shade300,
                          thickness: 1,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.star, size: 18, color: Colors.green),
                      ),

                      Expanded(
                        child: Divider(
                          color: Colors.green.shade300,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      Text(
                        "Kelola Keuangan dengan Bijak",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Hidup Lebih Berkah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
