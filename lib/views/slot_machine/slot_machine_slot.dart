import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/slot_machine.dart';
import 'package:provider/provider.dart';
import '../../subject.dart';
import 'package:flutter_test_project/utility/utility.dart';

class SlotMachineSlot extends StatefulWidget {
  const SlotMachineSlot({this.width, this.height, this.scrollable, this.offAxisFraction});

  final double width;

  final double height;

  final bool scrollable;

  final double offAxisFraction;

  @override
  _SlotMachineSlotState createState() => _SlotMachineSlotState();
}

class _SlotMachineSlotState extends State<SlotMachineSlot> {

  FixedExtentScrollController _scrollController;

  SlotMachine _slotMachine;

  List<int> items;

  int selectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = new FixedExtentScrollController();
    _slotMachine = new SlotMachine();
    items = _slotMachine.generateNumbers(100);

    WidgetsBinding.instance
      .addPostFrameCallback((_) => {
        scrollToIndex(items.length ~/2),
        setNotifierListener()
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  scrollToIndex(int index) {
    _scrollController.jumpToItem(index);
  }

  setNotifierListener() {
    Subject counter = context.read<Subject>();
    counter.addListener(() => spin());
  }

  spin() {
    SlotMachineSpin spin = _slotMachine.calculateSpin(_scrollController.selectedItem, items.length);

    _scrollController.animateToItem(spin.toIndex, duration: spin.duration, curve: spin.curve);

    setState(() => selectedIndex = spin.toIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 3,
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
//      margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
//      color: Colors.red[800],
      child:
      ListWheelScrollView(
        controller: _scrollController,
        itemExtent: 240,
        diameterRatio: 10,
        offAxisFraction: widget.offAxisFraction,
        perspective: 0.006,
        physics: widget.scrollable ?
        FixedExtentScrollPhysics()
          :
        NeverScrollableScrollPhysics(),
        squeeze: 1.1,

        children: <Widget>[
          ...items.mapIndexed((element, index) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
                border: index == selectedIndex ?
                Border.all(width: 5, color: Colors.yellow[900])
                    :
                null
              ),
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  '$element',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60.0),
                ),
              )
            );
          })
        ],
//        onSelectedItemChanged: (i) {
//          print(items[i]);
//        },
      ),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                spreadRadius: -15,
                offset: Offset(0.0, 0.75)
            )
          ],
//        color: Colors.red,
      ),
    );
  }
}
