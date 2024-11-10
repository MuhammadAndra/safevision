import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  DropdownWidget({super.key, required this.list});
  List<String> list;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints.tight(
          Size.fromHeight(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
      width: 160,
      trailingIcon: Transform.translate(
        offset: Offset(3, -5),
        child: Icon(Icons.arrow_drop_down),
      ),
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
