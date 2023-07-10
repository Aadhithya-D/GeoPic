import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:os_app/controllers/image_controller.dart';
import 'package:os_app/screens/image_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImageController imageController = Get.put(ImageController());
  File? image;
  late var imgName = "No image selected";
  final currentUser = FirebaseAuth.instance;

  clear(){
    setState(() {
      image = null;
      imgName = "No image selected";
    });
  }

  Future pickImage1() async {
    Position curLoc = await _determinePosition();
    print("${curLoc.latitude}, ${curLoc.longitude}");
    if(curLoc.latitude < 12.841051-0.000100 && curLoc.latitude > 12.841051+0.000100 && curLoc.longitude < 80.153994-0.000100 && curLoc.longitude > 80.153994+0.000100) {
      print("Not allowed");
    }
    else{
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
  }

  Future pickCamera() async {
    Position curLoc = await _determinePosition();
    print("${curLoc.latitude}, ${curLoc.longitude}");
    if(curLoc.latitude < 12.841051-0.000100 && curLoc.latitude > 12.841051+0.000100 && curLoc.longitude < 80.153994-0.000100 && curLoc.longitude > 80.153994+0.000100) {
      print("Not allowed");
    }
    else{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        imgName = image.name;
      });
      print(imgName);
      uploadImage();

    }
  }

  uploadImage() async {
    // 12.841051,80.153994
      final path = 'Images/${currentUser.currentUser?.uid}/$imgName';
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(image!);
      var link = "https://firebasestorage.googleapis.com/v0/b/os-app-979bd.appspot.com/o/Images%2F${currentUser
          .currentUser?.uid}%2F$imgName?alt=media";
      var data = {
        "imageURL": FieldValue.arrayUnion([link])
      };
      FirebaseFirestore.instance.collection("UserData").doc(
          "${currentUser.currentUser?.uid}").update(data);
      if (ImageController.imageURLList.contains(link) == false) {
        ImageController.imageURLList.add(link);
      }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  signOut(){
    currentUser.signOut();
    imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.background,
        // elevation: 0,
        title: const Text("GeoPic", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout, color: Colors.white,))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10,),
                Obx(() {return Text("Welcome ${imageController.userName}!", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);})
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        pickCamera();
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                          child: const Center(child: Icon(Icons.camera_alt, color: Colors.white,size: 25,))
                        // Text("Upload Image", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        pickImage1();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Icon(Icons.cloud_upload, color: Colors.white,size: 25,))
                        // Text("Upload Image", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Obx(
                      () => AlignedGridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    itemCount: ImageController.imageURLList.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          child: CachedNetworkImage(
                            height: 275,
                            imageUrl: ImageController.imageURLList.elementAt(index),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            key: UniqueKey(),
                            fit: BoxFit.cover,
                          ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageScreen(imageURL: ImageController.imageURLList.elementAt(index),))),
                          },
                        ),
                      );
                    },
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
