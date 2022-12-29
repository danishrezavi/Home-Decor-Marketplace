import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/controllers/profile_controller.dart';
import 'package:shop_app/screens/profile/components/details_cart.dart';
import 'package:shop_app/screens/profile/components/edit_profile.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/services/firestore_services.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return Column(
              children: [
                const ProfilePic(),
                const SizedBox(height: 10),
                "${data['name']}".text.fontFamily(semibold).black.make(),
                "${data['email']}".text.black.make(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(
                        count: "${data['cart_count']}",
                        title: "Your cart",
                        width: context.screenWidth / 3.3),
                    detailsCard(
                        count: "${data['wishlist_count']}",
                        title: "Your Wishlist",
                        width: context.screenWidth / 3.3),
                    detailsCard(
                        count: "${data['order_count']}",
                        title: "Your Orders",
                        width: context.screenWidth / 3.3),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {},
                ),
                ProfileMenu(
                  text: "Notifications",
                  icon: "assets/icons/Bell.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {
                    //Get.to(EditProfileScreen(data: data));
                    //Get.to(() => EditProfileScreen(data: data));
                    controller.nameController.text = data['name'];
                    controller.passController.text = data['password'];
                    Get.to(() => EditProfileScreen(data: data));

                    //this one is workin for navigation but not passing data.
                    // Navigator.pushNamed(context, EditProfileScreen.routeName,
                    //     arguments: EditProfileScreen(
                    //       data: data,
                    //     ));
                  },
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    await Get.put(AuthController()).signoutMethod(context);
                    Navigator.pushNamed(context, SplashScreen.routeName);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
