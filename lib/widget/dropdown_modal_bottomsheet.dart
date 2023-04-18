import 'package:flutter/material.dart';

import '../constants.dart';

class DropDownModalBottomSheet extends StatefulWidget {
  const DropDownModalBottomSheet({
    Key? key,
    this.initalSelection,
    required this.items,
    required this.hintText,
  }) : super(key: key);

  final String? initalSelection;
  final List<String> items;
  final String hintText;

  @override
  DropDownModalBottomSheetState createState() =>
      DropDownModalBottomSheetState();
}

class DropDownModalBottomSheetState extends State<DropDownModalBottomSheet> {
  final TextStyle itemTextStyle = const TextStyle(
    color: Color(0xFF323238),
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );
  String _selected = '';

  @override
  void initState() {
    super.initState();
    _selected = widget.initalSelection ?? '';
  }

  @override
  void dispose() {
    _selected = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        child: TextField(
          readOnly: true,
          controller:
              _selected != '' ? TextEditingController(text: _selected) : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: fieldTextStyle.copyWith(color: const Color(0xFF949C9E)),
            contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
            prefixIconColor: Theme.of(context).primaryColor,
            prefixIcon: const Icon(Icons.work_outline),
            suffixIconColor: Theme.of(context).primaryColor,
            suffixIcon: const Icon(
              Icons.arrow_drop_down_rounded,
              size: 38,
            ),
            enabledBorder: fieldBorder,
            focusedBorder: fieldBorder,
          ),
          style: fieldTextStyle,
          onTap: () {
            showModal(context);
          },
        ),
      ),
    );
  }

  void showModal(context) {
    const TextStyle itemTextStyle = TextStyle(
      color: Color(0xFF323238),
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        builder: (context) {
          return SingleChildScrollView(
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (context, _) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 52,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                          child: Text(
                            widget.items[index],
                            textAlign: TextAlign.center,
                            style: itemTextStyle,
                          ),
                          onTap: () {
                            setState(() {
                              _selected = widget.items[index];
                            });
                            Navigator.of(context).pop();
                          }),
                    ),
                  );
                }),
          );
        });
  }
}
