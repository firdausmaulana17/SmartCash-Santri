import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController titleControler = TextEditingController();
  final TextEditingController amountControler = TextEditingController();

  String type = "Pemasukan";

  void saveTransaction() {
    String title = titleControler.text;
    String amount = amountControler.text;

    if (title.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Isi Semua Field")));
      return;
    }

    Navigator.pop(context, {"title": title, "amount": amount, "type": type});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Transaksi"),
        backgroundColor: const Color(0xFF0D5C3B),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleControler,
              decoration: const InputDecoration(
                labelText: "Jenis Transaksi",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountControler,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "jumlah",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField(
              value: type,
              items: const [
                DropdownMenuItem(value: "Pemasukan", child: Text("Pemasukan")),
                DropdownMenuItem(
                  value: "Pengeluaran",
                  child: Text("Pengeluaran"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D5C3B),
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text("simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
