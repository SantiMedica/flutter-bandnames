import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';



class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Guns&Roses', votes: 3),
    Band(id: '3', name: 'AC/DC', votes: 7),
    Band(id: '4', name: 'Queen', votes: 9),
  ];

  get itemBuilder => null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Band Names', style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic, fontSize: 30.0),)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context,i) => bandTile(bands[i])
        
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        ),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.redAccent,
        child: Text('Delete Band', style: TextStyle(fontSize: 20.0, color: Colors.white10),),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.0),
      ),
      onDismissed: (direciton){
        print('${band.id}');
      },
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text(' ${band.votes}', style: TextStyle(fontSize: 20),),
            onTap: () =>{},
          ),
    );
  }

  addNewBand() {

    final textController = new TextEditingController();

  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Band brow:'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blueAccent,
              onPressed: () => addBandToList( textController.text)
            )
          ],
        );
      }
      );
  }

  showCupertinoDialog(
    context: context,
    builder: ( _ ) {
      return CupertinoAlertDialog(
        title: Text('NewBand Name:'),
        content: CupertinoTextField(
          controller: textController,
          ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => addBandToList( textController.text)
            ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Close'),
            onPressed: () => Navigator.pop(context)
            ),
        ],
      );
    }
    );
    

  }

  void addBandToList( String name) {
    if (name.length >1){
      //podemos agregar
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0) );
      setState(() {});
    }


    Navigator.pop(context);
  }


}