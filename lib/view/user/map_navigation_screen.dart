
import 'package:flutter/material.dart';

class MapNavigationScreen extends StatefulWidget {
  const MapNavigationScreen({super.key});

  @override
  State<MapNavigationScreen> createState() => _MapNavigationScreenState();
}

class _MapNavigationScreenState extends State<MapNavigationScreen> {
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/pic1.jpg',
    'assets/images/pic2.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

        /// todo: will work on them later
        title: const Text("Map & Navigation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _images[_currentIndex],
              width: 300,
              height: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex =
                          (_currentIndex - 1 + _images.length) % _images.length;
                    });
                  },
                  child: const Text('Previous'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = (_currentIndex + 1) % _images.length;
                    });
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
