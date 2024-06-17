import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/result.dart';
import 'package:flutter_sandbox/utils/ml.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language Identifier")),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Enter text to identify language",
              ),
            ),
            // TODO: Consider using Gap instead of SizedBox
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final helper = MlHelper();
                final result = await helper.identifyLanguage(_controller.text);

                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => ResultScreen(result),
                  ),
                );
              },
              child: const Text("Identify Language"),
            ),
          ],
        ),
      ),
    );
  }
}
