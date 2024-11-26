import 'package:flickz/pages/home/widgets/TrendingsResults.dart';
import 'package:flickz/widgets/MediaCard.dart';
import 'package:flutter/material.dart';

class MediaCardGrid extends StatelessWidget {
  // Change the mediaItems to accept a List<Movie> instead of List<Map<String, String>>
  final List<Movie> mediaItems;

  const MediaCardGrid({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 8.0, // Horizontal spacing
          mainAxisSpacing: 8.0, // Vertical spacing
          childAspectRatio:
              160 / 270, // Aspect ratio based on MediaCard dimensions
        ),
        itemCount: mediaItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = mediaItems[index];
          return MediaCard(
            posterUrl: item.posterPath,
            title: item.title,
          );
        },
      ),
    );
  }
}
