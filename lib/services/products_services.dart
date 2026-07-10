

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/cloudnary_services.dart';
import 'package:image_picker/image_picker.dart';



class ProductsServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CloudniaryService cloudniaryService = CloudniaryService();

  CollectionReference<Map<String, dynamic>> get productCollection =>
      firebaseFirestore.collection("product");

  Future<void> addProduct(
      ProductModel productModel,
      XFile imageFile,
      ) async {
    final imageUrl = await cloudniaryService.uploadImage(imageFile);

    final document = productCollection.doc();

    final newProduct = productModel.copyWith(
      id: document.id,
      image: imageUrl,
    );

    await document.set(newProduct.toJson());
  }

  Stream<List<ProductModel>> getProducts() {
    return productCollection
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((data) {
        print("data  ${data.data()}");
        return ProductModel.fromJson(data.data());
      })
          .toList();
    });

    // return productCollection.snapshots().map((data) {
    //   return data.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    // });
  }

  Future<void> updateproducts(
      ProductModel productModel,
      XFile? imageFile,
      ) async {
    var updatedData = productModel;

    if (imageFile != null) {
      final image = await cloudniaryService.uploadImage(imageFile);

      updatedData = productModel.copyWith(
        image: image,
      );
    }

    await productCollection
        .doc(productModel.id)
        .update(updatedData.toJson());
  }

  Future delete(String docId) async {
    await productCollection.doc(docId).delete();
  }
}