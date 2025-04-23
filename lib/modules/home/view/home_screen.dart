import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_test/modules/authentication/view/widgets/common_textfield.dart';
import 'package:product_test/modules/home/view/product_detail_screen.dart';
import 'package:product_test/utils/constants/app_colors.dart';
import 'package:product_test/utils/constants/app_spaces.dart';
import '../../profile/view/profile_screen.dart';
import '../controller/home_controller.dart';
import 'widgets/filter_sheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController searchTextCtr = TextEditingController();
  final HomeController homeController = Get.put(HomeController());


  _clearTextFields(){
    searchTextCtr.clear();
    homeController.fetchProducts();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
                child: CircleAvatar(
                  child: Icon(Icons.person),
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Obx(() => homeController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: CommonTextField(
                                    controller: searchTextCtr,
                                    hint: 'Search...')),
                            cmWidth10,
                            AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                onTap: () {
                                  homeController
                                      .searchProducts(searchTextCtr.text);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primary,
                                    ),
                                    child: Icon(Icons.search,
                                        color: Colors.white)),
                              ),
                            ),
                            cmWidth10,
                            AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    builder: (context) => CustomFilterSheet(
                                      homeController: homeController,
                                    ),
                                  );
                                  _clearTextFields();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primary,
                                    ),
                                    child: Icon(Icons.filter_alt_outlined,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                      cmHeight10,

                      homeController.filteredProducts.isEmpty ? 
                      Center(child: Text('No Items Found'),):

                      GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 250),
                        itemCount: homeController.filteredProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = homeController.filteredProducts[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => ProductDetailScreen(productData: item));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.containerBg,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: item.thumbnail ?? '',
                                    height: 150,
                                  ),
                                  Text(
                                    item.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '₹ ${item.price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(item.rating.toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )));
  }
}
