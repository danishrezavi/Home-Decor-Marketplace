import 'package:flutter/material.dart';
import 'package:shop_app/components/product_cardlist.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) => ProductCard(
                  itemIndex: index,
                  product: demoProducts[index],
                  press: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments:
                        ProductDetailsArguments(product: demoProducts[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
