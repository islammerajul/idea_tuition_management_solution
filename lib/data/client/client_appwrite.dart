import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/data/exceptions/appwrite_exceptions.dart';



class ClientAppWrite{

   Client client=Client();
   AppwriteErrorUtil appwriteErrorUtil=AppwriteErrorUtil();

   ClientAppWrite(){
     client = Client()
        .setEndpoint("http://154.26.128.15:8081/v1")
        .setProject("64803ecd05168065e4f1")
        .setSelfSigned();

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
       print("success::$session");
       return session;
     }catch(e){
       print("exception::$e");
       return AppwriteErrorUtil.handleError(e as AppwriteException);
     }
   }

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
