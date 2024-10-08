import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/categoryScreen/category_screen.dart';
import 'package:mini_ecommerce/views/customScreen/custom_screen.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Top Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
                onPressed: () {
                  Get.to(CustomScreen(
                    screenName: "categories",
                    isCategoryScreen: true,
                  ));
                },
                child: const Text(
                  "See All",
                  style: TextStyle(color: AppColors.primaryColor),
                ))
          ],
        ),
      ),
      SizedBox(
        height: 64,
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xffe4e4e4),
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          color: const Color(0xffefefef),
                          margin: const EdgeInsets.only(right: 10.00),
                          width: 64,
                          height: 64,
                        );
                      }),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(CategoryScreen(
                              category: snapshot.data!.docs[index],
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 64,
                            padding: const EdgeInsets.all(8.00),
                            decoration: BoxDecoration(
                                color: AppColors.categoryBoxColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.greyColor, width: 1.00)),
                            child: Image.network(
                              snapshot.data!.docs[index]['icon']!,
                            ),
                          ),
                        );
                      }),
                );
              }
            }),
      ),
    ]);
  }
}
