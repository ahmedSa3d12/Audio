import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class PDFDownloadedScreen extends StatefulWidget {
  const PDFDownloadedScreen({super.key});

  @override
  State<PDFDownloadedScreen> createState() => _PDFDownloadedScreenState();
}

class _PDFDownloadedScreenState extends State<PDFDownloadedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.green,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
