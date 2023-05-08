import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/change_to_mega_byte.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/models/classes_exam_data_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import 'class_exam_icon_widget.dart';

class ClassesExamItemWidget extends StatelessWidget {
  const ClassesExamItemWidget({Key? key, required this.model})
      : super(key: key);

  final ClassesExamDatumModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: model.type == 'pdf'
                      ? HexColor('#FCB9B9')
                      : HexColor('#FDC286'),
                ),
                child: SizedBox(
                  height: 65,
                  width: 55,
                  child: Center(
                    child: Image.asset(
                      model.type == 'pdf'
                          ? ImageAssets.examPdfImage
                          : ImageAssets.examPaperImage,
                      height: 65,
                      width: 55,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          model.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.type == 'pdf',
                        child: Expanded(
                          child: Text(
                            changeToMegaByte(model.examPdfSize.toString()),
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: model.type == 'pdf'?10: 35),
                      SizedBox(
                        width: 210,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClassExamIconWidget(
                              textData: ' ${model.numOfQuestion} Q',
                              type: 'text',
                              iconColor: AppColors.blueColor1,
                              onclick: () {
                                print('rrrrrrrrrrrr');
                              },
                            ),
                            ClassExamIconWidget(
                              textData: ' ${model.totalTime} min',
                              type: 'text',
                              iconColor: AppColors.blueColor1,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.noLoveIcon,
                              iconColor: AppColors.error,
                              onclick: () {
                                print('wwwwwwwwwwwwwwwww');
                              },
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.answerPdfIcon,
                              iconColor: AppColors.goldColor,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.videoIcon,
                              iconColor: AppColors.skyColor,
                              onclick: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: model.type == 'pdf',
            child: Positioned(
              top: 95,
              right: 10,
              child: InkWell(
                onTap: () async {
                  print('object');
                  downloadPdf(model.pdfExamUpload!, 'yehiaaa_pdf');
                  // downloadFile('yehiaaa_pdf', model.pdfExamUpload);
                },
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: DownloadIconWidget(
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  downloadFile(var filePath, var documentUrl) async {
    try {
      /// setting filename
      final filename = filePath;
      String dir = (await getApplicationDocumentsDirectory()).path;
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      String url = documentUrl;

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');
      print(' path :  $dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      return file;
    } catch (err) {
      print(err);
    }
  }

  downloadPdf(String video_url, String video_name) async {
    final dio = Dio();

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio
        .download(
          video_url,
          dir.path + "/pdfs/" + video_url.split("/").toList().last,
          onReceiveProgress: (count, total) {},
        )
        .whenComplete(
          () {},
        );
  }
}
