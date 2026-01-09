import 'package:flutter/material.dart';

class ContributorsScreen extends StatelessWidget {
  const ContributorsScreen({super.key});

  static const _contributors = [
    {
      'name': 'Prof. Chintolla Surekha',
      'title': 'Professor of Machine Learning',
      'affiliation': 'Department of CSE - AIML/ HITAM, Hyderabad, India',
      'experience': '17+ years in academia and research',
      'email': 'surekha.cse@hitam.org',
      'contact': '+91 9912618628',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contributors'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Professors who contributed to this knowledge base. ',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ..._contributors.map(_ContributorCard.new),
        ],
      ),
    );
  }
}

class _ContributorCard extends StatelessWidget {
  final Map<String, String> data;
  const _ContributorCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['name'] ?? 'Name',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(data['title'] ?? ''),
            Text(
              data['affiliation'] ?? '',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    data['experience'] ?? '',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.blueGrey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    data['email'] ?? 'Add email',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone_in_talk_outlined, size: 16, color: Colors.blueGrey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    data['contact'] ?? 'Add contact info (phone/office hours)',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          
          ],
        ),
      ),
    );
  }
}
