import 'dart:async';
import 'package:right_spot/api/api_response.dart';
import 'package:right_spot/api/repository/GeolocRepository.dart';
import 'package:right_spot/model/geoloc.dart';

class GeolocBloc<T> {
  GeolocRepository _geolocRepository;
  StreamController _listController;
  StreamController _geolocController;

  StreamSink<ApiResponse<List<Geoloc>>> get geolocListSink => this._listController.sink;
  Stream<ApiResponse<List<Geoloc>>> get geolocListStream => this._listController.stream;

  StreamSink<ApiResponse<Geoloc>> get geolocSink => this._geolocController.sink;
  Stream<ApiResponse<Geoloc>> get geolocStream => this._geolocController.stream;

  GeolocBloc() {
    _geolocRepository = GeolocRepository(bearerToken: "Bearer");
    _listController = StreamController<ApiResponse<List<Geoloc>>>();
    _geolocController = StreamController<ApiResponse<Geoloc>>();
    fetchGeoloc();
  }

  fetchGeoloc() async {
    this._listController.add(ApiResponse.loading("Fetching geoloc position"));
    try {
      List<Geoloc> geolocs = await this._geolocRepository.fetch();
      this._listController.add(ApiResponse.completed(geolocs));
    } catch (e) {
      this._listController.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _listController?.close();
    _geolocController?.close();
  }

}