import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:giphy/controllers/landing_controller.dart';
import 'package:giphy/models/gif_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridViewWidget extends StatelessWidget {
  List<GifModel> data;
  bool isLogin;
  bool isLanding;
  final LandingController controller;

  GridViewWidget({super.key, required this.data, required this.isLogin, required this.isLanding, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        String id = '';
        bool isFav = controller.favGif.any(
          (element) => element.url == data[index].url,
        );
        if (isFav) {
          id = controller.favGif
              .where(
                (element) => element.url == data[index].url,
              )
              .first
              .id;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: data[index].url ?? '',
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                if (isLogin)
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () async {
                            if (isLanding && !isFav) {
                              await controller.saveFav(data[index].url ?? '');
                              controller.fetchFavGifs();
                            } else {
                              await controller.deleteFav(isLanding ? id : data[index].id ?? '', data[index].url ?? '');
                              controller.fetchFavGifs();
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.heart_fill,
                            color: isLanding == false || isFav ? Colors.red : null,
                          )))
              ],
            ),
          ),
        );
      },
    );
  }
}
