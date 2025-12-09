import 'package:flutter/material.dart';
import 'package:measurement_guru/screen/Calculator/screen_calculator.dart';
import 'package:measurement_guru/screen/ParimeterandArea/screen_parimeterandarea.dart';
import 'package:measurement_guru/screen/home/widgets/botton_navigation.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome ({Key? key}) : super(key: key);

static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

final _pages = const [
  ScreenCalculator(),
  ScreenParimeterAndArea(),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body:  SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, Widget? _){
            return _pages[updatedIndex];
          }
        ),
       ),
      
    );
  }
}