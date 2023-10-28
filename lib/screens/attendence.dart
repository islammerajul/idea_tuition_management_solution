import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:idea_tuition_managment_app/widgets/custom_schedule.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    setState(() {
      _selectedDate = DateTime.now().add(const Duration(days: 2));
      print(_selectedDate);
    });
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
                appbarTitle: 'Create Attendence',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Canlendar",
                    style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CalendarTimeline(
                    showYears: true,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.utc(2030, 12, 31),
                    onDateSelected: (date) =>
                        setState((){
                          _selectedDate = date;
                          print(_selectedDate);
                        }),
                    //leftMargin: 20,
                    monthColor: Colors.white70,
                    dayColor: Colors.teal[200],
                    dayNameColor: const Color(0xFF333A47),
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: Colors.redAccent[100],
                    dotsColor: const Color(0xFF333A47),
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'en',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Today’s Schedule",
                    style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: CustomColors.White
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          CustomSchedule(
                            time: '7:00 pm',
                            slot: 'Morning',
                          ),
                          CustomSchedule(
                            time: '7:00 pm',
                            slot: 'Evening',
                          ),
                          CustomSchedule(
                            time: '8:00 pm',
                            slot: 'No Batch',
                          ),
                          CustomSchedule(
                            time: '9:00 pm',
                            slot: 'No Batch',
                          ),
                          CustomSchedule(
                            time: '9:00 pm',
                            slot: 'Morning',
                          ),
                          CustomSchedule(
                            time: '10:00 pm',
                            slot: 'No Batch',
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ));
  }
}
