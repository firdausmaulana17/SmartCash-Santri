import 'package:flutter/material.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              children: const [
                Text("Total Saldo", style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text(
                  "Rp 5.000.000",
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
                  child: _cardInfo("Pemasukan", "Rp 500.000", Colors.green),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _cardInfo("Pengeluaran", "Rp 250.000", Colors.red),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                Text(
                  "Transaksi Terbaru",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                ListTile(
                  leading: Icon(Icons.arrow_downward, color: Colors.green),
                  title: Text("Uang Saku"),
                  subtitle: Text("Hari Ini"),
                  trailing: Text("+Rp 100.000"),
                ),
                ListTile(
                  leading: Icon(Icons.arrow_upward, color: Colors.red),
                  title: Text("Jajan"),
                  subtitle: Text("Hari Ini"),
                  trailing: Text("-Rp 20.000"),
                ),
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
            print(result);
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
