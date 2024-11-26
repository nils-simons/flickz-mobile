import 'dart:convert';
import 'package:flickz/pages/home/widgets/TrendingsResults.dart';
import 'package:flickz/widgets/MediaGrid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchResults extends StatefulWidget {
  final String query;

  const SearchResults({super.key, required this.query});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String? errorMessage; // To store the error message
  String server = '';
  List<Movie>? movies;

  @override
  void initState() {
    super.initState();
    fetchSearchResults(widget.query); // Fetch results when widget is first created
  }

  @override
  void didUpdateWidget(covariant SearchResults oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      fetchSearchResults(widget.query); // Re-fetch if the query changes
    }
  }

  Future<void> fetchSearchResults(String query) async {
    setState(() {
      errorMessage = null; // Reset the error message when a new query is made
      movies = null; // Clear previous results
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      server = prefs.getString('server') ?? '';

      if (server.isEmpty) {
        throw Exception('Server setting is not configured. Please set it in the settings.');
      }

      Uri url = Uri.parse("${server}api/search/${Uri.encodeQueryComponent(query)}");

      final response = await http.get(url).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('The request timed out. Please try again.');
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> moviesJson = jsonResponse['data'];
        setState(() {
          movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
          errorMessage = null; // Clear any previous error
        });
      } else {
        throw Exception('Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
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
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (movies == null) {
      // While the data is being fetched, show a loading indicator
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Once data is available, render the MediaCardGrid
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Results",
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
