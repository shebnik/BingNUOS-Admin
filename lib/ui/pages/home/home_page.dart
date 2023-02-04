import 'package:bingnuos_admin_panel/ui/components/home/app_bar/home_app_bar.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/time_table_widget.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/week_day_chips.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(height: 16),
            WeekDayChips(),
            SizedBox(height: 30),
            TimeTableWidget(),
          ],
        ),
      ),
    );
  }
}
