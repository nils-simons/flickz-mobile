import 'package:flickz/pages/media/media.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaPage(
              posterUrl: posterUrl,
              title: title,
            ),
          ),
        );
      },
      child: Container(
        width: 160, // Fixed width for the card
        height: 270, // Fixed height for the card
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
              child: _buildPosterImage(),
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
                maxLines: 1, // Limit text to 1 line
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    try {
      return Image.network(
        posterUrl,
        width: 190, // Match card width
        height: 280, // Fixed height for the image
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint(
              'Image load failed: $error'); // Log the error for debugging
          return Container(
            color: Colors.grey[300],
            width: 190,
            height: 280,
            child: Icon(Icons.broken_image, color: Colors.grey[700]),
          );
        },
      );
    } catch (e) {
      debugPrint('Unexpected error while loading image: $e');
      return Container(
        color: Colors.grey[300],
        width: 190,
        height: 280,
        child: Icon(Icons.error, color: Colors.grey[700]),
      );
    }
  }
}

