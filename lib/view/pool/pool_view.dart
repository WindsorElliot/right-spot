import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class PoolView extends KFDrawerContent {

  @override
  _PoolViewState createState() => _PoolViewState();
}

class _PoolViewState extends State<PoolView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
    );
  }
}