import 'package:flutter/material.dart';
import 'billing_screen.dart';
import 'saved_bills_screen.dart';
import 'customer_info_screen.dart';
import 'recover_screen.dart';
import 'overdue_screen.dart';
import 'investment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BillingScreen(),
    SavedBillsScreen(),
    CustomerInfoScreen(),
    RecoverScreen(),
    OverdueScreen(),
    InvestmentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved Bills'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.restore), label: 'Recover'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Overdue'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Investment'),
        ],
      ),
    );
  }
}
