import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import 'package:SecondSpin/models/cart_item.dart';
import 'package:SecondSpin/models/product.dart';
import 'package:SecondSpin/utils/constants.dart';

// ignore: must_be_immutable
class AddToCart extends StatelessWidget {
  final Function() onAdd;
  final Function() onRemove;
  AddToCart({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
    required this.product_id,
  });

  String product_id;
  final int currentNumber;

  Future<void> addCartItem() async {
    print(product_id);
    try {
      final String id;
      final String product_title;
      final String product_description;
      final String product_image_url;
      final double product_price;
      final String product_category;

      final data =
          await supabase.from('product').select().eq('id', product_id).single();
      print(data);
      id = data['profile_id'] as String;
      product_id = data['id'] as String;
      product_price = data['price'] as double;
      product_title = data['title'] as String;
      product_description = data['description'] as String;
      product_image_url = data['image_url'] as String;
      product_category = data['category'] as String;
      cartItems.add(CartItem(
        product: Product(
          profile_id: product_id,
          title: product_title,
          description: product_description,
          image: product_image_url,
          price: product_price,
          category: product_category,
          id: id,
        ),
        quantity: currentNumber,
      ));
    } catch (e) {}
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.remove_outline,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentNumber.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: onAdd,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.add_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  addCartItem();
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
