import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/camera/picture.dart';

class CameraDemo extends StatefulWidget {
  const CameraDemo({super.key});

  @override
  State<CameraDemo> createState() => _CameraDemoState();
}

class _CameraDemoState extends State<CameraDemo> {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  CameraPreview? _preview;

  @override
  void initState() {
    super.initState();

    Future(() async {
      final cameras = await availableCameras();
      setState(() {
        _cameras = cameras;
      });
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _cameras.isEmpty
                  ? [const Text('No cameras available')]
                  : _cameras.map((camera) {
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setCameraController(camera);
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt),
                            Flexible(
                              child: Text(
                                camera.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
            ),
            SizedBox(height: size.height / 2, child: _preview),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final file = await takePicker();
                    if (file == null) return;
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) {
                          return Picture(file);
                        },
                      ),
                    );
                  },
                  child: const Text('Take Picture'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setCameraController(CameraDescription? camera) async {
    if (camera == null) return;

    if (_cameraController != null) await _cameraController!.dispose();
    final camController = CameraController(camera, ResolutionPreset.high);

    try {
      await camController.initialize();
    } catch (e) {
      print('Camera initialization failed: $e');
      return;
    }

    setState(() {
      _cameraController = camController;
      _preview = CameraPreview(camController);
    });
  }

  Future<XFile?> takePicker() async {
    print(_cameraController);
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _cameraController!.value.isTakingPicture) return null;

    final camController = _cameraController!;

    try {
      await camController.setFlashMode(FlashMode.off);
      final XFile picture = await camController.takePicture();
      return picture;
    } catch (e) {
      print('Failed to take picture: $e');
    }
    return null;
  }
}