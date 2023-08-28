import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../components/custom_background.dart';
import '../components/custom_btn.dart';

class Face extends StatefulWidget {
  const Face({super.key});

  @override
  State<Face> createState() => _FaceState();
}

class _FaceState extends State<Face> {
  CameraController? controller;
  late Future initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      initializeControllerFuture = controller!.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Column(children: [
      const Text('请正视摄像头', style: TextStyle(fontSize: 36)),
      _cameraPreviewWidget(),
      Row(children: [
        CustomBtn(
            type: ColorType.info,
            onPressed: () {},
            child: const Text('返回首页',
                style: TextStyle(
                    fontSize: 28, color: Color.fromRGBO(106, 176, 254, 1)))),
        CustomBtn(
            child: const Text('重新比对',
                style: TextStyle(fontSize: 28, color: Colors.white)),
            onPressed: () {}),
      ])
    ]));
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('无相机设备',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w900));
    } else {
      return CameraPreview(controller!);
    }
  }
}
