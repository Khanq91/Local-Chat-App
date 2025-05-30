import 'package:flutter/material.dart';

import '../../../../data/model/Message/FileModel.dart';

class OwnFileCard extends StatelessWidget {
  // final FileModel fileModel;
  final String fileName;
  // final int fileSize;
  final String time;

  const OwnFileCard({
    super.key,
    // required this.fileModel,
    required this.fileName,required this.time,
  });
  Icon _getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf, color: Colors.red);
    } else if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
      return const Icon(Icons.description, color: Colors.blue);
    } else if (fileName.endsWith('.xls') || fileName.endsWith('.xlsx')) {
      return const Icon(Icons.grid_on, color: Colors.green);
    } else if (fileName.endsWith('.ppt') || fileName.endsWith('.pptx')) {
      return const Icon(Icons.slideshow, color: Colors.orange);
    } else {
      return const Icon(Icons.insert_drive_file, color: Colors.grey);
    }
  }
  String formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    } else if (bytes >= 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    } else {
      return "$bytes B";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nội dung file
            Row(
              children: [
                _getFileIcon(fileName), // Icon file theo đuôi
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       fileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Text(formatFileSize(fileSize),
                      //   style: TextStyle(
                      //     color: Colors.black54,
                      //     fontSize: 13
                      //   ),)
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.blue),
                  onPressed: () {
                    // TODO: download file
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
