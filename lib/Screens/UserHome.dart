import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:chat_up/Screens/CurrentUserProfile.dart';
import 'package:chat_up/Widgets/ChatCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import '../Services/User_presence.dart';
import '../Widgets/ChatroomCard.dart';

class UserHome extends StatefulWidget {
  final User? user;

  const UserHome({Key? key, required this.user}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with WidgetsBindingObserver {
  late User? _currentUser;
  late List<String> labels;
  XFile? cameraImage;
  CameraController? cameraController;
  // late Interpreter interpreter;
  // String? output = '';
  // TensorBuffer probabilityBuffer =
  // TensorBuffer.createFixedSize(<int>[1, 1001], TfLiteType.uint8);
  // SequentialProcessor<TensorBuffer> probabilityProcessor =
  // TensorProcessorBuilder().add(DequantizeOp(0, 1 / 255.0)).build();
  // dynamic myFile;
  //   void function() async {
  //   cameraImage = await cameraController!.takePicture();
  //   myFile = cameraImage!.path;
  //   // runModel();
  // }

  // loadCamera() {
  //   cameraController = CameraController(cameras![1], ResolutionPreset.high,
  //       imageFormatGroup: ImageFormatGroup.jpeg);
  //   cameraController?.initialize().then((value) {
  //     if (!mounted) {
  //       print('not mounted');
  //       return;
  //     } else {
  //       function();
  //     }
  //   });
  // }
//   runModel() async {
//     ImageProcessor imageProcessor = ImageProcessorBuilder()
//         .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR))
//         .build();
//
// // Create a TensorImage object from a File
//     TensorImage tensorImage = TensorImage.fromFile(myFile);
//     tensorImage = imageProcessor.process(tensorImage);
//     interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);
//     TensorLabel tensorLabel = TensorLabel.fromList(
//         labels, probabilityProcessor.process(probabilityBuffer));
//
//     Map<String, double> doubleMap = tensorLabel.getMapWithFloatValue();
//   }


// Initialization code
// Create an ImageProcessor with all ops required. For more ops, please
// refer to the ImageProcessor Ops section in this README.
//   ImageProcessor imageProcessor = ImageProcessorBuilder()
//       .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR))
//       .build();
// Preprocess the image.
// The image for imageFile will be resized to (224, 224)
//   loadModel() async {
//     labels = await FileUtil.loadLabels("assets/labels.txt");
//     try {
//       // Create interpreter from asset.
//        interpreter =
//       await Interpreter.fromAsset("/assets/model_unquant.tflite");
//     } catch (e) {
//       print('Error loading model: ' + e.toString());
//     }
//   }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PresenceService().configureUserPresence(_currentUser!.uid);
  }

  final _mFirestore = FirebaseFirestore.instance;
  final focusSearch = FocusNode();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      PresenceService().disconnect();
    }
    if (state == AppLifecycleState.resumed) {
      PresenceService().connect();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            focusSearch.unfocus();
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [
                  0.50,
                  1.0,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFfefefe),
                  Color(0xFF6372a1),
                ],
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CurrentUserProfile(
                                        user: _currentUser!,
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      _currentUser!.photoURL!),
                                  maxRadius: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentUser!.displayName!,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Online',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/setting (1).png'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //Second Row Started
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE2EDFC),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            height: 35,
                            width: 245,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(2, 1, 0, 0),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/search (2).png'),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  focusNode: focusSearch,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(40, 0, 0, 10),
                                    hintText: 'Search Chat Rooms',
                                    hintStyle: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(200, 5, 0, 0),
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/edit.png'))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //3rd row started
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (null),
                              child: Text(
                                'Recents',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (null),
                              child: Text(
                                'All',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //4th row started

                      Container(
                        width: double.infinity,
                        height: 250,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _mFirestore
                              .collection('friends')
                              .doc(_currentUser!.uid)
                              .collection(_currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                              return ListView.builder(
                                itemCount: snapshots.data!.docs.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot<Object?>? doc =
                                      snapshots.data?.docs[index];
                                  return ChatCard(
                                    data: doc,
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Data not available',
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      //5th Row started
                      //6th row started
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (null),
                              child: const Text(
                                'Recents',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (null),
                              child: const Text(
                                'All',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //7th row started
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: StreamBuilder<QuerySnapshot>(
                          stream:
                              _mFirestore.collection('chatrooms').snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                              return ListView.builder(
                                itemCount: snapshots.data!.docs.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot<Object?>? doc =
                                      snapshots.data?.docs[index];
                                  return ChatroomCard(
                                    data: doc,
                                    index: index,
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  'Data not available',
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      //  Column(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         loadCamera();
                      //         loadModel();
                      //       },
                      //       child: Container(
                      //         width: 100,
                      //         height: 200,
                      //         color: Colors.red,
                      //         child: !cameraController!.value.isInitialized
                      //             ? Container()
                      //             : AspectRatio(
                      //                 aspectRatio:
                      //                     cameraController!.value.aspectRatio,
                      //                 child: CameraPreview(cameraController!),
                      //               ),
                      //       ),
                      //     ),
                      //     // Text(
                      //     //   'this is output${output!}',
                      //     //   style: TextStyle(
                      //     //     fontSize: 20,
                      //     //     color: Colors.red,
                      //     //     fontWeight: FontWeight.w600,
                      //     //   ),
                      //     // )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
