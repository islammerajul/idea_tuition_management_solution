import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class StudentLeave extends StatefulWidget {
  const StudentLeave({super.key});

  @override
  State<StudentLeave> createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _leaveReasonController = TextEditingController();
  DateTime? _selectedDate;
  late CleanCalendarController calendarController;

  void _handleDayTapped(DateTime date){
    setState(() {
      _selectedDate = date;
    });
  }
  ScrollController scrollableController = ScrollController();
  List<String> leave_type = ['Sick Leave', 'Casual Leave'];
  String? select_leave_type = 'Sick Leave';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarController = CleanCalendarController(
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(Duration(days: 365)),
      weekdayStart: DateTime.sunday,
    );
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
                appbarTitle: 'My Leave',
                needLeading: true,
              )),
          body: Container(
            decoration: BoxDecoration(
                //gradient: CustomColors.codeGradient,
                ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 460,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              print("${_selectedDate!.toLocal()}");
                            });
                          },
                          child: ScrollableCleanCalendar(
                            calendarController: calendarController,
                            scrollController: scrollableController,
                            layout: Layout.BEAUTY,
                            showWeekdays: true,
                            dayRadius: 12,
                            calendarCrossAxisSpacing: 10,
                            calendarMainAxisSpacing: 10,
                            monthTextAlign: TextAlign.start,
                            monthTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                //color: Colors.white
                            ),
                            weekdayTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //color: Colors.white
                            ),
                            dayTextStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                //color: Colors.red
                            ),
                            //dayBackgroundColor: Colors.green,
                            daySelectedBackgroundColor: Colors.blue,
                            daySelectedBackgroundColorBetween: Colors.blue[100],

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   child: TableCalendar(
                      //     focuseDay: DateTime.now(),
                      //     firstDay: DateTime.utc(1999, 1 , 1),
                      //     lastDay: DateTime.utc(2030, 12 , 31),
                      //   ),
                      // ),
                      // Text(
                      //   _selectedDate != null
                      //       ? 'Selected Date: ${_selectedDate!.toLocal()}'
                      //       : 'No date selected',
                      //   style: TextStyle(fontSize: 18),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
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
                              value: select_leave_type,
                              dropdownColor: CustomColors.AppBarColor,
                              decoration: InputDecoration(
                                hintText: 'Select',
                                hintStyle: CustomTextStyle.icontitle
                                    .copyWith(color: CustomColors.White),
                                filled: true,
                                fillColor: const Color(0xff492E51),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                              ),
                              items: leave_type
                                  ?.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.White))))
                                  .toList(),
                              onChanged: (item) {
                                setState(() {
                                  select_leave_type = item;
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: 'Leave Decs',
                          //hint: "Type Your Username",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _leaveReasonController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          maxLines: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Describe why are you take leave";
                            }
                          }),
                      SizedBox(
                        height: 150,
                      ),
                      CustomButton(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              print("All fields are valid");
                              Navigator.pushReplacementNamed(
                                  context, Routes.studentNavigationBar);
                              //_authStore.createEmailSession(_emailController.text, _passwordController.text);
                            } else {
                              //_showErrorMessage("Please fill all the data");
                            }
                          },
                          //onTap: login,

                          buttonText: 'Submit')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
