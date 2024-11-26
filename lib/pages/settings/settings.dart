import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _serverController;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController
    _serverController = TextEditingController();
    // Load settings after initialization
    _loadSettings();
  }

  @override
  void dispose() {
    _serverController
        .dispose(); // Clean up the controller when the widget is removed
    super.dispose();
  }

  // Load saved settings
  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Safely set the text after initialization
    setState(() {
      _serverController.text = prefs.getString('server') ?? '';
    });
  }

  // Save settings
  Future<void> _saveSettings(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('server', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Flickz server'),
              controller: _serverController,
              onChanged: (value) {
                _saveSettings(value); // Save the setting when it changes
              },
            ),
          ],
        ),
      ),
    );
  }
}
