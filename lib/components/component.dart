import 'package:flutter/material.dart';

class Components {
 static loadAppbar(IconData icon1, VoidCallback onPressed1, IconData icon2, VoidCallback onPressed2) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      actions: [],
      title: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 15),
                  ]),
              child: IconButton(onPressed: onPressed1, icon: Icon(icon1)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 15),
                  ]),
              child: IconButton(onPressed: onPressed2, icon: Icon(icon2)),
            ),
          ],
        ),
      ),
    );
  }
}
