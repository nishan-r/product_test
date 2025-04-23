import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_test/utils/common_widgets/common_button.dart';
import 'package:product_test/utils/constants/app_colors.dart';
import 'package:product_test/utils/constants/app_spaces.dart';
import '../model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productData});

  final Product productData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ColoredBox(
                color: AppColors.containerBg,
                child: CachedNetworkImage(
                  imageUrl: productData.images?.first ?? '',
                  height: size.height * .5,
                  width: size.width,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: AspectRatio(
                                aspectRatio: 1, child: Icon(Icons.arrow_back))),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Icon(Icons.favorite_border_rounded))),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text((productData.brand ?? '').toUpperCase()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      cmWidth05,
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: productData.rating.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          TextSpan(
                              text: ' (${productData.reviews?.length ?? 0})',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ]),
                      )
                    ],
                  ),
                  Text(
                    productData.title ?? '',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category : ${productData.category ?? ''}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      Text(
                        '₹ ${productData.price ?? 0}',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                  cmHeight15,
                  Text(
                    'Product Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    productData.description ?? '',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  CommonButton(title: 'Add to Cart', onTap: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
