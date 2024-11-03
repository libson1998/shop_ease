import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/post/create_post/add_data.dart';
import 'package:shope_ease/widgets/button_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _downloadUrl;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  Uint8List? _image;

  // Controller for the description field
  final TextEditingController _descriptionController = TextEditingController();

  Future<Uint8List> _pickImage(ImageSource source) async {
    final XFile? _file = await _picker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No image selected");
    return Uint8List(0);
  }

  Future<void> selectImage() async {
    Uint8List img = await _pickImage(ImageSource.gallery);
    if (img.isNotEmpty) {
      setState(() {
        _image = img;
      });
    }
  }

  Future<XFile?> _compressImage(XFile file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(
        tempDir.path,
        'compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: 70,
        minWidth: 1024,
        minHeight: 1024,
      );

      return compressedFile != null ? XFile(compressedFile.path) : null;
    } catch (e) {
      _showErrorDialog('Error compressing image: $e');
      return null;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Post image",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display image if _image is not null
              if (_image != null)
                InkWell(
                  onTap: selectImage,
                  child: Image.memory(
                    _image!, // Use the Uint8List directly

                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50),
                ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  labelText: "Add Note",
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 20),
              if (_image == null)
                ButtonWidget(
                    buttonPress: selectImage,
                    title: 'Select Image',
                    width: screenWidth,
                    height: 50,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, 0.08),
                        end: Alignment(-1, -0.08),
                        colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    )),

              if (_isUploading) ...[
                LinearProgressIndicator(value: _uploadProgress / 100),
                const SizedBox(height: 10),
                Text('${_uploadProgress.toStringAsFixed(1)}%'),
              ],
              if (_image != null)

              ButtonWidget(
                  buttonPress: () {
                    saveProfile();
                  },
                  title: 'Submit',
                  width: screenWidth,
                  height: 50,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, 0.08),
                      end: Alignment(-1, -0.08),
                      colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.09,
                  )),

              if (_downloadUrl != null) ...[
                const SizedBox(height: 20),
                const Text("Download URL:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                SelectableText(
                  _downloadUrl!,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void saveProfile() async {
    String description = _descriptionController.text;
    String? resp =
        await StorageData().saveData(textContent: description, file: _image!);
  }
}
