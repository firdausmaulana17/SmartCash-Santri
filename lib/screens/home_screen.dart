import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartcash_santri/screens/transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.uid ?? "dummy_id")
              .snapshots(),
          builder: (context, snapshot) {
            String namaSantri = "Santri";

            if (snapshot.hasData && snapshot.data!.exists) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              namaSantri = data['nama'] ?? "Santri";
            }

            return Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    border: Border.all(color: const Color(0xFFBEC9C2)),
                  ),

                  child: const ClipOval(
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF004532),
                      size: 28,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SmartCash Santri",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004532),
                        fontFamily: 'Manrope',
                      ),
                    ),

                    Text(
                      "Assalamu'alaikum,$namaSantri",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF3F4944),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Color(0xFF004532)),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid ?? "dummy_id")
            .snapshots(),
        builder: (context, snapshot) {
          int saldo = 0;
          int poin = 0;
          int limitHarian = 0;

          if (snapshot.hasData && snapshot.data!.exists) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            saldo = data['saldo'] ?? 0;
            poin = data['poin'] ?? 0;
            limitHarian = data['limitHarian'] ?? 0;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: AlignmentGeometry.topLeft,
                      colors: [Color(0xFF004532), Color(0xFF065F46)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Saldo Utama",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 4),
                              Text(
                                "Rp $saldo",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),

                            child: Row(
                              children: const [
                                Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Santri Aktif",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "poin",
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.stars,
                                        color: Color(0xFFA6F2D1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "$poin pts",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Limit Harian",
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.speed,
                                        color: Color(0xFFA6F2D1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Rp $limitHarian",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _menuItem(
                      icon: Icons.qr_code_scanner,
                      title: "Scan QR",
                      onTap: () {},
                    ),
                    _menuItem(
                      icon: Icons.add_card,
                      title: "Top Up",
                      onTap: () {
                        _showTopUpDialog(context, currentUser?.uid);
                      },
                    ),
                    _menuItem(
                      icon: Icons.send,
                      title: "Transfer",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransferScreen(),
                          ),
                        );
                      },
                    ),
                    _menuItem(
                      icon: Icons.payment,
                      title: "Bayar",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Riwayat Terakhir",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004532),
                        fontFamily: 'Manrope',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Lihat Semua",
                        style: TextStyle(
                          color: Color(0xFF004532),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                _transactionItem(
                  icon: Icons.storefront,
                  title: "Kantin Al-Fatih",
                  subtitle: "14 okt 2023  •  12:30",
                  amount: "-Rp 15.000",
                  desc: "Makan Siang",
                  isIncome: false,
                ),
                const SizedBox(height: 12),

                _transactionItem(
                  icon: Icons.account_balance_wallet,
                  title: "Top Up Saldo",
                  subtitle: "13 okt 2023  •  08:15",
                  amount: "+Rp 200.000",
                  desc: "Transfer Ortu",
                  isIncome: false,
                ),
                const SizedBox(height: 12),

                _transactionItem(
                  icon: Icons.receipt_long,
                  title: "Koperasi Santri",
                  subtitle: "12 okt 2023  •  16:45",
                  amount: "-Rp 45.000",
                  desc: "Alat Tulis",
                  isIncome: false,
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF365A4A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFBEC9C2).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.savings, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Tabungan Umroh",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Target: Rp 25.000.000",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "15%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      const ClipRRect(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                        child: LinearProgressIndicator(
                          value: 0.15,
                          minHeight: 10,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFA6F2D1),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      const Text(
                        "Teruslah istiqomah menabung demi niat suci. ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),

      //bottom navbar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadiusGeometry.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: const Color(0xFF004532),
            unselectedItemColor: const Color(0xFF3F4944),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront),
                label: "Kantin",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: "Riwayat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profil",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFCAE4CA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF004532)),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String desc,
    required bool isIncome,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBEC9C2).withOpacity(0.5)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isIncome
                      ? const Color(0xFFCAE4CA).withOpacity(0.5)
                      : Colors.green.shade50,
                ),
                child: Icon(
                  icon,
                  color: isIncome
                      ? const Color(0xFF4F6652)
                      : const Color(0xFF004532),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF3F4944),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: isIncome
                      ? const Color(0xFF004532)
                      : const Color(0xFFBA1A1A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(color: Color(0xFF3F4944), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTopUpDialog(BuildContext context, String? uid) {
    if (uid == null) return;
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Simulasi Top Up Saldo"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Masukkan nominal (Contoh: 50000)",
              prefixText: "Rp",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004532),
              ),
              onPressed: () async {
                int? inputAmount = int.tryParse(amountController.text);
                if (inputAmount != null && inputAmount > 0) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({
                        'saldo': FieldValue.increment(inputAmount),
                        'poin': FieldValue.increment(
                          (inputAmount / 1000).floor(),
                        ),
                      });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Top Up Berhasil! Saldo bertambah."),
                    ),
                  );
                }
              },
              child: const Text(
                "Konfirmasi",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
