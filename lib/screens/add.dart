import 'dart:typed_data'; // Untuk Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stego_mart/screens/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Untuk Supabase
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

final supabase = Supabase.instance.client;

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _kategori = 'Makanan';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  Uint8List? _selectedImage; // Untuk menyimpan gambar sebagai Uint8List
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Baca sebagai Uint8List
      setState(() {
        _selectedImage = bytes;
      });
    }
  }

  Future<String?> _uploadImageToSupabase() async {
    if (_selectedImage == null) return null;

    try {
      final fileName = 'product_${DateTime.now().millisecondsSinceEpoch}.png';

      // Upload gambar ke Supabase Storage
      await supabase.storage
          .from('stego_mart')
          .uploadBinary(fileName, _selectedImage!);

      // Mendapatkan URL publik gambar
      final imageUrl =
          supabase.storage.from('stego_mart').getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image upload failed: $e")),
      );
      return null;
    }
  }

  Future<void> _submitData() async {
    final name = _nameController.text;
    final harga = int.tryParse(_hargaController.text);
    final quantity = int.tryParse(_quantityController.text);
    if (name.isEmpty ||
        harga == null ||
        quantity == null ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please complete all fields and select an image")),
      );
      return;
    }

    final imageUrl = await _uploadImageToSupabase();
    if (imageUrl == null) return;

    try {
      await supabase.from('food').insert({
        'name': name,
        'harga': harga,
        'quantity': quantity,
        'kategori': _kategori,
        'image_url': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data successfully uploaded")),
      );

      // Reset form setelah berhasil
      setState(() {
        _nameController.clear();
        _hargaController.clear();
        _quantityController.clear();
        _kategori = 'Makanan';
        _selectedImage = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.person,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Create",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _hargaController,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: _kategori,
              items: ['Makanan', 'Minuman']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _kategori = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori Produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedImage != null
                        ? Flexible(
                            child: Image.memory(
                              _selectedImage!,
                              width: mediaWidth * 0.3,
                              height: mediaHeight * 0.15,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Text("No image selected"),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Pick Image"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 98, 0),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
