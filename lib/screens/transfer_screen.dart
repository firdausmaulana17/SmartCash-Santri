import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailTujuanController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();

  bool isLoading = false;
  final String? currentUid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _prosesTransfer() async {
    if (!_formKey.currentState!.validate() || currentUid == null) return;

    setState(() {
      isLoading = true;
    });

    final String emailTujuan = emailTujuanController.text.trim();
    final int nominalTransfer = int.parse(nominalController.text.trim());

    try {
      var userTujuanSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailTujuan)
          .get();
      if (userTujuanSnapshot.docs.isEmpty) {
        throw "Email Tujuan tidak di temukan atau tidak terdaftar!";
      }

      var dataTujuan = userTujuanSnapshot.docs.first;
      String uidTujuan = dataTujuan.id;

      if (uidTujuan == currentUid) {
        throw "Tidak bisa mentransfer uang ke akun anda sendiri!";
      }

      var pengirimSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .get();

      int saldoPengirim = pengirimSnapshot.data()?['saldo'] ?? 0;

      if (saldoPengirim < nominalTransfer) {
        throw "Saldo Anda tidak mencukupi untuk melakukan transfer ini.";
      }

      WriteBatch batch = FirebaseFirestore.instance.batch();

      batch.update(
        FirebaseFirestore.instance.collection('users').doc(currentUid),
        {'saldo': FieldValue.increment(-nominalTransfer)},
      );

      batch.update(
        FirebaseFirestore.instance.collection('users').doc(uidTujuan),
        {'saldo': FieldValue.increment(nominalTransfer)},
      );

      await batch.commit();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Transfer Berhasil! Saldo sukses di kirim."),
          ),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Transfer Saldo",
          style: TextStyle(
            color: Color(0xFF004532),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF004532)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kirim Saldo ke Sesama Santri",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004532),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pastika email tujuan sesuai dengan yang terdaftar di sistem",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: emailTujuanController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Email tujuan wajib diisi";
                  if (!value.contains("@")) return "Format email salah";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email Penerima",
                  hintText: "contoh@gmail.com",
                  prefixIcon: const Icon(Icons.mail),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Nominal wajib diisi";
                  int? nom = int.tryParse(value);
                  if (nom == null || nom <= 0)
                    return "Nominal harus lebih dari Rp 0";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nominal Transfer",
                  prefixText: "Rp",
                  prefixIcon: const Icon(Icons.payments),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004532),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: isLoading ? null : _prosesTransfer,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Kirim Sekarang",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
