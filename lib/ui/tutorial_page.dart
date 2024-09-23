import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _instructions = [
      {
        'title': 'Fokus pada Area Kulit yang Relevan',
        'correctImage': 'assets/images/4_1.jpg',
        'incorrectImage': 'assets/images/4_2.jpg',
      },
      {
        'title': 'Ambil Gambar dengan Jarak yang Tepat',
        'correctImage': 'assets/images/6_1.jpg',
        'incorrectImage': 'assets/images/6_2.jpg',
      },
      {
        'title': 'Hindari Berada di depan Sumber Cahaya',
        'correctImage': 'assets/images/3_1.jpg',
        'incorrectImage': 'assets/images/3_2.jpg',
      },
      {
        'title': 'Hindari Cahaya yang Terlalu Terang',
        'correctImage': 'assets/images/2_1.jpg',
        'incorrectImage': 'assets/images/2_2.jpg',
      },
      {
        'title': 'Jangan Terlalu Gelap',
        'correctImage': 'assets/images/1_1.jpg',
        'incorrectImage': 'assets/images/1_2.jpg',
      },
      {
        'title': 'Jangan Menutupi Area Kulit',
        'correctImage': 'assets/images/5_1.jpg',
        'incorrectImage': 'assets/images/5_2.jpg',
      },
      {
        'title': 'Pastikan Gambar Tampak jelas',
        'correctImage': 'assets/images/7_1.jpg',
        'incorrectImage': 'assets/images/7_2.jpg',
      },
      {
        'title': 'Jangan Gunakan Filter atau Efek Kamera',
        'correctImage': 'assets/images/8_1.jpg',
        'incorrectImage': 'assets/images/8_2.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panduan',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: false,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _instructions.length,
          itemBuilder: (context, index) {
            final instruction = _instructions[index];
            return _buildInstructionSection(
              context,
              title: instruction['title']!,
              correctImage: instruction['correctImage']!,
              incorrectImage: instruction['incorrectImage']!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructionSection(BuildContext context,
      {required String title,
      required String correctImage,
      required String incorrectImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    correctImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      SizedBox(width: 4),
                      Text('Benar'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    incorrectImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      SizedBox(width: 4),
                      Text('Salah'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
