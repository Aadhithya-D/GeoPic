import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:os_app/controllers/image_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  late var imgName = "No image selected";
  final currentUser = FirebaseAuth.instance;
  final ImageController imageController = Get.put(ImageController());
  clear(){
    setState(() {
      image = null;
      imgName = "No image selected";
    });
  }

  Future pickImage1() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
      imgName = image.name;
    });
    print(imgName);
    uploadImage();
  }

  uploadImage(){
    final path = 'Images/${currentUser.currentUser?.uid}/$imgName';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(image!);
    var link = "https://firebasestorage.googleapis.com/v0/b/os-app-979bd.appspot.com/o/Images%2F${currentUser.currentUser?.uid}%2F$imgName?alt=media";
    var data = {
      "imageURL": FieldValue.arrayUnion([link])
    };
    FirebaseFirestore.instance.collection("UserData").doc("${currentUser.currentUser?.uid}").update(data);
    if(ImageController.imageURLList.contains(link) == false) {
      ImageController.imageURLList.add(link);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text("GeoPic", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Text("Welcome ${imageController.userName}!", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: (){
                    pickImage1();
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Container(
                      height: 20,
                      width: 30,
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Text("Upload Image", style: TextStyle(fontSize: 20, color: Colors.white),)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
