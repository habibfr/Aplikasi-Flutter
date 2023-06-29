import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final String price;
  final String imageUrl;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 120,
              padding: EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appStyleWithHt(14, Colors.black, FontWeight.w700, 1),
                  ),
                  Text(
                    widget.price,
                    style: appStyle(14, Colors.black, FontWeight.w500),
                  ),
                ],
              ),
            ),
            CachedNetworkImage(
              height: 110,
              // width: ,

              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
