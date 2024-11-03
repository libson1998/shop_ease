import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;

  // To store selected images
  List<XFile> _selectedImages = [];

  PostBloc() : super(PostInitial()) {
    // Handling image selection event
    on<SelectImagesEvent>(_onSelectImages);
    // Handling post creation event
    on<CreatePostEvent>(_onCreatePost);
  }

  void _onSelectImages(SelectImagesEvent event, Emitter<PostState> emit) {
    _selectedImages = event.images; // Store selected images
    emit(PostInitial()); // Emit initial state or update the UI as necessary
  }

  Future<void> _onCreatePost(CreatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    try {
      // Check if enough images are selected
      if (_selectedImages.length < 3) {
        emit(PostError('Please select at least 3 images.'));
        return;
      }

      // Compress selected images
      List<XFile> compressedImages = await _compressImages(_selectedImages);

      // Upload images to Firebase Storage
      List<String> imageUrls = [];
      for (var image in compressedImages) {
        String? downloadUrl = await _uploadFile(File(image.path));
        if (downloadUrl != null) {
          imageUrls.add(downloadUrl);
        } else {
          emit(PostError('Image upload failed.'));
          return;
        }
      }

      // Create a post object
      Map<String, dynamic> post = {
        'textContent': event.textContent,
        'imageUrls': imageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Store post in Firestore
      await _firestore.collection('postmages').add(post);

      emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<List<XFile>> _compressImages(List<XFile> images) async {
    List<XFile> compressedFiles = [];
    for (var image in images) {
      final File originalFile = File(image.path);

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        '${originalFile.parent.path}/compressed_${originalFile.uri.pathSegments.last}',
        quality: 80,
      );

      if (compressedFile != null) {
        compressedFiles.add(XFile(compressedFile.path));
      }
    }
    return compressedFiles;
  }

  Future<String?> _uploadFile(File _photo) async {
    if (_photo == null) return null;
    final fileName = basename(_photo.path);
    final destination = 'postmages/$fileName';

    try {
      final ref = _storage.ref(destination);
      await ref.putFile(_photo);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}