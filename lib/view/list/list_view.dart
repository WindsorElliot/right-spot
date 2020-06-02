import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class ListSpotView extends KFDrawerContent {

  @override
  _ListSpotViewState createState() => _ListSpotViewState();
}

class _ListSpotViewState extends State<ListSpotView> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
    );
  }
}