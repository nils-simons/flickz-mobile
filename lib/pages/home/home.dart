import 'package:flickz/pages/home/widgets/SearchInput.dart';
import 'package:flickz/widgets/MediaCard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: EdgeInsets.all(6.0),
            child: Column(
              children: [
                SearchInput(),
                Center(
                    child: MediaCard(
                        posterUrl:
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2/9BfRw1fzFreEbRaGTCNtvR9jyOT.jpg',
                        title:
                            'Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 Smile 2 '))
              ],
            )));
  }
}
