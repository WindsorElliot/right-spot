import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:right_spot/model/comment.dart';
import 'package:right_spot/model/spot.dart';
import 'package:right_spot/view/comment/comment_row_view.dart';

class SpotView extends StatefulWidget {
  final Spot spot;

  SpotView({ @required this.spot });

  @override
  _SpotViewState createState() => _SpotViewState();
}

class _SpotViewState extends State<SpotView> {

  Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = Set<Marker>();
    Timer(Duration(milliseconds: 300), () {
      this.setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(widget.spot.name), 
            position: LatLng(widget.spot.geoloc.lattitude, widget.spot.geoloc.longitude),

          )
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, height: 250,
            child: Container(
              child: GoogleMap(
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                myLocationButtonEnabled: false,
                markers: this._markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.spot.geoloc.lattitude, widget.spot.geoloc.longitude),
                  zoom: 6
                ),
              ),
            ),
          ),
          Positioned(left: (MediaQuery.of(context).size.width/2  - 90), top: 250.0 - 90,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 90,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.spot.images.firstWhere((element) => element.isDefault).url ?? widget.spot.images.first
                ),
                backgroundColor: Colors.white,
                radius: 85,
              ),
            )
          ),
          Positioned(left: 10, right: 10, top: 250.0 + 100, height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width/2) - 10,
                  height: 50,
                  child: Text('${widget.spot.name} \nCharente Maritime (17)',
                    textAlign: TextAlign.left,
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                      ),
                    ),
                  ),
                Container(
                  width: (MediaQuery.of(context).size.width/2) - 10,
                  height: 50,
                    child: Text(widget.spot.typeName(),
                      textAlign: TextAlign.right,
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                      ),
                    )
                )
              ],
            )
          ),
          Positioned(top: 400, left: 10, right: 10,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Center(
                child: Text(widget.spot.description,
                textAlign: TextAlign.center,
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ),
          ),
          Positioned(top: 450, left: 0, right: 0, bottom: 0,
            child: ListView.builder(
              itemCount: widget.spot.comments.length,
              itemBuilder: (BuildContext context, int index) {
                final Comment comment = widget.spot.comments[index];
                return CommentRowView(comment: comment);
              },
            )
          ),
          Positioned(top: 40, left: 20, right: 0,
            child: InkWell(
              child: Text("< retour",
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("press !!!!");
        },
        child: Icon(Icons.drive_eta),
      ),
    );
  }
}