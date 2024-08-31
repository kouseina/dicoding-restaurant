import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/ui/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(),
                  title: const Text('Restaurant'),
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                ),
              )
            ];
          },
          body: _buildList(context),
        ),
      ),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurants(snapshot.data);

        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurants[index]);
          },
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId ?? "",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              restaurant.pictureId ?? "",
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          restaurant.name ?? "",
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                ),
                const SizedBox(width: 2),
                Text(restaurant.city ?? ""),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 16,
                ),
                const SizedBox(width: 2),
                Text((restaurant.rating ?? 0).toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailPage.routeName,
            arguments: restaurant,
          );
        },
      ),
    );
  }
}
