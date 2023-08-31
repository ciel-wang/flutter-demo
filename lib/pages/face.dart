import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../components/custom_background.dart';
import '../components/head.dart';
import '../components/custom_btn.dart';

class Face extends StatefulWidget {
  const Face({super.key});

  @override
  State<Face> createState() => _FaceState();
}

class _FaceState extends State<Face> {
  CameraController? controller;
  late Future initializeControllerFuture;
  List<CameraDescription> _cameras = <CameraDescription>[];

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  void getCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _initializeCameraController(_cameras[0]);
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        debugPrint('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          debugPrint('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          debugPrint('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          debugPrint('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          debugPrint('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          debugPrint('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          debugPrint('Audio access is restricted.');
          break;
        default:
          debugPrint(e.toString());
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Column(children: [
      const HeadComponent(),
      const SizedBox(height: 20),
      const Text('请正视摄像头', style: TextStyle(fontSize: 36)),
      const SizedBox(height: 40),
      SizedBox(
          width: 500,
          height: 500,
          child: Stack(children: [
            Positioned(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
                child: _cameraPreviewWidget()),
            Image.asset('static/img/border.png', fit: BoxFit.cover)
          ])),
      const SizedBox(height: 100),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CustomBtn(
            type: ColorType.info,
            onPressed: () => Navigator.pushNamed(context, '/sign'),
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
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w900));
    } else {
      return CameraPreview(controller!);
    }
  }
}
