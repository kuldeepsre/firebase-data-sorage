import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Map<String, dynamic>> stats = [
    {
      "title": "Revenue",
      "value": "\$12.5K",
      "icon": Icons.attach_money,
      "color": Colors.green,
    },
    {
      "title": "Orders",
      "value": "245",
      "icon": Icons.shopping_cart,
      "color": Colors.orange,
    },
    {
      "title": "Customers",
      "value": "1.4K",
      "icon": Icons.people,
      "color": Colors.blue,
    },
    {
      "title": "Products",
      "value": "120",
      "icon": Icons.inventory,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "title": "New Order Received",
      "subtitle": "Order #1203",
      "time": "2 min ago",
    },
    {
      "title": "Payment Successful",
      "subtitle": "₹12,000 received",
      "time": "10 min ago",
    },
    {
      "title": "New Customer Added",
      "subtitle": "Rahul Sharma",
      "time": "1 hour ago",
    },
  ];
}