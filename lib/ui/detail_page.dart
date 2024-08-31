import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Restaurant? restaurant;
  const DetailPage({super.key, this.restaurant});

  static const routeName = '/detail_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: restaurant != null
          ? _buildData(context)
          : Center(
              child: Text(
                "no restaurant data",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
    );
  }

  Widget _buildData(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
              tag: restaurant?.pictureId ?? "",
              child: Image.network(restaurant?.pictureId ?? "")),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        restaurant?.name ?? "",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 28,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          (restaurant?.rating ?? 0).toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      restaurant?.city ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  restaurant?.description ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Text(
                  "Foods",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                _buildMenuList(restaurant?.menus?.foods ?? []),
                const SizedBox(height: 16),
                Text(
                  "Drinks",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                _buildMenuList(restaurant?.menus?.drinks ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(List<Drink> menus) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menu = menus[index];

          return SizedBox(
            width: 150,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(menu.name ?? ""),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
