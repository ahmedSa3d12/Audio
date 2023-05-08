import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key, required this.pdfLink, required this.pdfTitle})
      : super(key: key);
  final String pdfLink;
  final String pdfTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          pdfTitle,
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfPdfViewer.network(
            pdfLink,
            canShowPaginationDialog: true,
            pageLayoutMode: PdfPageLayoutMode.continuous,
          ),
        ),
      ),
    );
  }
}
