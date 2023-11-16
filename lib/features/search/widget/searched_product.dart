import 'package:e_commerce_app/common/Widgets/stars.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 125,
                width: 125,
              ),
              Column(
                children: [
                  Container(
                    width: 225,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Container(
                    width: 225,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Stars(
                      rating: 4.5,
                    ),
                  ),
                  Container(
                    width: 225,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "₹${product.price.toString()}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 225,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Eligible for free Shipping",
                    ),
                  ),
                  Container(
                    width: 225,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
