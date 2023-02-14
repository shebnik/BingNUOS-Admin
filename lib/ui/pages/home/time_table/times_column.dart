import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/ui/components/text_overflow_handler.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/add_group.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';

class TimesColumn extends StatelessWidget {
  final double dataRowHeight;
  final double timeColumnWidth;

  const TimesColumn({
    Key? key,
    required this.dataRowHeight,
    required this.timeColumnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).splashColor,
            width: 5.0,
          ),
        ),
      ),
      child: DataTable(
        dataRowHeight: dataRowHeight,
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: Theme.of(context).splashColor,
            width: 5,
          ),
        ),
        columns: [
          DataColumn(
            label: Expanded(
              child: SizedBox(
                height: dataRowHeight,
                child: const AddGroup(),
              ),
            ),
          ),
        ],
        rows: List.generate(
          subjectTimes.length,
          (i) => DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: timeColumnWidth,
                  child: Center(
                    child: TextOverflowHandler(
                      text: subjectTimes[i],
                      maxWidth: timeColumnWidth,
                      style: Utils.isLandscape(context)
                          ? Theme.of(context).textTheme.headlineSmall!
                          : Theme.of(context).textTheme.labelMedium!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
