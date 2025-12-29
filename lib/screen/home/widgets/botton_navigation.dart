import 'package:flutter/material.dart';
import 'package:measurement_guru/screen/home/screen_home.dart';

class BottomNavigation extends StatelessWidget {
 
  const BottomNavigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _){
        return SizedBox(
          height: 110,
          child: BottomNavigationBar(
          
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: updatedIndex,
            onTap: (newIndex){
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                label: 'calculations'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category), 
                label: 'perimeter and area'
              ),
            ], 
          ),
        );
      }
    );
  }
}





