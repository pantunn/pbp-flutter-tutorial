import 'package:flutter_application_1/budget.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/form.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text('counter_7'),
            onTap: () {
              Navigator.pop(context);
              // Routing the menu to the main page
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const MyHomePage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Tambah Budget'),
            onTap: () {
              Navigator.pop(context);
              // Routing the menu to the main page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BudgetForm()),
              );
            },
          ),
          ListTile(
            title: const Text('Data Budget'),
            onTap: () {
              Navigator.pop(context);
              // Routing the menu to the main page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Budget()),
              );
            },
          ),
        ],
      ),
    );
  }
}