import 'package:flutter/cupertino.dart';
import 'package:shop_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/bg.png"), fit: BoxFit.fill)),
    child: child,
  );
}
