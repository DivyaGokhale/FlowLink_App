import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.green),
                  SizedBox(width: 6),
                  Text('Ratnagiri, Maharashtra', style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black87),
          SizedBox(width: 12),
          Icon(Icons.chat_bubble_outline, color: Colors.black87),
          SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Hello, Divya! 👋', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          const Text(
            'Fulfill all your daily needs\nwith HarvestHub',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _promoBanner(),
          const SizedBox(height: 16),
          _sectionHeader('Popular Store', action: 'See All'),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _storeCard(index),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: 5,
            ),
          ),
          const SizedBox(height: 16),
          _sectionHeader('Categories', action: 'See All'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(6, (i) => _categoryChip('Category ${i + 1}')),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/location');
            return;
          }
          if (index == 4) {
            Navigator.pushReplacementNamed(context, '/setting');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.send_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _promoBanner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE7F5E8),
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner_placeholder.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white70, BlendMode.srcATop),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Delivery within  in 25 min', style: TextStyle(color: Colors.black87)),
          ),
          const Spacer(),
          const Text(
            'Get free shipping\nand 25% discount\nfor today only',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        if (action != null) Text(action, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _storeCard(int index) {
    final storeNames = [
      'Amar Fresh Mart',
      'Namaste Grocers',
      'Apna Bazaar',
      'Desi Fresh Corner',
      'Bharat Kirana Store',
    ];
    final storeCities = [
      'Ratnagiri, Maharashtra',
      'Pune, Maharashtra',
      'Mumbai, Maharashtra',
      'Bengaluru, Karnataka',
      'Hyderabad, Telangana',
    ];
    final name = storeNames[index % storeNames.length];
    final city = storeCities[index % storeCities.length];

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(color: Colors.grey[300]),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(city, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: const Color(0xFFF3F5F7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
