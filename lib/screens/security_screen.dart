import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool faceId = true;
  bool rememberPassword = true;
  bool touchId = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Security',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(color: const Color(0xFFF1F1F1)),
              ),
              child: Column(
                children: [
                  _switchTile(
                    title: 'Face ID',
                    value: faceId,
                    onChanged: (v) => setState(() => faceId = v),
                  ),
                  const Divider(height: 0),
                  _switchTile(
                    title: 'Remember Password',
                    value: rememberPassword,
                    onChanged: (v) => setState(() => rememberPassword = v),
                  ),
                  const Divider(height: 0),
                  _switchTile(
                    title: 'Touch ID',
                    value: touchId,
                    onChanged: (v) => setState(() => touchId = v),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: Switch(
        value: value,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF4CAF50),
        onChanged: onChanged,
      ),
    );
  }
}
