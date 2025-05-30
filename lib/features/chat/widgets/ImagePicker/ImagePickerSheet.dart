import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class Imagepickersheet extends StatefulWidget {

  const Imagepickersheet({
    super.key,
    required this.allImages,
    required this.onImageSelectionChanged,
  });
  final List<AssetEntity> allImages;
  final Function(List<AssetEntity>) onImageSelectionChanged;
  @override
  State<Imagepickersheet> createState() => _ImagepickersheetState();
}
late final Function Onsend;
class _ImagepickersheetState extends State<Imagepickersheet> {
  List<AssetEntity> selectedImages = [];
  Map<AssetEntity, Uint8List?> thumbnailCache = {};

  @override
  void initState() {
    super.initState();
    preloadThumbnails();
  }

  void preloadThumbnails() {
    for (var asset in widget.allImages) {
      asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)).then((data) {
        setState(() {
          thumbnailCache[asset] = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: GridView.builder(
        itemCount: widget.allImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          final image = widget.allImages[index];
          final isSelected = selectedImages.contains(image);
          final thumbnailData = thumbnailCache[image];

          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImages.contains(image)) {
                  selectedImages.remove(image);
                } else {
                  selectedImages.add(image);
                }
                widget.onImageSelectionChanged(selectedImages);
              });
            },
            child: Stack(
              children: [
                if (thumbnailData != null)
                  Image.memory(
                    thumbnailData,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                else
                  const Center(child: CircularProgressIndicator()),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
