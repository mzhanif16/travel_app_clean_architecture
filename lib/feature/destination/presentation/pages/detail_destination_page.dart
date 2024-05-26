import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:travel_app_fix/feature/destination/domain/entities/destination_entity.dart';
import 'package:travel_app_fix/feature/destination/presentation/widget/gallery_photo.dart';

import '../../../api/url.dart';
import '../widget/circle_loading.dart';

class DetailDestinationPage extends StatefulWidget {
  const DetailDestinationPage({super.key, required this.destinationEntity});

  final DestinationEntity destinationEntity;

  @override
  State<DetailDestinationPage> createState() => _DetailDestinationPageState();
}

class _DetailDestinationPageState extends State<DetailDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(height: 10),
          gallery(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [location(), const SizedBox(height: 4), category()],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [rate(), const SizedBox(height: 4), count()],
              ),
            ],
          ),
          const SizedBox(height: 24),
          facilities(),
          const SizedBox(height: 24),
          details(),
          const SizedBox(height: 24),
          review(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        widget.destinationEntity.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        alignment: Alignment.centerLeft,
        margin:
            EdgeInsets.only(left: 20, top: MediaQuery.of(context).padding.top),
        child: const Row(
          children: [BackButton()],
        ),
      ),
    );
  }

  Widget gallery() {
    List patternGallery = [
      const StaggeredTile.count(3, 3),
      const StaggeredTile.count(2, 1.5),
      const StaggeredTile.count(2, 1.5),
    ];
    return StaggeredGridView.countBuilder(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        staggeredTileBuilder: (index) {
          return patternGallery[index % patternGallery.length];
        },
        itemBuilder: (context, index) {
          if (index == 2) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        GalleryPhoto(image: widget.destinationEntity.images));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    itemGalleryImage(index),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: const Text(
                        '+More',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: itemGalleryImage(index));
        });
  }

  Widget itemGalleryImage(int index) {
    return ExtendedImage.network(
      URLs.image(widget.destinationEntity.images[index]),
      fit: BoxFit.cover,
      width: 100,
      height: 100,
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
    );
  }

  Widget location() {
    return Row(
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Icon(Icons.location_on,
              color: Theme.of(context).primaryColor, size: 15),
        ),
        const SizedBox(width: 4),
        Text(
          widget.destinationEntity.location,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget category() {
    return Row(
      children: [
        SizedBox(
          height: 15,
          width: 15,
          child: Icon(Icons.fiber_manual_record,
              color: Theme.of(context).primaryColor, size: 10),
        ),
        const SizedBox(width: 4),
        Text(
          widget.destinationEntity.category,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget rate() {
    return RatingBar.builder(
      initialRating: widget.destinationEntity.rate,
      unratedColor: Colors.grey,
      allowHalfRating: true,
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (value) {},
      itemSize: 15,
      ignoreGestures: true,
    );
  }

  Widget count() {
    return Row(
      children: [
        Text(
          '${DMethod.numberAutoDigit(widget.destinationEntity.rate)} / ${NumberFormat.compact().format(widget.destinationEntity.rateCount)} reviews',
          style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  facilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Facilities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...widget.destinationEntity.facilities.map((facility) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.radio_button_checked,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(facility,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
              ],
            ),
          );
        })
      ],
    );
  }

  details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          widget.destinationEntity.description,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  review() {
    List list = [
      [
        'Jhon Dipsy',
        'assets/images/p1.jpg',
        4.9,
        'Best place',
        '2023-01-02',
      ],
      [
        'Mikael Lunch',
        'assets/images/p2.jpg',
        4.3,
        'Unforgettable',
        '2023-03-21',
      ],
      [
        'Dinner Sopi',
        'assets/images/p3.jpg',
        5,
        'Nice one',
        '2023-09-02',
      ],
      [
        'Loro Sepuh',
        'assets/images/p4.jpg',
        4.5,
        'You should go with your family',
        '2023-09-24',
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...list.map((e) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(e[1]),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            e[0],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          RatingBar.builder(
                            initialRating: e[2].toDouble(),
                            unratedColor: Colors.grey,
                            allowHalfRating: true,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (value) {},
                            itemSize: 15,
                            ignoreGestures: true,
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('d MMM').format(DateTime.parse(e[4])),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        e[3],
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList()
      ],
    );
  }
}
