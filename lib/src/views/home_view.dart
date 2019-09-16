import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/views/directions_view.dart';
import 'package:qrreaderapp/src/views/maps_view.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class HomeView extends StatefulWidget{

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;

  @override
  Widget build( BuildContext context ){

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: (){},
          )
        ],
      ),
      body: _callPage( currentIndex ),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: (){
          _scanQR(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _scanQR( BuildContext context ) async{

    //https://www.google.com
    //geo:3.443339467257526,-76.51357069453127

    String futureString = '';

    try{
      futureString = await new QRCodeReader().scan();
      _showAlert( context, futureString);

    }catch( e ){
      futureString = e.toString();
    }

    print('futureString: $futureString');

    if( futureString != null ){
      print('Tiene informacion.');
    }
    
  }

  void _showAlert( BuildContext context, String message ){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ( context ){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text( message ),
              FlutterLogo( size: 100.0,)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.black,
              child: Text('Done'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

  Widget _callPage( int actualPage ){

    switch( actualPage ){

      case 0: return MapsView();
      case 1: return DirectionsView();

      default: 
        return MapsView();
    }
  }

  BottomNavigationBar _createBottomNavigationBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: ( index ){
        setState(() {
          currentIndex = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map),
          title:  Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.brightness_5),
          title:  Text('Directions')
        ),
      ],
    );
  }
}