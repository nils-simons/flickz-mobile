import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                const SearchInput(),
                const Trendings(),
                MovieGridScreen(),
              ],
            )));
  }
}

class Trendings extends StatefulWidget {
  const Trendings({super.key});

  @override
  State<Trendings> createState() => _TrendingsState();
}

class _TrendingsState extends State<Trendings> {
  @override
  Widget build(BuildContext context) {
    return const Text('Trendings');
  }
}

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const TextField(
        decoration: InputDecoration(
          labelText: 'Harry Potter, Peaky Blinders, ...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class MovieGridScreen extends StatelessWidget {
  // Dummy data for movies
  final List<Map<String, String>> movies = [
    {
      'title': 'Inception',
      'poster':
          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/9BfRw1fzFreEbRaGTCNtvR9jyOT.jpg',
    }
  ];

  const MovieGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              title: movie['title']!,
              posterUrl: movie['poster']!,
            );
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String posterUrl;

  const MovieCard({super.key, required this.title, required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              posterUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
