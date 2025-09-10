import 'package:bmi_calculator/pages/history_page.dart';
import 'package:bmi_calculator/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: DrawerHeader(child: Icon(Icons.healing, size: 100)),
          ),

          SizedBox(height: 50),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('H O M E'),
              ),
            ),
          ),

          SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('H I S T O R Y'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
