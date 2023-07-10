import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.imageURL});
  final imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image View", style: TextStyle(color: Colors.white),), centerTitle: true,),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageURL,
          placeholder: (context, url) => const Center(
              child: CircularProgressIndicator()),
          key: UniqueKey(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
