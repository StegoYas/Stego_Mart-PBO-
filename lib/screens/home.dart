import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stego_mart/components/component.dart';
// import 'package:stego_mart/screens/add.dart';
import 'package:stego_mart/screens/cart.dart';
import 'package:stego_mart/screens/profile.dart';
import 'package:stego_mart/screens/trx.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // State variable for selected index

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrxScreen()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Components.loadAppbar(
        Icons.arrow_back_ios_sharp,
        () => Navigator.pop(context),
        Icons.person,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            loadCategoriesRow(),
            loadProductsGrid(), // Call the products grid method here
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 28),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_outlined, size: 30),
            label: 'Data',
          ),
        ],
        currentIndex: _selectedIndex, // Set current index
        onTap: _onItemTapped, // Handle tap
      ),
    );
  }

  Widget loadCategoriesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        loadCategoryItem(
            color: Color.fromARGB(255, 170, 0, 238),
            image: AssetImage("assets/images/food.jpg"),
            label: "All"),
        loadCategoryItem(
            color: Colors.white,
            image: AssetImage("assets/images/Burger.jpg"),
            label: "Food"),
        loadCategoryItem(
            color: Colors.white,
            image: AssetImage("assets/images/Minuman.jpg"),
            label: "Drinks"),
        loadCategoryItem(
            color: Colors.white,
            image: AssetImage("assets/images/Fashion.jpg"),
            label: "Fashion"),
        loadCategoryItem(
            color: Colors.white,
            image: AssetImage("assets/images/Electronic.png"),
            label: "Electronics"),
      ],
    );
  }

  Widget loadCategoryItem({
    required Color color,
    required ImageProvider image,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(102, 0, 0, 0),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: InkWell(
              onTap: () => {},
              child: Image(
                image: image,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget loadProductsGrid() {
    List<List> foodItems = [
      ["Burger King", "Rp 50.000", "assets/images/Burger.jpg"],
      ["Coca Cola", "Rp 70.000", "assets/images/Minuman.jpg"],
      ["Keyboard Gaming", "Rp 350.000", "assets/images/Keyboard.jpg"],
      ["Headset Gaming", "Rp 400.000", "assets/images/Headsetgaming.jpg"],
      ["Pizza Hut Medium", "Rp 95.000", "assets/images/posterpizza1.jpg"],
      [
        "Seragam Sekolah",
        "Rp 200.000",
        "assets/images/Seragamseifukujepang.jpg"
      ],
      ["Pizza Hut Small", "Rp 65.000", "assets/images/posterpizza2.jpg"]
    ];

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8), // Memberikan padding untuk grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16, // Jarak antar baris
          crossAxisSpacing: 16, // Jarak antar kolom
          childAspectRatio: 0.75,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return loadProductCard(
            name: foodItems[index][0],
            price: foodItems[index][1],
            image: foodItems[index][2],
          );
        },
      ),
    );
  }

  Widget loadProductCard({
    required String name,
    required String price,
    required String image,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(148, 0, 0, 0),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis, // Membatasi teks panjang
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              InkWell(
                onTap: () => {}, // Add your onTap logic here
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.orange,
                  ),
                  child: Icon(Icons.add, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
