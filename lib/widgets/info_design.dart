import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/mainScreens/itemsScreen.dart';
import 'package:sellers_app/model/items.dart';
import 'package:sellers_app/model/menus.dart';



class InfoDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}



class _InfoDesignWidgetState extends State<InfoDesignWidget>
{
  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("items")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Item Deleted Successfully.");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen()));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 220.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                      fontFamily: "Train",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: ()
                    {
                      //delete menu
                      deleteMenu(widget.model!.menuID!);
                    },
                  ),
                ],
              ),


              // Text(
              //   widget.model!.menuInfo!,
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 12,
              //   ),
              // ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
