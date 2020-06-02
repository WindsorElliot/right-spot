import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/controller/bloc/user_bloc.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/user.dart';
import 'package:right_spot/view/user/profil_image_view.dart';

class UserPageView extends StatefulWidget {
  final UserBloc userBloc;

  UserPageView({ @required this.userBloc });

  @override
  _UserPageViewState createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: BlocConsumer(
        bloc: widget.userBloc,
        listener: (BuildContext context, ApiResponse<User> state) {

        },
        builder: (BuildContext context, ApiResponse<User> state) {
          return SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(top: 0, left: 20, height: 50,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.close),
                          Text('fermer')
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ),
                  Positioned(top: 0, left: 0, right: 0,
                    child: Container(
                      child: Center(
                        child: ProfileImageView(imageurl: state?.data?.profilImageUrl ?? null),
                      ),
                    ),
                  ),
                  Positioned(top: 130, right: 0, left: 0, bottom: 0,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}