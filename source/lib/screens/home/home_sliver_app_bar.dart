import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/screens/home/home_swiper.dart';
import 'package:listar_flutter_pro/screens/home/search_bar.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<String>? banners;
  final VoidCallback onSearch;
  final VoidCallback onScan;

  AppBarHomeSliver({
    required this.expandedHeight,
    required this.onSearch,
    required this.onScan,
    this.banners,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        HomeSwipe(
          images: banners,
          height: expandedHeight,
        ),
        Container(
          height: 28,
          color: Theme.of(context).colorScheme.background,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: HomeSearchBar(
            onSearch: onSearch,
            onScan: onScan,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 115;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
