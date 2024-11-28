import 'package:flutter/material.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY ORDERS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple[600]!, Colors.purple[300]!],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHistoryItem(
            'Flight Booking',
            'Complete payment',
            'assets/images/travelling.png',
            Colors.blue[100]!,
            '-\$24,000.00',
            'Complete',
          ),
          _buildHistoryItem(
            'Culinary Booking',
            'Point',
            'assets/images/salad.png',
            Colors.orange[100]!,
            '-500 Points',
            'Complete',
          ),
          _buildHistoryItem(
            'Train Booking',
            'Complete payment',
            'assets/images/train-station.png',
            Colors.green[100]!,
            '-\$900.00',
            'Complete',
          ),
          _buildHistoryItem(
            'Train Booking',
            'Complete payment',
            'assets/images/train-station.png',
            Colors.red[100]!,
            '-\$232.00',
            'Failed',
          ),
          _buildHistoryItem(
            'Culinary Booking',
            'Point',
            'assets/images/salad.png',
            Colors.red[100]!,
            '-100 Points',
            'Failed',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.white,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.orange : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    String title,
    String subtitle,
    String imagePath,
    Color bgColor,
    String amount,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIcon(title),
              // color: bgColor.withBlue(255),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == 'Complete' ? Colors.green : Colors.orange,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    switch (title) {
      case 'Flight Booking':
        return Icons.flight;
      case 'Culinary Booking':
        return Icons.restaurant;
      case 'Train Booking':
        return Icons.train;
      case 'Car Rentals Booking':
        return Icons.directions_car;
      case 'Events':
        return Icons.event;
      default:
        return Icons.bookmark;
    }
  }
}
