import 'package:flutter/material.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List transaction = [];

  int totalSaldo = 0;
  int totalMasuk = 0;
  int totalKeluar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D5C3B),
        elevation: 0,
        title: const Text("SmartCash Santri"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF0D5C3B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),

            child: Column(
              children: [
                Text("Total Saldo", style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text(
                  "Rp $totalSaldo",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _cardInfo("Pemasukan", "Rp $totalMasuk", Colors.green),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _cardInfo(
                    "Pengeluaran",
                    "Rp $totalKeluar",
                    Colors.red,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  "Transaksi Terbaru",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                ...transaction.map((trx) {
                  bool isMasuk = trx["Type"] == "Pemasukan";

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isMasuk
                          ? Colors.green.shade100
                          : Colors.red.shade100,

                      child: Icon(
                        isMasuk ? Icons.arrow_downward : Icons.arrow_upward,

                        color: isMasuk ? Colors.green : Colors.red,
                      ),
                    ),

                    title: Text(trx["title"]),

                    subtitle: Text(trx["type"]),

                    trailing: Text(
                      "${isMasuk ? '+' : '-'}Rp ${trx["amount"]}",
                      style: TextStyle(
                        color: isMasuk ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0D5C3B),
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              transaction.add(result);

              int amount = int.parse(result["amount"]);

              if (result["type"] == "Pemasukan") {
                totalSaldo += amount;
                totalMasuk += amount;
              } else {
                totalSaldo -= amount;
                totalKeluar += amount;
              }
            });
          }
        },
      ),
    );
  }

  Widget _cardInfo(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),

      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
