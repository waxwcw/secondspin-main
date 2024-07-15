import 'package:flutter/material.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import 'package:SecondSpin/models/cart_item.dart';
import 'package:SecondSpin/widgets/cart_tile.dart';
import 'package:SecondSpin/widgets/check_out_box.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
      ),
      bottomSheet: CheckOutBox(
        items: cartItems,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => CartTile(
                item: cartItems[index],
                onRemove: () {
                  if (cartItems[index].quantity != 1) {
                    setState(() {
                      cartItems[index].quantity--;
                    });
                  }
                },
                onAdd: () {
                  setState(() {
                    cartItems[index].quantity++;
                  });
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: cartItems.length,
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
