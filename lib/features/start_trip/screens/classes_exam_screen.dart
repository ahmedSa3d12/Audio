import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/assets_manager.dart';
import '../widgets/expansion_tile_widget.dart';

class ClassesExamsScreen extends StatelessWidget {
  const ClassesExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.chooseClassMessageImage),
          fit: BoxFit.contain,
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<StartTripCubit>().getExamClassesData();
        },
        child: ListView(
          children: [
            SizedBox(height: 20),
            ExpansionTileWidget(
              title: 'اختر الفصل',
            )
          ],
        ),
      ),
    );
  }
}
