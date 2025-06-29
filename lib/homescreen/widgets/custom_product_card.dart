import 'package:flutter/material.dart';
import 'package:web_castle/theme/app_colors.dart';

class CustomProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;
  final String actualPrice;
  final String currency;
  final String unit;
  final String offer;

  const CustomProductCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.actualPrice,
    required this.currency,
    required this.unit,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (offer.isNotEmpty)
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    offer,
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.favorite_border,
                  color: AppColors.black,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildSafeImage(imageUrl)),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '$currency $actualPrice',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: '$currency $price',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade400),
                          color: AppColors.white,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'RFQ',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.redaccent,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafeImage(String url) {
    if (url.isEmpty || url.startsWith('assets/')) {
      return Image.asset(
        'assets/images/no_image.jpg',
        height: 100,
        fit: BoxFit.contain,
      );
    }

    return Image.network(
      url,
      height: 100,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/no_image.jpg',
          height: 100,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
