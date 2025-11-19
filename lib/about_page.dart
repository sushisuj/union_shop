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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Union Shop!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Union Shop is your one-stop destination for all your shopping needs. We offer a wide range of products, from electronics to fashion, all at competitive prices.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Our mission is to provide our customers with the best shopping experience possible. We are committed to quality, affordability, and excellent customer service.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Thank you for choosing Union Shop. We look forward to serving you!',
            ),
          ],
        ),
      ),
    );
  }
}
