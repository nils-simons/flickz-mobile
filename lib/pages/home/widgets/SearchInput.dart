import 'package:flutter/material.dart';

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
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 2.0),
            )),
      ),
    );
  }
}
