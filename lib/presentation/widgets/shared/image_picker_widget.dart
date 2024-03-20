import 'dart:async';

import 'package:control_stock_web_admin/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, this.title});

  final String? title;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Stack(
        children: [
          Card(
            elevation: 4.0,
            child: Padding(
              padding: kPaddingAppSmall,
              child: _buildPreviewImage(),
            ),
          ),
          Positioned(
            right: 16.0,
            top: 16.0,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primaryContainer, padding: kPaddingAppSmall),
              icon: const Icon(Icons.close),
              onPressed: _clear,
              label: const Text('Limpiar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewImage() {
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 512,
          maxHeight: 512,
        ),
        child: Image.network(path),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 512,
          maxHeight: 512,
        ),
        child: Image.network(path),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            _uploadImage();
          },
          child: Container(
            width: 512,
            height: 512,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: colorScheme.primaryContainer,
                width: 1.0,
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                Icons.add_a_photo,
                size: 48.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          WebUiSettings(
            translations: const WebTranslations(
              title: 'Cortar imagen',
              rotateLeftTooltip: 'Rotar a la izquierda',
              rotateRightTooltip: 'Rotar a la derecha',
              cancelButton: 'Cancelar',
              cropButton: 'Cortar',
            ),
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 512,
              height: 512,
            ),
            viewPort: const CroppieViewPort(width: 512, height: 512, type: 'square'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _cropImage();
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}
