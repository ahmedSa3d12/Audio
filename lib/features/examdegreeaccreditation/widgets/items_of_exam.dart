import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/models/grade_and_rate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/utils/string_to_double.dart';

class ItemsOfDegreeAndRateWidget extends StatefulWidget {
  ItemsOfDegreeAndRateWidget({required this.gradeList, super.key});
  List<GradeAndRateModelData> gradeList;
  @override
  State<ItemsOfDegreeAndRateWidget> createState() =>
      _ItemsOfDegreeAndRateWidgetState();
}

class _ItemsOfDegreeAndRateWidgetState
    extends State<ItemsOfDegreeAndRateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.gradeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: getSize(context) / 4.5,
            margin: EdgeInsets.all(getSize(context) / 100),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: HexColor(widget.gradeList[index].backgroundColor),
                borderRadius: BorderRadius.circular(getSize(context) / 22)),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(getSize(context) / 44),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            widget.gradeList[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: darken(
                                    HexColor(widget
                                        .gradeList[index].backgroundColor),
                                    0.4),
                                fontSize: getSize(context) / 32),
                          ),
                        ),
                        Text(
                          widget.gradeList[index].degree,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                              fontSize: getSize(context) / 32),
                        ),
                        SizedBox(height: getSize(context) / 44)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: getSize(context) / 22),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(context) / 12),
                    child: CircularPercentIndicator(
                      radius: getSize(context) / 12,
                      animation: true,
                      fillColor: AppColors.white,
                      animationDuration: 1200,
                      lineWidth: getSize(context) / 44,
                      percent: resultOfProgress(widget.gradeList[index].degree),
                      center: Text(
                        '${(widget.gradeList[index].percentage.round()).toString()}%',
                        style: TextStyle(
                            color: darken(
                                HexColor(
                                    widget.gradeList[index].backgroundColor),
                                0.4),
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 32),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: AppColors.white,
                      progressColor: darken(
                          HexColor(widget.gradeList[index].backgroundColor),
                          0.4),
                    ),
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
