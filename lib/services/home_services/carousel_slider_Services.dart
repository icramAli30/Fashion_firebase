

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/cloudnary_services.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/homemodel/carousel_slidermodel.dart';
import '../category_services.dart';





class CarouselSliderServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CloudniaryService cloudniaryService = CloudniaryService();


  CollectionReference<Map<String, dynamic>> get carouselsliderCollection =>
      firebaseFirestore.collection("carouselslider");

  Future<void> addCarouselSlider(
      CarouselSliderModel carouselsliderModel,
      XFile imageFile,
      ) async {
    final imageUrl = await cloudniaryService.uploadImage(imageFile);

    final document = carouselsliderCollection.doc();

    final newcarouselslider= carouselsliderModel.copyWith(
      id: document.id,
      image: imageUrl,
    );

    await document.set(newcarouselslider.toJson());
  }

  Stream<List<CarouselSliderModel>> getCarouselslider() {
    return carouselsliderCollection
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((data) {
        print("carouselslider  ${data.data()}");
        return CarouselSliderModel.fromJson(data.data());
      })
          .toList();
    });

    // return productCollection.snapshots().map((data) {
    //   return data.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    // });
  }

  Future<void> updateCarouselSlider(
      CarouselSliderModel carouselsliderModel,
      XFile? imageFile,
      ) async {
    var updatedData = carouselsliderModel;

    if (imageFile != null) {
      final image = await cloudniaryService.uploadImage(imageFile);

      updatedData = carouselsliderModel.copyWith(
        image: image,
      );
    }

    await carouselsliderCollection
        .doc(carouselsliderModel.id)
        .update(updatedData.toJson());
  }

  Future delete(String docId) async {
    await carouselsliderCollection.doc(docId).delete();
  }
}