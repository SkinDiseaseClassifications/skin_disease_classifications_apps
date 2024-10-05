import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:skin_disease_classifications/localization.dart';
import 'package:skin_disease_classifications/ui/tutorial_page.dart';
import 'result_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String uploadUri =
    dotenv.env['UPLOAD_URI'] ?? 'http://10.0.2.2:5000/api/upload';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: Text(
          AppLocale.title.getString(context),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocale.uploadImage.getString(context),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TutorialPage(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.help))
                            ],
                          ),
                          SizedBox(height: 16),
                          FilledButton.tonalIcon(
                            onPressed: _takePicture,
                            icon: Icon(Icons.photo_camera),
                            label: Text(
                              AppLocale.takePicture.getString(context),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  double.infinity, 48), // Full width button
                              alignment: Alignment
                                  .centerLeft, // Align content to start
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      16), // Optional: Add padding for better look
                            ),
                          ),
                          SizedBox(height: 16),
                          FilledButton.tonalIcon(
                            onPressed: _pickImageFromGallery,
                            icon: Icon(Icons.photo_library),
                            label:
                                Text(AppLocale.openGallery.getString(context)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  double.infinity, 48), // Full width button
                              alignment: Alignment
                                  .centerLeft, // Align content to start
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      16), // Optional: Add padding for better look
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocale.preview.getString(context),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (_imageFile != null)
                        Image.file(
                          _imageFile!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.asset(
                          'assets/images/placeholder_image.png',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 24),
                      FilledButton(
                        onPressed: _imageFile != null && !_isLoading
                            ? _uploadImage
                            : null,
                        child: Text(AppLocale.confirm.getString(context)),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, 48), // Full width button
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        AppLocale.processingImage.getString(context),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File? croppedFile = await _cropImage(imageFile: File(pickedFile.path));
      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await _cropImage(imageFile: File(pickedFile.path));
      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    }
  }

  // Method for cropping the image file passed through a parameter.
  Future<File?> _cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImg = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Potong Gambar',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: true,
              lockAspectRatio: true,
              initAspectRatio: CropAspectRatioPreset.square),
          IOSUiSettings(
              title: 'Potong Gambar',
              aspectRatioPickerButtonHidden: true,
              aspectRatioLockEnabled: true,
              aspectRatioPresets: [CropAspectRatioPresetSquare()]),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedImg == null) {
        return null;
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse(uploadUri);
    final request = http.MultipartRequest('POST', uri);
    final mimeType = lookupMimeType(_imageFile!.path);
    final multipartFile = await http.MultipartFile.fromPath(
      'file',
      _imageFile!.path,
      contentType: MediaType.parse(mimeType!),
    );

    request.files.add(multipartFile);

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              details: jsonResponse,
              imageFile: _imageFile!,
            ),
          ),
        );
      } else {
        print('Image upload failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class CropAspectRatioPresetSquare implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (1, 1);

  @override
  String get name => '1:1 (Persegi)';
}
