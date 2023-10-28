import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/package_model.dart';
import 'package:idea_tuition_managment_app/stores/package/package_store.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/package_box.dart';
import 'package:provider/provider.dart';

class PackageMenu extends StatefulWidget {
  const PackageMenu({super.key});

  @override
  State<PackageMenu> createState() => _PackageMenuState();
}

class _PackageMenuState extends State<PackageMenu> {
  late PackageStore packageStore;
  late PackageModel packageModel = PackageModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    packageStore = Provider.of<PackageStore>(context);
    packageStore.getPackageList();
    packageStore.packageList;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'All packages',
                needLeading: true,
              )),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.pushNamed(context, Routes.package);
          }, child: Icon(Icons.add),),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                children: [
                  GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 31.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 1/1.60
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true ,
                      itemCount: packageStore.packageList!.documents.length,
                      itemBuilder: (context, index) {
                        if (packageStore.packageList == null) {
                          // Handle the case where packageList is null (perhaps loading or error).
                          return CircularProgressIndicator(); // or an error message, for example
                        }
                        //print("CUstomer List Length is :: ${customerStore.customerList!.documents.length}");
                        var package_list = packageStore.packageList!.documents[index].data;
                        print("Actual values of package_list ::: $package_list");
                        var pack_List = PackageModel.fromJson(package_list);
                        print(pack_List.package_title);
                        return InkWell(
                          onTap: (){

                          },
                          child: PackageBox(
                            title: pack_List.package_title,
                            //numOfStudent: '100',
                            //numOfBatch: '20',
                            description: pack_List.package_description,
                            fees: pack_List.package_fee,
                          ),
                        );
                      })
                ],
              )
              /*Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: PackageBox(
                            title: 'বিজয়',
                            numOfStudent: '100',
                            numOfBatch: '20',
                            fees: '100',
                          )),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        flex: 1,
                          child: PackageBox(
                            title: 'স্বাধীন',
                            numOfStudent: '900',
                            numOfBatch: '20',
                            fees: '500',
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: PackageBox(
                            title: 'স্বাধীন',
                            numOfStudent: '100',
                            numOfBatch: '20',
                            fees: '100',
                          )),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                          flex: 1,
                          child: PackageBox(
                            title: 'সীমাহীন',
                            numOfStudent: 'Unlimited',
                            numOfBatch: 'Unlimited',
                            fees: '1000',
                          )),
                    ],
                  ),

                ],
              ),
              */
            ),
          ),
        ));
  }
}
