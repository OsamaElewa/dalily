import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context), // اضغط ع الصورة أو الشاشة للخروج
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: InteractiveViewer( // بيسمح بالتكبير باللمس (pinch zoom)
            child: Image.network(imagePath),
          ),
        ),
      ),
    );
  }
}