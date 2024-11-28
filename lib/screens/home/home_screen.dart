
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:midterm/services/auth_manager.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Kiểm tra trạng thái login khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.needLogin) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      // Wrap với Consumer
      builder: (context, authProvider, child) {
        final currentUser = authProvider.currentUser;
        final isLoading = authProvider.isLoading;

        return Scaffold(
          body: RefreshIndicator(
              child: Column(
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple[600]!, Colors.purple[300]!],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Profile and points section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentUser?.name ?? 'Guest',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currentUser?.email ?? '',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    (currentUser?.point ?? 0).toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 120,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.85,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                    items: [
                      _buildPromoCard(
                        'Get 20% OFF',
                        'For your first booking',
                        Icons.local_offer,
                        Colors.blue[900]!,
                        Colors.blue[800]!,
                      ),
                      _buildPromoCard(
                        'Special Deal',
                        'Save up to 40% on hotels',
                        Icons.hotel,
                        Colors.purple[900]!,
                        Colors.purple[800]!,
                      ),
                      _buildPromoCard(
                        'Weekend Sale',
                        'Extra 15% off on flights',
                        Icons.flight,
                        Colors.orange[900]!,
                        Colors.orange[800]!,
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  // Services Grid
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(24),
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        _buildServiceItem(
                          context,
                          Icons.flight,
                          'Flights',
                          '/flight_booking',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.place,
                          'Destinations',
                          '/destinations',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.hotel,
                          'Hotels',
                          '/hotels',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.directions_car,
                          'Car Rentals',
                          '/car_rentals',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.train,
                          'Trains',
                          '/trains',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.restaurant,
                          'Culinary',
                          '/culinary',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.security,
                          'Insurance',
                          '/insurance',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.local_offer,
                          'Coupons',
                          '/coupons',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.event,
                          'Events',
                          '/events',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.login_outlined,
                          'Login',
                          '/login',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.app_registration,
                          'Register',
                          '/register',
                        ),
                        _buildServiceItem(
                          context,
                          Icons.logout_outlined,
                          'Logout',
                          '/logout',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onRefresh: () => authProvider.loadUser()),
        );
      },
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    return GestureDetector(
      onTap: () {
        if (route == '/flight_booking') {
          Navigator.pushNamed(context, route);
        } else if (route == '/login' || route == '/register') {
          Navigator.pushNamed(context, route);
        } else if (route == '/logout') {
          AuthManager().logout();
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else {
          // Temporary message for unimplemented features
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label feature coming soon!'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.purple[700],
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPromoCard(
  String title,
  String subtitle,
  IconData icon,
  Color startColor,
  Color endColor,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [startColor, endColor],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    ),
  );
}
