import 'package:e_commerce_application_ui/features/home/screens/widgets/promo_slider.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/widgets/product_card_vertical.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/appbar/home_app_bar_widget.dart';
import '../../../common/widgets/containers/primary_header_container.dart';
import '../../../common/widgets/containers/search_container.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../core/routes/app_pages.dart';
import '../../../provider/product_api_provider.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ProductModel> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductApiProvider().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeAppBarWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SearchContainer(
                    text: 'Search in Store',
                    icon: Iconsax.search_normal4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        const SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: TSizes.spaceBtwItems),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      padding: const EdgeInsets.all(TSizes.sm),
                                      decoration: BoxDecoration(
                                        color:
                                            THelperFunctions.isDarkMode(context)
                                                ? TColors.dark
                                                : TColors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.ice_skating),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwSections / 2,
                                    ),
                                    SizedBox(
                                      width: 55,
                                      child: Text(
                                        "Shoes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(color: TColors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(
                    banners: [
                      TImages.banner2,
                      TImages.banner1,
                      TImages.promoBanner1,
                      TImages.banner5
                    ],
                  ),
                  SectionHeading(
                    title: 'Products',
                    showActionButton: true,
                    buttonTitle: "view all",
                    onPressed: () {
                      Get.toNamed(Routes.allProductScreen);
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  FutureBuilder<ProductModel>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data?.content == null ||
                          snapshot.data!.content!.isEmpty) {
                        return const Center(
                            child: Text('No products available'));
                      }

                      final products = snapshot.data!.content!;
                      const int crossAxisCount = 2;
                      const double childAspectRatio = 0.58;
                      const double itemHeight =
                          280; // Adjust based on ProductCardVertical's design.
                      const double itemSpacing = 10.0;

                      // Calculate grid height dynamically
                      int rowCount = (2 / crossAxisCount).ceil();
                      double gridHeight = (rowCount * itemHeight) +
                          ((rowCount - 1) * itemSpacing);

                      return SizedBox(
                        height: gridHeight, // Dynamically calculate height
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: itemSpacing,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCardVertical(
                              product:
                                  product, // Pass single product to ProductCardVertical
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
