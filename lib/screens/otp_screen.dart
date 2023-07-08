import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:os_app/screens/login.dart';
import 'package:os_app/screens/register.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  final bol;
  final name;
  VerifyOTP({Key? key, required this.bol, required this.name})
      : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
              ),
              Image.asset(
                'lib/images/login.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {


                        if (widget.bol) {
                          PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: RegisterScreen.verify,
                              smsCode: code);
                          await auth.signInWithCredential(credential)
                              .then((value) => {
                                    FirebaseFirestore.instance
                                        .collection("UserData")
                                        .doc(value.user?.uid)
                                        .set({
                                      "name": widget.name,
                                      "phoneNumber": value.user?.phoneNumber,
                                    })
                                  });
                          print("${widget.name}");
                        } else {
                          PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: LoginScreen.verify,
                              smsCode: code);
                          await auth.signInWithCredential(credential);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print("error");
                      }
                    },
                    child: const Text(
                      "Verify Phone Number",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  const Text("Incorrect number?"),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit.",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
