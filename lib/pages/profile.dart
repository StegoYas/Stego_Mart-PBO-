import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stego_mart/auth/auth_service.dart';
import 'package:stego_mart/components/component.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // get auth service:
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  // UI nya:
  @override
  Widget build(BuildContext context) {
    //  get user email:
    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      appBar: Components.loadAppbar(Icons.arrow_back_ios_sharp,
        () => Navigator.pop(context), Icons.person, () => ProfilePage()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/Stegoyas_PP.png'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', 'Yahya Ayyas', CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', '+62 03107085816', CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Address', 'Norwegia, Kota New Asgard', CupertinoIcons.location),
            const SizedBox(height: 10),
            itemProfile('Email', currentEmail.toString(), CupertinoIcons.mail), // Use currentEmail here
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Logout Account')
              ),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );

  }
}
