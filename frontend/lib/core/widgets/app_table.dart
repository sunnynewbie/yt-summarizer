import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class AppTable extends StatelessWidget {
  final List<TableRowItem> tableItems;
  final String tableTitle;

  const AppTable({
    super.key,
    required this.tableItems,
    required this.tableTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tableTitle, style: context.bodyLarge.w600),
        Gap(30),
        Table(
          columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(3)},
          children: [
            ...tableItems.map(
              (e) => getTableRow(context, title: e.title, value: e.content),
            ),
          ],
        ),
      ],
    );
  }

  TableRow getTableRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: .5),
          top: BorderSide(color: AppColors.border, width: .5),
        ),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(title, style: context.labelLarge.grey),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(value, style: context.labelLarge),
          ),
        ),
      ],
    );
  }
}

class TableRowItem {
  String title;
  String content;

  TableRowItem({required this.title, required this.content});
}
