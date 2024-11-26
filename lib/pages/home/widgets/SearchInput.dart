import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSearch;

  const SearchInput({super.key, required this.onSearch});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted(String value) {
    widget.onSearch(value); // Call the callback with the search input
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onSubmitted: _handleSubmitted, // Trigger search on enter
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.black45),
          labelText: 'Harry Potter, Peaky Blinders, ...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 2.0),
          ),
        ),
        cursorColor: Colors.black45,
      ),
    );
  }
}
