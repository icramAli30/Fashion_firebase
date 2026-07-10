import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/models/cart_modelclass.dart';
import 'package:firebase_class/models/order_models.dart';

class OrderServioce {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String get uid => firebaseAuth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get orderCollection =>
      firebaseFirestore.collection("users").doc(uid).collection("orders");

  Future checkoutFunction(List<CartModel> cartItems,
      int subtotal,
      int deliveryFee,
      int total) async {
    List<Map<String, dynamic>> items = [];

    for (var item in cartItems) {
      items.add(item.toJson());
    }

    final documets = orderCollection.doc();

    OrderModel orderModel = OrderModel(
      id: documets.id,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      status: "Pending",
      items: items,
    );

    await documets.set(orderModel.toJson());

  }

  Stream<List<OrderModel>> getOrderList() {
    return orderCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((value) => OrderModel.fromJson(value.data()))
          .toList();
    });
  }
}