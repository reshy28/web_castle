import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:web_castle/homescreen/controller/homescreen_controller.dart';
import 'package:web_castle/homescreen/model/home_datas_model.dart';
import 'package:web_castle/homescreen/widgets/custom_product_card.dart';
import 'package:web_castle/homescreen/widgets/fade_image_banner.dart';
import 'package:web_castle/theme/app_colors.dart';
import 'package:web_castle/theme/app_text_styles.dart';

class HomescreenView extends StatelessWidget {
  const HomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomescreenController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Welcome, ",
                          style: AppTextStyles.welcome,
                          children: [
                            TextSpan(text: "James!", style: AppTextStyles.name),
                          ],
                        ),
                      ),
                      const Icon(
                        IconlyLight.notification,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              IconlyLight.search,
                              color: AppColors.grey,
                            ),
                            hintText: "Search..",
                            hintStyle: AppTextStyles.welcome,
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Scan Here",
                              style: TextStyle(color: AppColors.white),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.qr_code_scanner, color: AppColors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: homeController.homeFields.map((field) {
              switch (field.type) {
                case 'carousel':
                  return animatedcontainer(field);
                case 'brands':
                  return brandCard(field);
                case 'category':
                  return categories(field);
                case 'rfq':
                  return rfqBanner(field);
                case 'collection':
                  return productsCard(field);
                case 'future-order':
                  return futureorderBanner(field);
                case 'banner-grid':
                  return gridBanner(field);
                case 'banner':
                  return bannerCard(field);
                default:
                  return const SizedBox();
              }
            }).toList(),
          ),
        );
      }),
    );
  }

  Widget animatedcontainer(HomeField field) {
    final images = field.carouselItems
        ?.map((item) => item.image ?? '')
        .where((url) => url.isNotEmpty)
        .toList();

    if (images == null || images.isEmpty) {
      return const SizedBox();
    }

    return FadeImageBanner(images: images);
  }

  Widget brandCard(HomeField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        sectionHeader("Shop By Brands"),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final brand = field.brands?[index];
              return Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: brand?.image != null
                    ? Image.network(brand!.image!, fit: BoxFit.contain)
                    : Center(
                        child: Text(
                          brand?.name ?? '',
                          style: AppTextStyles.welcome,
                        ),
                      ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: field.brands?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Widget categories(HomeField field) {
    final List<Color> bgColors = [
      Colors.yellow.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.pink.shade100,
      Colors.purple.shade100,
      Colors.orange.shade100,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        sectionHeader("Our categories"),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = field.categories?[index];
              final bgColor = bgColors[index % bgColors.length];

              return Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: category?.image != null
                          ? Image.network(
                              category!.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.error),
                            )
                          : const Icon(
                              Icons.category,
                              size: 30,
                              color: AppColors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category?.name ?? '',
                    style: AppTextStyles.welcome.copyWith(fontSize: 12),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: field.categories?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Widget rfqBanner(HomeField field) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: field.image != null
                ? Image.network(
                    field.image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  )
                : Container(
                    width: double.infinity,
                    height: 200,
                    color: AppColors.grey,
                  ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.black.withOpacity(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Request for quote',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Create RFQ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productsCard(HomeField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        sectionHeader(field.name ?? "New Arrivals"),
        const SizedBox(height: 10),
        SizedBox(
          height: 320,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = field.products?[index];
              return CustomProductCard(
                name: product?.name ?? '',
                imageUrl: product?.image ?? 'assets/images/no_image.jpg',
                price: product?.price ?? '0',
                actualPrice: product?.actualPrice ?? '0',
                currency: product?.currency ?? 'AED',
                unit: product?.unit ?? 'per Carton',
                offer: product?.offer ?? '0',
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: field.products?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Widget futureorderBanner(HomeField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          child: field.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    field.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                )
              : Container(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget gridBanner(HomeField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: field.banners?.length ?? 0,
          itemBuilder: (context, index) {
            final banner = field.banners?[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  banner?.image != null
                      ? Image.network(
                          banner!.image!,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        )
                      : Container(color: AppColors.grey),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.black.withOpacity(0.5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      "Shop Now",
                      style: AppTextStyles.sectionSubtitle.copyWith(
                        color: AppColors.white,
                        decorationColor: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget bannerCard(HomeField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: field.banner?.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    field.banner!.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                )
              : Container(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        Text("View All", style: AppTextStyles.sectionSubtitle),
      ],
    );
  }
}
