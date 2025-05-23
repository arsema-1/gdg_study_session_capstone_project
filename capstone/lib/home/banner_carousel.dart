import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // ✅ Import for Poppins

class BannerCarousel extends StatefulWidget {
  final Color accentColor;
  const BannerCarousel({super.key, required this.accentColor});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final List<Map<String, dynamic>> _banners = [
    {
      'title': "Winter Sale",
      'subtitle': "20% Off",
      'description': "For Children",
      'color': Color(0xFF6C63FF),
      'image': "assets/images/kid.png",
    },
    {
      'title': "New Arrivals",
      'subtitle': "Latest Trends",
      'description': "Shop Now",
      'color': Color.fromARGB(255, 108, 94, 35),
      'image': "assets/images/new_arrival.png",
    },
    {
      'title': "Limited Time",
      'subtitle': "50% Off",
      'description': "Selected Items",
      'color': Color.fromARGB(255, 156, 79, 79),
      'image': "assets/images/limited_offer.png",
    },
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _carouselTimer;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoCarousel();
  }

  void _startAutoCarousel() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;

      if (_currentIndex == _banners.length - 1) {
        _isForward = false;
      } else if (_currentIndex == 0) {
        _isForward = true;
      }

      final nextIndex = _isForward ? _currentIndex + 1 : _currentIndex - 1;

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: banner['color'],
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(banner['image']),
                    alignment: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banner['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner['subtitle'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner['description'],
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => Container(
              width: 11,
              height: 11,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    index == _currentIndex
                        ? widget.accentColor
                        : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
