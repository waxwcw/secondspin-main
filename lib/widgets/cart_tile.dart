// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:SecondSpin/constants.dart';
// import 'package:SecondSpin/models/cart_item.dart';

// class CartTile extends StatelessWidget {
//   final CartItem item;
//   final Function() onRemove;
//   final Function() onAdd;
//   const CartTile(
//       {super.key,
//       required this.item,
//       required this.onRemove,
//       required this.onAdd});

//   void dele_product() {
//     try {
//       cartItems.remove(item);
//       print('Item removed from cart: ${item.product.title}');
//     } catch (e) {
//       print('Error removing item from cart: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           padding: const EdgeInsets.all(10),
//           child: Row(
//             children: [
//               Container(
//                 height: 85,
//                 width: 85,
//                 decoration: BoxDecoration(
//                   color: kcontentColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Image.network(
//                   item.product.image,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.product.title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     item.product.category,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade400,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "\$${item.product.price}",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 5,
//           right: 5,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   dele_product();
//                 },
//                 icon: const Icon(
//                   Ionicons.trash_outline,
//                   color: Colors.red,
//                   size: 20,
//                 ),
//               ),
//               Container(
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: kcontentColor,
//                   border: Border.all(
//                     color: Colors.grey.shade200,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: onRemove,
//                       iconSize: 18,
//                       icon: const Icon(
//                         Ionicons.remove_outline,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       item.quantity.toString(),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: onAdd,
//                       iconSize: 18,
//                       icon: const Icon(
//                         Ionicons.add_outline,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import 'package:SecondSpin/models/cart_item.dart';

class CartTile extends StatefulWidget {
  final CartItem item;
  final Function() onRemove;
  final Function() onAdd;
  const CartTile(
      {super.key,
      required this.item,
      required this.onRemove,
      required this.onAdd});

  @override
  CartTileState createState() => CartTileState();
}

class CartTileState extends State<CartTile> {
  void initState() {
    super.initState();
  }

  void deleteProduct() {
    try {
      // 这里假设 cartItems 是一个全局的购物车列表
      setState(() {
        cartItems.remove(widget.item);
      });

      // 通知 Flutter 框架状态已改变，需要重建该 widget
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: kcontentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  widget.item.product.image,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.item.product.category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${widget.item.product.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: deleteProduct,
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kcontentColor,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onRemove,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.remove_outline,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.item.quantity.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onAdd,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.add_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
