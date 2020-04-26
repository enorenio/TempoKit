import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/repository.dart';
import 'package:tempokit/view/home/favourites_tab.dart';
import 'package:tempokit/view/home/recents_tab.dart';
import '../../injection_container.dart';
import '../../util/bloc/auth/auth_bloc.dart';
import '../wrapper/wrapper_page.dart';

int _itemCount=5;

class ProjectPage extends StatefulWidget {
  final index;
  
  
  ProjectPage({this.index});
  
  @override
  _ProjectPageState createState() => _ProjectPageState();
  
}


class _ProjectPageState extends State<ProjectPage> {
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sl<Repository>().getProjects(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Wrap(
                children: <Widget>[LinearProgressIndicator()],
              );
            case ConnectionState.done:
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data[widget.index].name),
                ),
                body: //_buildCarousel(context, widget.index)
                MyCarousel(itemIndex: widget.index),
                floatingActionButton: FloatingActionButton(
                  onPressed: ()=> showNewCoulmnView(),
                  child: Icon(Icons.add),
                  backgroundColor: Colors.amber[800]),
              );
          
          }
        },
    );
  }
  void showNewCoulmnView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewColumnView();
        });
  }

}




final List<String> itemName = <String>['New requests', 'In progress', 'Done', 'Not approved','Add'];

class MyCarousel extends StatefulWidget{
   final int itemIndex; 
     
   MyCarousel({this.itemIndex}); 
   _MyCarouselState createState() => _MyCarouselState();
 
 }

 class _MyCarouselState extends State<MyCarousel>{
   
   @override
   Widget build(BuildContext context) {
     return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //Text('Carousel $carouselIndex'),
          SizedBox(
            // you may want to use an aspect ratio here for tablet support
            height: 245.0,
            child: PageView.builder(
              // store this controller in a State to save the carousel scroll position
              controller: PageController(viewportFraction: 0.8),
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int itemIndex) {
                return MyItem(itemIndex: itemIndex);
              },
            ),
          )
        ],
      );
   }
   _updateItemCount(String columnName){
    setState(() {
      _itemCount++;
      itemName.add(columnName);
     
      

    });
 }
 }

  
 
 
 class MyItem extends StatefulWidget{
   final int itemIndex;
   
   MyItem({this.itemIndex});
   _MyItemState createState() => _MyItemState();

 }

 class _MyItemState extends State<MyItem>{

   @override
   Widget build(BuildContext context) {
     return Container(
          margin: EdgeInsets.only(top:10),
          child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children:<Widget>[
            Container(
              alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    itemName[widget.itemIndex],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
            MyCont(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed:()=>showNewRequestView(),
                ),          
            ),
          

          ]
          )
        )
  );
  
   }
    void showNewRequestView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewRequestView();
        });
  }

 }



class NewColumnView extends StatelessWidget {
  final columnNameController = TextEditingController();
  final columnFormKey = GlobalKey<FormState>();
  GlobalKey<_MyCarouselState> carouselGlobalKey = new GlobalKey<_MyCarouselState>();
  void setCarouselState(){
     carouselGlobalKey.currentState._updateItemCount(columnNameController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: columnFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter column name!';
                  },
                  controller: columnNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Column name...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (columnFormKey.currentState.validate()) {
                        Navigator.pop(context);
                        setCarouselState();
                        //print(_itemCount);
                      }
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  
}

class NewRequestView extends StatelessWidget {
  final requestNameController = TextEditingController();
  final requestFormKey = GlobalKey<FormState>();
  GlobalKey<_MyItemState> itemGlobalKey = new GlobalKey<_MyItemState>();
  
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: requestFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter request!';
                  },
                  controller: requestNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Your request...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (requestFormKey.currentState.validate()) {
                        Navigator.pop(context);
                        //itemName.add(columnNameController.text);
                        //setCarouselState();
                        //itemName.removeLast();
                        print(_itemCount);
                      }
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  
}

class MyCont extends StatelessWidget{
  Widget child;

  MyCont({this.child});
  @override
  Widget build(BuildContext context){
     return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 7.0),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromRGBO(60, 60, 60, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(13, 51, 32, 0.1),
                      offset: Offset(0.0, 6.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: this.child,
              ),
            ),
          ],
        );
  }
}