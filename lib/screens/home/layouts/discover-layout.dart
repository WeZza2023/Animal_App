import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/enum/icons.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class DiscoverLayout extends StatelessWidget {
  const DiscoverLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 50,
                minHeight: 48,
                maxWidth: (AppSizes.getScreenWidth(context) * 0.4) - 54,
                minWidth: (AppSizes.getScreenWidth(context) * 0.3) - 54,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: InkWell(
                  onTap: () {},
                  child: ThemeImageIconWidget(
                    ThemeImageIcon.filter,
                    scale: 2,
                    color: Colors.grey,
                  )),
            ),
            SearchBar(
              constraints: BoxConstraints(
                  maxHeight: 50,
                  minHeight: 48,
                  maxWidth: AppSizes.getScreenWidth(context) * 0.7,
                  minWidth: AppSizes.getScreenWidth(context) * 0.6),
              surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
              shadowColor: const MaterialStatePropertyAll(Colors.grey),
              elevation: const MaterialStatePropertyAll(5),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              hintText: S.of(context).search,
              trailing: [
                IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ).tP16.hP16,
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1.0,
                height: 200,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(seconds: 2),
                aspectRatio: 2.0,
                pauseAutoPlayOnTouch: true,
                scrollPhysics: const ClampingScrollPhysics(),
                onPageChanged: (index, reason) {}),
            items: [Image.asset("assets/images/discount.png")],
          ),
        ).bP8.hP16,
        AppDivider(categoryName: 'عروض اليوم'),
        const DiscoverList().p8,
        AppDivider(categoryName: 'كوبونات'),
        const DiscoverList().p8,


      ],
    );
  }
}

class DiscoverList extends StatelessWidget {
  const DiscoverList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const DiscoverListItem();
        },
      ),
    );
  }
}

class DiscoverListItem extends StatelessWidget {
  const DiscoverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
            )
          ]),
      child: Image.asset("assets/images/discount.png", fit: BoxFit.contain),
    ).p(6)
    ;
  }
}