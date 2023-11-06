import 'dart:convert';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/data/exceptions/appwrite_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:idea_tuition_managment_app/data/sharedpref/constants/preferences.dart' as aw;

import '../sharedpref/shared_preference_helper.dart';



class ClientAppWrite{
  String? email;

   Client client=Client();
  var account;
  AppwriteErrorUtil appwriteErrorUtil=AppwriteErrorUtil();



   ClientAppWrite(){
     client = Client()
        .setEndpoint("http://penciltech001.penciltech.xyz:9080/v1")
        .setProject("652e291be0c85ef77871")
        .setSelfSigned(status: true); // For self signed certificates, only use for development

      account = Account(client);
  }

   Future<dynamic> signUpSession(String userName,String email,password) async{
     print("enter email session");
     print("enter email :: $email");
     print("enter UserName :: $userName");
     print("enter Password :: $password");
     //print("enter UserID :: $userID");
     Account account = Account(client);

     try{
       final user = await account.create(
           userId: ID.unique(),
           name: userName,
           email: email,
           password: password,
       );
       email = user.email;
       print("get response after registration::$user");
       print("get response after registration::${user.password}");
       //return user;

     }catch(e){
       print("exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }
   }

   Future<dynamic> updateSignUp(String userId, List<String> labels) async{
     print("enter email session");
     //final users =Users(client);
     try{
       // final user = await account.update;
       // print("success::$user");
       // return user;

     }catch(e){
       print("exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }
   }

   Future<dynamic> emailSession(String email,password) async{
     print("enter email session");
     Account account = Account(client);
     Session? session;
     try{
       session = await account.createEmailSession(
         email: email,
         password: password,
       );

/*
       gotString(email);

*/
       print("success::$session");
       return session;
     }catch(e){
       print("exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }
   }
/*
   gotString(String email){
     return email;
   }
*/
   Future<dynamic> getDocument(String databaseId,List doc)async {
     final databases = Databases(client);
     try{
       Document response = await databases.getDocument(
         databaseId:databaseId,
         collectionId: doc.first,
         documentId: doc.last,
       );
       print("document-response::${response.data}");
       return response;

     }catch(e){
       print("document-exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }

   }

   Future<dynamic> addDocument(String databaseId,tag,data)async {
     final databases = Databases(client);
     try{
       Document response = await databases.createDocument(
         databaseId:databaseId,
         collectionId: tag,
         data: data,
         documentId: ID.unique(),
       );
       print("create-document-response::${response.data}");
       return response;

     }catch(e){
       print("create-document-exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }

   }




   Future<dynamic> listDocuments(String databaseId,String collectionId)async {
     print(databaseId);
     print(collectionId);
     final databases = Databases(client);
     try{
       DocumentList response = await databases.listDocuments(
         databaseId:databaseId,
         collectionId: collectionId,
         queries: [
           Query.limit(100)
         ]
       );

       print("listdocument-response::${response.documents.length}");
       print("listdocument-first::${json.encode(response.documents.last.data)}");
       print("listdocument-element:${response.documents.elementAt(0).data}");
       return response;

     }catch(e){
       print("listdocument-exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }

   }


  // //auth
  //  Future<dynamic> post(String path,header) {
  //
  //  }
  //
  //
  //  //data features
  //  Future<dynamic> post(String path,header) {
  //
  //  }
  //  Future<dynamic> update(String path,header) {
  //
  //  }
  //  Future<dynamic> delete(String path,header) {
  //
  //  }
  //  Future<dynamic> getAll(String path,header) {
  //
  //  }
  //  Future<dynamic> find(String path,header) {
  //
  //  }
}
