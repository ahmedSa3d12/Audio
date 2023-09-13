import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

class VideosDownloadedScreen extends StatefulWidget {
  const VideosDownloadedScreen({super.key});

  @override
  State<VideosDownloadedScreen> createState() => _VideosDownloadedScreenState();
}

class _VideosDownloadedScreenState extends State<VideosDownloadedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.red,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
