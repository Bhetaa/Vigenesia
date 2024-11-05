import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:another_flushbar/flushbar.dart';
import 'Login.dart';
import 'EditPage.dart';

class VigenesiaTheme {
  static final Color primaryColor = const Color(0xFF0052D4);
  static final Color accentColor = const Color(0xFF6FB1FC);
  static const Color backgroundColor = Colors.white;
  static final Color buttonColor = const Color(0xFF007BFF);
}

class MotivasiModel {
  final String? id;
  final String isiMotivasi;

  MotivasiModel({required this.id, required this.isiMotivasi});
}

class MainScreens extends StatefulWidget {
  final String? nama;

  // Tambahkan nilai default "User Demo" jika nama tidak diberikan
  const MainScreens({Key? key, this.nama = "Hikmal Chalabi"}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final TextEditingController isiController = TextEditingController();

  List<MotivasiModel> listMotivasi = [
    MotivasiModel(id: "1", isiMotivasi: "Tetap semangat dan jangan menyerah!"),
    MotivasiModel(
        id: "2", isiMotivasi: "Kesuksesan adalah hasil dari kerja keras!"),
    MotivasiModel(
        id: "3",
        isiMotivasi: "Belajar dari kesalahan adalah kunci keberhasilan."),
    MotivasiModel(
        id: "4", isiMotivasi: "Belajar Pemrograman itu sangat seru sekali."),
    MotivasiModel(id: "5", isiMotivasi: "Waktu adalah uang."),
  ];

  // Fungsi untuk menambah motivasi
  void addMotivasi(String isi) {
    setState(() {
      listMotivasi
          .add(MotivasiModel(id: DateTime.now().toString(), isiMotivasi: isi));
    });
    Flushbar(
      message: "Motivasi berhasil ditambahkan!",
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.greenAccent,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  // Fungsi untuk menghapus motivasi
  void deleteMotivasi(String id) {
    setState(() {
      listMotivasi.removeWhere((motivasi) => motivasi.id == id);
    });
    Flushbar(
      message: "Motivasi berhasil dihapus!",
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  // Fungsi untuk memperbarui motivasi
  void editMotivasi(String id, String isiBaru) {
    setState(() {
      listMotivasi = listMotivasi.map((motivasi) {
        if (motivasi.id == id) {
          return MotivasiModel(id: motivasi.id, isiMotivasi: isiBaru);
        }
        return motivasi;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VigenesiaTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Vigenesia'),
        backgroundColor: VigenesiaTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: VigenesiaTheme.primaryColor,
              ),
              child: const Text(
                'Vigenesia Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.format_quote),
              title: const Text('Motivasi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Menampilkan nama pengguna dengan default "User"
                Text(
                  "Hallo, ${widget.nama ?? "Hikmal Chalabi"}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: VigenesiaTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  controller: isiController,
                  name: "isi_motivasi",
                  decoration: const InputDecoration(
                    labelText: "Tulis Motivasi Anda",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (isiController.text.isNotEmpty) {
                      addMotivasi(isiController.text);
                      isiController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: VigenesiaTheme.buttonColor),
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 40),
                Text(
                  "Daftar Motivasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: VigenesiaTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listMotivasi.length,
                  itemBuilder: (context, index) {
                    var item = listMotivasi[index];
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(item.isiMotivasi),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(
                                        initialMotivasi: item.isiMotivasi),
                                  ),
                                );
                                if (result != null) {
                                  editMotivasi(item.id!, result);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteMotivasi(item.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
