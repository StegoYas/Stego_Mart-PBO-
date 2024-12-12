import 'package:flutter/material.dart';
import 'package:stego_mart/components/component.dart';
import 'package:stego_mart/screens/add.dart';
import 'package:stego_mart/screens/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrxScreen extends StatefulWidget {
  @override
  _TrxScreenState createState() => _TrxScreenState();
}

class _TrxScreenState extends State<TrxScreen> {
  final supabase = Supabase.instance.client;
  late final Stream<List<Map<String, dynamic>>> productStream;

  @override
  void initState() {
    super.initState();
    productStream = fetchProductStream();
  }

  Stream<List<Map<String, dynamic>>> fetchProductStream() {
    return supabase
        .from('food') // Pastikan tabel "food" sesuai dengan database Anda
        .stream(primaryKey: ['id']).map(
            (event) => event.map((e) => e as Map<String, dynamic>).toList());
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await supabase.from('food').delete().eq('id', productId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (error) {
      print('Error deleting product: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Components.loadAppbar(
        Icons.arrow_back_ios_sharp,
        () => Navigator.pop(context),
        Icons.person,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddScreen()),
              ),
              child: Text("Add Data +"),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: productStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Center(child: Text('Error loading products: $error'));
                }

                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return Center(child: Text('No products available'));
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Column(
                      children: [
                        makeDivider(),
                        _buildProductItem(
                          context: context,
                          product: product,
                          screenSize: screenSize,
                          onDelete: () => deleteProduct(product['id']),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem({
    required BuildContext context,
    required Map<String, dynamic> product,
    required Size screenSize,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.01,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Memastikan ikon di sebelah kanan
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar produk
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              product['image_url'] ?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey,
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          SizedBox(width: 15),
          // Informasi produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] ?? 'Unknown Product',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'Rp. ${product['harga']?.toString() ?? '0'}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 5),
                Text(
                  'Quantity: ${product['quantity']?.toString() ?? '0'}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          // Tombol hapus
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outlined,
              color: Colors.redAccent,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget makeDivider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 0.5,
        color: Colors.black,
      ),
    );
  }
}
