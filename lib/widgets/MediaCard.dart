import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final String posterUrl; // URL or local path to the poster image
  final String title; // Movie title

  const MediaCard({
    super.key,
    required this.posterUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // Fixed width for the card
      height: 325, // Fixed height for the card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Poster Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.network(
              posterUrl,
              width: 180, // Match card width
              height: 270, // Fixed height for the image
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                width: 180,
                height: 270,
                child: Icon(Icons.broken_image, color: Colors.grey[700]),
              ),
            ),
          ),
          const SizedBox(height: 8), // Spacing between image and text
          // Movie Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2, // Limit text to 2 lines
              overflow: TextOverflow.ellipsis, // Handle overflow gracefully
            ),
          ),
        ],
      ),
    );
  }
}
