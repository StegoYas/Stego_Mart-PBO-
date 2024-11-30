import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stego_mart/components/component.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: Components.loadAppbar(Icons.arrow_back_ios_sharp,
          () => Navigator.pop(context), Icons.person, () => {}),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 20 : 40,
        ),
        child: loadProductsList(
          productItems: [
            ["assets/images/Burger.jpg", "Burger Medium", "Rp. 45.000,00"],
            ["assets/images/Minuman.jpg", "Coca Cola", "Rp. 45.000,00"],
            ["assets/images/Headsetgaming.jpg", "Headset Gaming", "Rp. 45.000,00"],
            ["assets/images/Keyboard.jpg", "Keyboard Gaming", "Rp. 45.000,00"],
            ["assets/images/jaketbaseball.jpg", "Jaket Baseball", "Rp. 45.000,00"],
          ],
          isSmallScreen: isSmallScreen,
        ),
      ),
      bottomNavigationBar: loadNavigationBar(isSmallScreen: isSmallScreen),
    );
  }

  Widget loadProductsList({
    List productItems = const [
      ["assets/images/Burger.jpg", "Burger King Medium", "Rp. 50.000,00"],
      ["assets/images/Minuman.jpg", "Coca Cola", "Rp. 10.000,00"],
    ],
    required bool isSmallScreen,
  }) {
    return Expanded(
      child: GridView.count(
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: isSmallScreen ? 2.0 : 3.0,
        crossAxisCount: 1,
        children: List.generate(productItems.length, (index) {
          return loadProductCard(
            productItems[index][0],
            productItems[index][1],
            productItems[index][2],
            isSmallScreen,
          );
        }),
      ),
    );
  }

  Widget loadProductCard(
      String image, String name, String price, bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: AspectRatio(
            aspectRatio: isSmallScreen ? 1.0 : 1.5,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 16 : 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 10 : 12,
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 45, 45, 45),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove),
                        iconSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("1"),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        iconSize: isSmallScreen ? 16 : 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: isSmallScreen ? 10 : 80),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outlined,
                color: Colors.redAccent, size: isSmallScreen ? 24 : 30),
          ),
        )
      ],
    );
  }

  Widget loadNavigationBar({required bool isSmallScreen}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 20 : 40,
      ),
      height: isSmallScreen ? 250 : 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 25 : 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Ringkasan Pembelian",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: isSmallScreen ? 18 : 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "PPN 11%",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Rp 10.000,00",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Color.fromARGB(255, 44, 44, 44),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Pembelian",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                      ),
                      Text(
                        "Rp 94.000,00",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                      ),
                    ),
                    Text(
                      "Rp 104.000,00",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: isSmallScreen ? 15 : 30),
            height: isSmallScreen ? 55 : 65,
            width: isSmallScreen ? 250 : 300,
            child: TextButton(
              onPressed: () => {},
              child: Text(
                "Checkout",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                foregroundColor: const Color.fromARGB(255, 13, 16, 46),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
