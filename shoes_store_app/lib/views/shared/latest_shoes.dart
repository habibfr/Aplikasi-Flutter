import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoes_store_app/views/shared/stagger_tile.dart';

import '../../models/sneaker_model.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> shoes,
  }) : _shoes = shoes;

  final Future<List<Sneakers>> _shoes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _shoes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // print(snapshot.error);
          return Text("Error ${snapshot.error}");
        } else {
          // final male = snapshot.data;
          return FutureBuilder<List<Sneakers>>(
            future: _shoes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final shoes = snapshot.data;
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  scrollDirection: Axis.vertical,
                  itemCount: shoes!.length,
                  staggeredTileBuilder: (index) => StaggeredTile.extent(
                      (index % 2 == 0) ? 1 : 1,
                      (index % 4 == 3)
                          ? MediaQuery.of(context).size.height * 0.35
                          : MediaQuery.of(context).size.height * 0.3),
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return StaggerTile(
                      price: "\$${shoe.price}",
                      name: shoe.name,
                      imageUrl: shoe.imageUrl[0],
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
