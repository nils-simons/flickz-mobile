import 'dart:convert';
import 'package:flickz/widgets/MediaGrid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Assuming Movie and MediaCardGrid are defined elsewhere
class Trendings extends StatefulWidget {
  const Trendings({super.key});

  @override
  State<Trendings> createState() => _TrendingsState();
}

class _TrendingsState extends State<Trendings> {
  String? errorMessage; // To store the error message
  String server = '';
  List<Movie>? movies;

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
  }

  Future<void> fetchTrendingMovies() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      server = prefs.getString('server') ?? '';

      if (server.isEmpty) {
        throw Exception(
            'Server setting is not configured. Please set it in the settings.');
      }

      Uri url;
      try {
        // Validate the server URL
        url = Uri.parse("${server}api/trending");
        if (!url.hasScheme || !url.hasAuthority) {
          throw const FormatException('Invalid server URL format.');
        }
      } catch (e) {
        throw Exception('Invalid server URL. Please check your settings.');
      }

      // Attempt to make the HTTP request
      final response = await http.get(url).timeout(const Duration(seconds: 10),
          onTimeout: () =>
              throw Exception('The request timed out. Please try again.'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> moviesJson = jsonResponse['data'];
        setState(() {
          movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
          errorMessage = null; // Clear any previous error
        });
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle all errors and update the error message
      setState(() {
        errorMessage = e.toString();
        movies = null; // Clear movies if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (movies == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align children to the start (left)
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0), // Add spacing around the headline
          child: Text(
            'Trending',
            textAlign: TextAlign.left, // Ensures alignment for the text
            style: TextStyle(
              color: Colors.black,
              fontSize: 24, // Increase font size for headline
              fontWeight: FontWeight.bold, // Make the headline bold
            ),
          ),
        ),
        Expanded(
          child: MediaCardGrid(mediaItems: movies!),
        ),
      ],
    );
  }
}

class Movie {
  final String posterPath;
  final String title;

  Movie({
    required this.posterPath,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      posterPath: (json['poster_path'] as String?) != null
          ? "https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['poster_path']}"
          : "https://i.imgur.com/BMVi39d.png", // Default URL or placeholder
      title: (json['title'] as String?) ??
          (json['name'] as String?) ??
          'Unknown Title',
    );
  }
}