import 'package:flutter/material.dart';

Future<String?> showModal(context, List<String> items) {
  const TextStyle itemTextStyle = TextStyle(
    color: Color(0xFF323238),
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );
  String selected = '';
  return showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) {
        return SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
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
                          items[index],
                          textAlign: TextAlign.center,
                          style: itemTextStyle,
                        ),
                        onTap: () {
                          selected = items[index];
                          Navigator.of(context).pop(selected);
                        }),
                  ),
                );
              }),
        );
      });
}
