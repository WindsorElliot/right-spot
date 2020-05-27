import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:right_spot/controller/bloc/spots_bloc.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/spot.dart';
import 'package:right_spot/view/kfdrawer/kfdrawer.dart';
import 'package:right_spot/view/spot/spot_view.dart';

class MapView extends KFDrawerContent {

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  // 46.150570, -1.056356 France center
  static const LatLng _center = const LatLng(46.150570, -1.056356);

  SpotsBloc _spotsBloc;
  Completer<GoogleMapController> _googleMapController;
  TextEditingController _searchTextController;
  String _searchText;
  Set<Marker> _marker;

  @override
  void initState() {
    _spotsBloc = SpotsBloc();
    _googleMapController = Completer();
    _searchTextController = TextEditingController();
    _searchText = "";
    _marker = Set<Marker>();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _spotsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: this._spotsBloc,
      listener: (BuildContext context, ApiResponse<List<Spot>> state) {
        if (state.status == Status.COMPLETED) {
          state.data.forEach((element) => this._addSpotMarker(element));
        }
        if (state.status == Status.ERROR) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Center(child: Text(state.message))));
        }
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 6.0,
              ),
              onMapCreated: _onMapCreated,
              markers: this._marker,
            ),
          ),
          Positioned(top: 50, left: 30, right: 30,
            child: SizedBox(
              height: 50,
              child: TextField(
              controller: this._searchTextController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Rechercher",
                hintText: "Rechercher",
                prefixIcon: IconButton(icon: Icon(Icons.menu), onPressed: widget.onMenuPressed),
                suffixIcon: (this._searchText.isNotEmpty)
                  ? IconButton(icon: Icon(Icons.clear), onPressed: () { 
                    this._searchTextController.clear();
                    FocusScope.of(context).unfocus();
                  })
                  : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onChanged: this._onTextFieldChange,
            ),
            )
          )
        ],
      )
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    this._googleMapController.complete(controller);
  }

  void _onTextFieldChange(value) {
    this.setState(() { _searchText = value; });
  }

  void _addSpotMarker(Spot spot) {
    if (this._marker.where((element) => spot.id.toString() == element.markerId.value).length != 0) {
      return;
    }
    this.setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId(spot.id.toString()),
          position: LatLng(spot.geoloc.lattitude, spot.geoloc.longitude),
          infoWindow: InfoWindow(
            title: spot.name,
            snippet: spot.note.toString() + ' étoiles'
          ),
          onTap: () {
            this._onTapMarker(spot);
          },
        )
      );
    });
  }

  void _onTapMarker(Spot spot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SpotView(spot: spot)));
  }
}