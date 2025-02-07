import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';


class ImageListView extends StatelessWidget {
  final List<String> imageUrls;
  const ImageListView({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
          );
        },
      ),
    );
  }
}


class ImageView extends StatelessWidget {
  final String url;
  const ImageView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}