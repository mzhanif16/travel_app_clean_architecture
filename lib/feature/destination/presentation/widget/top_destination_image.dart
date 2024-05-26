import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_fix/feature/destination/presentation/widget/parallax_horiz_delegate.dart';
import 'circle_loading.dart';

class TopDestinationImage extends StatelessWidget {
  TopDestinationImage({super.key, required this.url});

  final String url;
  final imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: ParallaxHorizDelegate(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          backgroundImageKey: imageKey
      ),
      children: [
        ExtendedImage.network(
          key: imageKey,
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          handleLoadingProgress: true,
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.failed) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.black,
                  ),
                ),
              );
            }
            if (state.extendedImageLoadState == LoadState.loading) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                  child: const CircleLoading(),
                ),
              );
            }
            return null;
          },
        ),
      ],
    );
  }
}
