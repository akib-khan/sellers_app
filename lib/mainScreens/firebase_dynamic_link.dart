import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:sellers_app/global/global.dart';
//import 'package:provider/provider.dart';
//import 'package:sellers_app/mainScreens/menus_screen.dart';
//import 'package:sellers_app/models/sellers.dart';
//import 'package:sellers_app/widgets/sellers_design.dart';
//import 'package:sellers_app/provider/category_seller_provider.dart';
import 'package:flutter/material.dart';

//FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//var abc="";

class FirebaseDynamicLinkService{

  static Future<String> createDynamicLink(bool  short, String uid ) async{
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://trulylocal.page.link',
      link: Uri.parse('https://trulylocal.com/sellers?id=$uid'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.users_app',
        minimumVersion: 1,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    _linkMessage = url.toString();
    return _linkMessage;
  }

   static Future<void> initDynamicLink(BuildContext context)async {
    //final productsProvider =
     //   Provider.of<CategorySellerProvider>(context, listen: false);

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async{
        //showAlertDialog(context);
        final Uri deepLink = dynamicLink!.link;

        print(" url path is: ${deepLink.pathSegments} queryParam: ${deepLink.queryParameters} ");
        /*var isSeller = deepLink.pathSegments.contains('sellers');
        // TODO :Modify Accordingly
        if(isSeller){
          String id = deepLink.queryParameters['id'] as String;
          if( deepLink!=null ) {

            // TODO : Navigate to your pages accordingly here

             try{
               await firebaseFirestore.collection('sellers').doc(id).get()
                   .then((snapshot) {
                     print( " data is: ${snapshot.data()} ");
                     Sellers sellerData = Sellers.fromJson(
                        snapshot.data() as Map<String, dynamic> 
                     );
                     return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                       MenusScreen(model: sellerData,)
                     ));
               });
             }catch(e){
               print(e);
             }
          }else{
            return null;
          }
        }*/
      }, onError: (OnLinkErrorException e) async{
        print('link error');
      }
    );


    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink() ;
    try{
      //showAlertDialog(context);
      if( data == null )
        return null;
      final Uri deepLink = data.link;
      print(" url path 1 is: ${deepLink.pathSegments} queryParam: ${deepLink.queryParameters}");
      /*var isSeller = deepLink.pathSegments.contains('sellers');
        if(isSeller){
          String id = deepLink.queryParameters['id'] as String;
          if( deepLink!=null ) {

            // TODO : Navigate to your pages accordingly here

             try{
               await firebaseFirestore.collection('sellers').doc(id).get()
                   .then((snapshot) {
                     print( " data is: ${snapshot.data()} ");
                     Sellers sellerData = Sellers.fromJson(
                        snapshot.data() as Map<String, dynamic> 
                     );
                     return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                       MenusScreen(model: sellerData,)
                     ));
               });
             }catch(e){
               print(e);
             }
          }
          else{
            return null;
          }
        }*/
      }
      catch(e){
      print('No deepLink found');
    }
  }
 
  
}