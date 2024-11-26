import 'package:flickz/pages/home/widgets/SearchInput.dart';
import 'package:flickz/pages/home/widgets/SearchResults.dart';
import 'package:flickz/pages/home/widgets/TrendingsResults.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = "";

  void onSearch(String searchQuery) {
    setState(() {
      query = searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            SearchInput(
              onSearch: onSearch,
            ),
            Expanded(
              child: query.isEmpty
                  ? const Trendings()
                  : SearchResults(query: query),
            ),
          ],
        ),
      ),
    );
  }
}
