import 'dart:math';


import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {

  SearchItem();

  Widget itemHeader (){
    return Container(
      padding: EdgeInsets.all(18),
      child: (
        Row(
          children: [
            itemVip(),
            Text('Hyundai Veloster 356  -  2012', style: TextStyle(fontSize: 15))
          ],
        )
      ),
    );
  }

  Widget itemVip (){
    return Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(6),
          child: Text('S-VIP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white)),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 134, 0, 1),
            borderRadius: BorderRadius.circular(7),
          ),
    );
  }

  Widget buttonWithIcon ({title: '', icon}){
    return Container(
      color: Color.fromRGBO(249, 249, 251, 0.9),
      child: Row(
        children: [
          IconButton(
              padding: EdgeInsets.only(left: 10),
              icon:  Icon(
                  icon,
                  color: Color.fromRGBO(199, 208, 218, 1),
                  size: 20
              ), onPressed: null),
          Text(title),
        ],
      ),
    );
  }

  Widget itemContent (){
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text('500 728 ₾', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black)),
                  Text('საშუალო ფასი', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color.fromRGBO(255, 134, 0, 1))),
                  Text('განბაჟებული'),
                ],
              ),
            ),
            Row(
              children: [
                ClipRRect(
                    child: Image.network('https://source.unsplash.com/collection/1989985/${Random().nextInt(20) + 110}x${Random().nextInt(20) + 82}'),
                    borderRadius: BorderRadius.circular(16),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('საშუალო ფასი'),
                          Text('საშუალო ფასი'),
                          Text('საშუალო ფასი'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('საშუალო ფასი'),
                          Text('საშუალო ფასი'),
                          Text('საშუალო ფასი'),
                        ],
                      )
                    ],
                  ),
                )
               
              ],
            ),
            Row(
              children: [
                buttonWithIcon(title: 'იდეალურ მდგომარეობაში', icon: Icons.access_alarm),
                buttonWithIcon(title: 'სასწრაფოდ', icon: Icons.remove_red_eye_outlined)
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Widget itemFooter (){
    return Container(
      height: 48,
      padding: EdgeInsets.all(18),
      child: (
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.adb,
                  color: Colors.red,
                  size: 20
                ),
              ),
              Text('589 ნახვა', style: TextStyle(fontSize: 11)),
              Container(
                  margin: EdgeInsets.all(8),
                  color: Color.fromRGBO(94, 105, 125, 1),
                  width: 2,
                  height: 2
              ),
              Text('2 დღის უკან', style: TextStyle(fontSize: 11)),
              Spacer(),
              IconButton(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 10),
                  icon:  Icon(
                  Icons.add_circle_outline,
                  color: Color.fromRGBO(199, 208, 218, 1),
                  size: 20
              ), onPressed: null),
              IconButton(
                  padding: EdgeInsets.only(left: 10),
                  icon:  Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color.fromRGBO(199, 208, 218, 1),
                  size: 20
              ), onPressed: null)
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      height: 375,
      child: Column(
        children: [
          itemHeader(),
          itemContent(),
          itemFooter(),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}