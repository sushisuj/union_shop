import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final VoidCallback? onSearchTap;
  const FooterWidget({Key? key, this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opening Times (Left)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Opening Times',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Mon-Fri: 9am - 5pm', style: TextStyle(color: Colors.grey)),
              Text('Sat: 10am - 4pm', style: TextStyle(color: Colors.grey)),
              Text('Sun: Closed', style: TextStyle(color: Colors.grey)),
            ],
          ),
          Expanded(child: Container()),
          // Email subscribe box (center)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Latest Offers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(4)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(4)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                        ),
                        onPressed: () {
                          // TODO: handle subscribe action
                        },
                        child: const Text(
                          'SUBSCRIBE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          // Help and Information (Right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Help and Information',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onSearchTap,
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              _FooterLink(text: 'Terms and Conditions'),
              _FooterLink(text: 'Contact Us'),
              _FooterLink(text: 'FAQ'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation for footer links
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
