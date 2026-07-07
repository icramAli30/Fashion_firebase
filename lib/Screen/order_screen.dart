
import 'package:firebase_class/models/order_models.dart';
import 'package:firebase_class/services/oder_services.dart';
import 'package:firebase_class/services/products_services.dart';
import 'package:flutter/material.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  final ProductsServices productsServices = ProductsServices();

  final OrderServioce orderServioce = OrderServioce();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Screen")),
      body: StreamBuilder<List<OrderModel>>(
        stream: orderServioce.getOrderList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final orderModel = snapshot.data ?? [];

          print(" Length ${orderModel.length}");
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: orderModel.length,
            itemBuilder: (_, index) {
              var orderModelData = orderModel[index];

              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: orderModelData.items.length,
                itemBuilder: (_, index2) {
                  var data = orderModelData.items[index2];
                  return Card(
                    child: ListTile(
                      title: Text("${data["name"]}"),
                      subtitle: Column(
                        children: [
                          Image.network("${data["image"]}"),
                          Text("${data["price"]}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}