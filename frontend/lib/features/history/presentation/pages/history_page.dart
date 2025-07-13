import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/core/widgets/image_view.dart';
import 'package:gap/gap.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'History',
        titleSpacing: 0,
        textStyle: context.headlineSmall.w600,
        showBorder: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'View your previously summarized videos',
            style: context.labelMedium.grey,
          ),
          Gap(20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 130 / 80,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ImageView(
                        imageType: ImageType.network,
                        imagePath: '',
                      ),
                    ),
                    Gap(10),
                    Text('Title', style: context.labelLarge.s14),
                    Text('sub title', style: context.labelSmall.s12.grey),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
