import 'dart:typed_data'; // Untuk Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Untuk Supabase
import 'package:google_fonts/google_fonts.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String? selectedCategory;
  Uint8List? _selectedImage; // Mengubah tipe ke Uint8List
  final ImagePicker _picker = ImagePicker();

  // Supabase Client
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            children: [
              makeInputText("Nama Produk", "Masukkan Nama Produk"),
              makeInputText("Harga Produk", "Masukkan Harga"),
              makeInputSelect(),
              makeInputImage(),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    _uploadImageToSupabase(
                      nama: "Nama Produk", // Ganti dengan value dari input nama
                      harga: 15000.0, // Ganti dengan value dari input harga
                      kategori: selectedCategory ??
                          "Makanan", // Kategori yang dipilih
                    );
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 98, 0),
                    foregroundColor: const Color.fromARGB(255, 13, 16, 46),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInputText(String title, String placeholder) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeInputSelect() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kategori",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCategory,
                iconSize: 24,
                isExpanded: true,
                items: [
                  DropdownMenuItem(child: Text("Makanan"), value: "Makanan"),
                  DropdownMenuItem(child: Text("Minuman"), value: "Minuman"),
                ],
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeInputImage() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gambar Produk",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            color: Colors.white,
            child: Text(
              "Please select an image",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            onPressed: _pickImage,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _selectedImage!, // Menampilkan gambar dari Uint8List
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(child: Text("No image")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Baca sebagai Uint8List
      setState(() {
        _selectedImage = bytes;
      });
    }
  }

  Future<void> _uploadImageToSupabase({
    required String nama,
    required double harga,
    required String kategori,
  }) async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first")),
      );
      return;
    }

    try {
      final fileName = 'product_${DateTime.now().millisecondsSinceEpoch}.png';

      // Upload gambar ke Supabase Storage
      final storageResponse = await _supabaseClient.storage
          .from('stego_mart') // Ganti dengan nama bucket
          .uploadBinary(fileName, _selectedImage!);

      if (storageResponse.isEmpty) {
        throw Exception("Storage Error: File upload failed.");
      }

      // Mendapatkan URL publik gambar
      final imageUrl =
          _supabaseClient.storage.from('stego_mart').getPublicUrl(fileName);

      // Simpan data produk ke tabel 'food'
      final dbResponse = await _supabaseClient
          .from('food') // Nama tabel
          .insert({
        'nama': nama, // Nama produk dari input pengguna
        'harga': harga, // Harga produk dari input pengguna
        'kategori': kategori, // Kategori dari input dropdown
        'gambar': imageUrl, // URL gambar yang diunggah
      });

      if (dbResponse.error != null) {
        throw Exception("Database Error: ${dbResponse.error!.message}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded and data saved successfully")),
      );

      // Reset form dan state setelah berhasil
      setState(() {
        _selectedImage = null;
        selectedCategory = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
