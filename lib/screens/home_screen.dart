import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index]['show'];
          return ListTile(
            leading: Image.network(movie['image'] != null ? movie['image']['medium'] : 'https://via.placeholder.com/150'),
            title: Text(movie['name']),
            subtitle: Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp('<[^>]*>'), '') : 'No summary available'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie)),
              );
            },
          );
        },
      ),
    );
  }
}
