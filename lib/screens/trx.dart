import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stego_mart/components/component.dart';
import 'package:stego_mart/screens/add.dart';

class TrxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: Components.loadAppbar(
        Icons.arrow_back_ios_sharp,
        () => Navigator.pop(context),
        Icons.person,
        () => {},
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: screenSize.height * 0.05,
                left: screenSize.width * 0.05,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddScreen()),
                  );
                },
                child: Container(
                  height: 40,
                  width: screenSize.width * 0.25,
                  constraints: BoxConstraints(
                    maxWidth: 150,
                    minWidth: 110,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 98, 0),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Add Data +",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),

           
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.02,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeaderText("Foto Produk", isSmallScreen),
                    SizedBox(width: screenSize.width * 0.05),
                    _buildHeaderText("Nama Produk", isSmallScreen),
                    SizedBox(width: screenSize.width * 0.05),
                    _buildHeaderText("Harga", isSmallScreen),
                    SizedBox(width: screenSize.width * 0.05),
                    _buildHeaderText("Aksi", isSmallScreen),
                  ],
                ),
              ),
            ),

           
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    makeDivider(),
                    _buildProductItem(
                      context: context,
                      img: "assets/images/Burger.jpg",
                      isSmallScreen: isSmallScreen,
                    ),
                    makeDivider(),
                    _buildProductItem(
                      context: context,
                      img: "assets/images/Minuman.jpg",
                      productName: "Coca Cola",
                      productPrice: "Rp. 20.000,00",
                      isSmallScreen: isSmallScreen,
                    ),
                    makeDivider(),
                    _buildProductItem(
                      context: context,
                      img: "assets/images/Seragamseifukujepang.jpg",
                      productName: "Seragam Sekolah",
                      productPrice: "Rp. 250.000,00",
                      isSmallScreen: isSmallScreen,
                    ),
                    makeDivider(),
                    _buildProductItem(
                      context: context,
                      img: "assets/images/Keyboard.jpg",
                      productName: "Keyboard Gaming",
                      productPrice: "Rp. 450.000,00",
                      isSmallScreen: isSmallScreen,
                    ),
                    makeDivider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required BuildContext context,
    required String img,
    String productName = "Burger King Medium",
    String productPrice = "Rp. 55.000,00",
    required bool isSmallScreen,
  }) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.01,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(img),
                height: isSmallScreen ? 80 : 100,
                width: isSmallScreen ? 80 : 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenSize.width * 0.03),

            // Product Name
            Container(
              width: screenSize.width * 0.2,
              constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: 200,
              ),
              child: Text(
                productName,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),
            SizedBox(width: screenSize.width * 0.03),

            // Product Price
            Container(
              width: screenSize.width * 0.15,
              constraints: BoxConstraints(
                minWidth: 80,
                maxWidth: 150,
              ),
              child: Text(
                productPrice,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),
            SizedBox(width: screenSize.width * 0.03),

            
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outlined,
                color: Colors.redAccent,
                size: isSmallScreen ? 32 : 40,
              ),
            ),
          ],
        ),
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
