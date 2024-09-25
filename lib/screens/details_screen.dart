import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['original'])
                : Image.network('https://via.placeholder.com/300'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp('<[^>]*>'), '') : 'No summary available'),
            ),
          ],
        ),
      ),
    );
  }
}
