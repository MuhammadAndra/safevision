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
    dropdownValue = widget.list.first; // Access list from the widget
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
        // This is called when the user selects an item.
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
