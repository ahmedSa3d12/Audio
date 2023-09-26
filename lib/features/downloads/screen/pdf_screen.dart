import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../cubit/downloadscubit.dart';
import '../cubit/downloadsstate.dart';
import 'pdfview.dart';

class PDFDownloadedScreen extends StatefulWidget {
  const PDFDownloadedScreen({super.key});

  @override
  State<PDFDownloadedScreen> createState() => _PDFDownloadedScreenState();
}

class _PDFDownloadedScreenState extends State<PDFDownloadedScreen> {
  @override
  void initState() {
    context.read<DownloadedFilesCubit>().getPDFs();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadedFilesCubit, DownloadedFilesState>(
      listener: (context, state) {
        if (state is DownloadsPDFLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<DownloadedFilesCubit>();
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getPDFs();
          },
          child: Scaffold(
              body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : cubit.files.isEmpty
                      ? Center(
                          child: Text('no_data'.tr()),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.files.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PdfViewScreen(
                                            pdfLink:
                                                File(cubit.files[index].path),
                                            pdfTitle: cubit.files[index].path
                                                .split('/')
                                                .last
                                                .split('.')
                                                .first)));
                                ////Nav to pdf view
                              },
                              child: Container(
                                margin: EdgeInsets.all(getSize(context) / 88),
                                height: getSize(context) / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        getSize(context) / 88)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: getSize(context) / 3,
                                      height: getSize(context) / 4.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.bink,
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44)),
                                      child: Image.asset(
                                        ImageAssets.examPdfImage,
                                        width: getSize(context) / 4.5,
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 44),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.files[index].path
                                                  .split('/')
                                                  .last
                                                  .split('.')
                                                  .first,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: getSize(context) / 28,
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.deleteDownloadedFilePDF(cubit
                                                .files[index].path
                                                .split('/')
                                                .last);
                                            ////delete pdf
                                          },
                                          icon: Icon(CupertinoIcons.delete,
                                              color: AppColors.red)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
        );
      },
    );
  }
}
