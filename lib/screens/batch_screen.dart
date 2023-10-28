import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/batch_model.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/stores/batch/batch_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:provider/provider.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({super.key});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late BatchStore batchStore;
  List<BatchModel> _batchList = [];
  List<Map<String, dynamic>> batch_NameList = [];
  String? selectBatchName;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    batchStore = Provider.of<BatchStore>(context);
    filterBatchList(batchStore.batchList);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              child: AppBar(
                backgroundColor: CustomColors.AppBarColor,
                title: Text(
                  "Batch",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.White),
                ),
                centerTitle: true,
                leading: Row(
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        _scaffoldkey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        "assets/menu.svg",
                        height: 20,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Container(
                    height: 32,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/notification.svg",
                            height: 27.14,
                            width: 32.1,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  )
                ],
                //leading: SvgPicture.asset("assets/menu.svg",height: 20,width: 24,fit: BoxFit.cover,),
              ),
              preferredSize: Size.fromHeight(toolbarHeight)),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leave",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: CustomColors.White),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      DropdownButtonFormField(
                          iconEnabledColor: CustomColors.White,
                          value: batchStore.select_batchName = selectBatchName,
                          dropdownColor: CustomColors.AppBarColor,
                          decoration: InputDecoration(
                            hintText: 'Select Your Leave ',
                            hintStyle: CustomTextStyle.icontitle
                                .copyWith(color: CustomColors.White),
                            filled: true,
                            fillColor: const Color(0xff492E51),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                          ),
                          items: batchStore.batchModelList
                              ?.map((item) => DropdownMenuItem(
                              value: item.batch_name,
                              child: Text("${item.batch_name}",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color:
                                      CustomColors.White))))
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              selectBatchName = item;
                            });
                          }),

                    ],
                  )
                ],
              ),
            ),
          ),
        ));();
  }
  Future<String> filterBatchList(DocumentList? batchList) async {
    print("Now list is created");
    if (batchList == null) {
      // Handle the case where deliveryManList is null
      print("Batch Number:: null value");
      return "done";
    }
    var totalBatch = batchList!.total;
    print("Delivery man Number:: ${totalBatch}");
    var batch_List = batchList!.documents.toList();
    print("Delivery man List:: ${batch_List}");
    List<Map<String, dynamic>> AllBatch = [];


    batchStore.TotalBatch = batch_List.length;
    print("Total Batch List number :: ${batchStore.TotalBatch}");
    for(int i = 0; i < batch_List.length; i++){
      print("List will be arranged");
      var document = batch_List[i].data;
      AllBatch.add(document);
      print("Show Batch names :: ${AllBatch}");
      var matchBatchName = document.containsKey('batch_name') && document['batch_name'] == batchStore.select_batchName;
      if(matchBatchName){
        print("condition :: $matchBatchName");
        batchStore.batch_documentID = document['\$id'];
      }
    }
    for(var map in AllBatch){
      print("List will be arranged");
      if (map.containsKey('batch_name')) {
        batch_NameList.add({'batch_name': map['batch_name']});
      }
    }
    print("Delivery Man list ::: $batch_NameList");
    print("Delivery Man's Document ID ::: ${batchStore.batch_documentID}");
    try{
      _batchList = AllBatch.map((data) => BatchModel.fromJson(data)).toList();
    }catch(e){
      print("exception:::${e}");
    }
    return "done";
  }

}
