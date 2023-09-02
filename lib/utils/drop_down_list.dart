
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';

class DropDownList extends StatefulWidget {
  final List<String> items;
  String? value;
  final Widget? hint;
  DropDownList({Key? key, required this.items, this.value, this.hint})
      : super(key: key);

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  void initState() {
    widget.value = widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CustomColors.DarkGrey)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value,
          hint: widget.hint,
          iconSize: 36,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: CustomColors.DarkGrey),
          isExpanded: true,
          items: widget.items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            this.widget.value = value.toString();
            print(this.widget.value);
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: CustomColors.DarkGrey, fontSize: 18),
        ),
      );
}
