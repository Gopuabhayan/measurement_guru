import 'package:flutter/material.dart';
import 'calculator_widgets.dart';

class ScreenParimeterAndArea extends StatefulWidget {
  const ScreenParimeterAndArea({Key? key}) : super(key: key);

  @override
  State<ScreenParimeterAndArea> createState() => _ScreenParimeterAndAreaState();
}

class _ScreenParimeterAndAreaState extends State<ScreenParimeterAndArea> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perimeter & Area '),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Perimeter', ),
            Tab(text: 'Area', ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PerimeterCalculator(),
          AreaCalculator(),
        ],
      ),
    );
  }
}