import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_fix/feature/api/url.dart';
import 'package:travel_app_fix/feature/destination/presentation/widget/circle_loading.dart';

class GalleryPhoto extends StatelessWidget {
  const GalleryPhoto({super.key, required this.image});

  final List<String> image;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Stack(
      children: [
        PhotoViewGallery.builder(
            pageController: pageController,
            itemCount: image.length,
            scrollPhysics: const BouncingScrollPhysics(),
            loadingBuilder: (context, event) {
              return const CircleLoading();
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider:
                      ExtendedNetworkImageProvider(URLs.image(image[index])),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: image[index]));
            }),
        Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: image.length,
                effect: WormEffect(
                    dotColor: Colors.grey[300]!,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotHeight: 10,
                    dotWidth: 10),
              ),
            )),
        const Align(alignment: Alignment.topRight, child: CloseButton())
      ],
    );
  }
}
