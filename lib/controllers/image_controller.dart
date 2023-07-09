import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ImageController extends GetxController{
  static var imageURLList = <dynamic>{}.obs;
  var userName = "".obs;
  final currentUser = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    var data = await FirebaseFirestore.instance
        .collection("UserData").doc("${currentUser.currentUser?.uid}")
        .get();
    var data1 = data.data();
    userName.value = data1?["name"];
    List<dynamic> list = data1?["imageURL"];
    imageURLList.addAll(list.toSet());
    print(userName);
    }
}