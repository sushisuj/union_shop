import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'About us',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to the Union Shop!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'All online purchases are available for delivery or instore collection!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Happy shopping!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'The Union Shop & Reception Team',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
