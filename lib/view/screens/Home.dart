import 'package:flutter/material.dart';
import 'package:tiktok/constant/Colors.dart';

import '../../constant/Constant.dart';
import '../widgets/CustomAddIcon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: (index){
          setState(() {
            pageIdx=index;
          });
        },
        currentIndex: pageIdx,
        items:const [
          BottomNavigationBarItem(
              icon:Icon(Icons.home,size: 25,),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.search,size: 25,),
              label: 'Search'
          ),
          BottomNavigationBarItem(
              icon:CustomAddIcon(),
              label: ''
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.message,size: 25,),
              label: 'Message'
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.account_circle,size: 25,),
              label: 'Account'
          )
        ],
      ),
      body: SafeArea(
          child: Center(child: pageIndex[pageIdx])
      ),
    );
  }
}
