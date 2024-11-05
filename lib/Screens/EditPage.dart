import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:another_flushbar/flushbar.dart';

class EditPage extends StatefulWidget {
  final String initialMotivasi;

  const EditPage({Key? key, required this.initialMotivasi}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // Controller untuk mengelola input teks motivasi
  final TextEditingController _motivasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mengisi nilai awal dengan motivasi yang dikirim dari MainScreens
    _motivasiController.text = widget.initialMotivasi;
  }

  @override
  void dispose() {
    // Membersihkan controller saat widget dihapus
    _motivasiController.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan perubahan motivasi dan kembali ke halaman sebelumnya
  void _saveMotivasi() {
    String updatedMotivasi = _motivasiController.text;

    // Menampilkan notifikasi sukses menggunakan Flushbar
    Flushbar(
      message: "Motivasi berhasil diperbarui!",
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);

    // Kembali ke halaman sebelumnya dengan mengirimkan motivasi yang diperbarui
    Navigator.pop(context, updatedMotivasi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Motivasi"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Motivasi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FormBuilderTextField(
              name: "edit_motivasi",
              controller: _motivasiController,
              decoration: const InputDecoration(
                labelText: "Tulis Motivasi Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveMotivasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
