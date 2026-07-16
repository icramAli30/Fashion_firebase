

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/cloudnary_services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/category_modelclass.dart';



class CategoryServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CloudniaryService cloudniaryService = CloudniaryService();

  CollectionReference<Map<String, dynamic>> get categoryCollection =>
      firebaseFirestore.collection("categories");

  Future<void> addCategory(
      CategoryModel categoryModel,
      XFile imageFile,
      ) async {
    final imageUrl = await cloudniaryService.uploadImage(imageFile);

    final document = categoryCollection.doc();

    final newcategory= categoryModel.copyWith(
      id: document.id,
      image: imageUrl,
    );

    await document.set(newcategory.toJson());
  }

  Stream<List<CategoryModel>> getCategory() {
    return categoryCollection
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((data) {
        print("categorydata  ${data.data()}");
        return CategoryModel.fromJson(data.data());
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

    await categoryCollection
        .doc(productModel.id)
        .update(updatedData.toJson());
  }

  Future delete(String docId) async {
    await categoryCollection.doc(docId).delete();
  }
}