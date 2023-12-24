import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/image7.jpg',
    'assets/images/image8.jpg',
    'assets/images/image9.jpg',
    'assets/images/image10.jpg',
    'assets/images/image11.jpg',
    'assets/images/image12.jpg',
    'assets/images/image13.jpg',
    'assets/images/image14.jpg',

  ];

  final List<String> imageDescriptions = [
    'Description 1',
    'Description 2',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
    'Description 3',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: imagePaths.asMap().entries.map((entry) {
          return ImageClickableResizable(
            imagePath: entry.value,
            imageDescription: imageDescriptions[entry.key],
          );
        }).toList(),
      ),
    );
  }
}

class ImageClickableResizable extends StatelessWidget {
  final String imagePath;
  final String imageDescription;

  const ImageClickableResizable({
    required this.imagePath,
    required this.imageDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ImageFilteredView(
                    imagePath: imagePath, imageDescription: imageDescription),
              ),
            );
          },
        );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 200,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageFilteredView extends StatelessWidget {
  final String imagePath;
  final String imageDescription;

  const ImageFilteredView({
    required this.imagePath,
    required this.imageDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        Text(imageDescription), // عرض وصف الصورة
      ],
    );
  }
}
