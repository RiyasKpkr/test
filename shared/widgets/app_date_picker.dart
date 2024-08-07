import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/date_formatter.dart';
import 'app_text_field.dart';

class AppDatePickerField extends StatelessWidget {
  AppDatePickerField({
    super.key,
    this.selectedDateTime,
    this.labelText,
    this.helperText,
    // required
     this.onDateSelected,
  });

  final dynamic selectedDateTime;
  final String? labelText, helperText;
  final TextEditingController controller = TextEditingController();
  final void Function(DateTime dateTime)? onDateSelected;

  @override
  Widget build(BuildContext context) {
    controller.text = DateFormatter.setDateFieldTxt(selectedDateTime);

    return AppTextField(
        controller: controller,
        labelText: labelText,
        hint: "Choose Date",
        helperText: helperText,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              builder: (context, child) {
                return Theme(
                    data: ThemeData.dark().copyWith(
                        primaryColor: brand600Clr,
                        colorScheme: const ColorScheme.dark(
                          primary: brand600Clr,
                          surface: appBarTitleClr,
                          onSurface: brand50Clr,
                        )),
                    child: child!);
              },
              context: context,
              helpText: labelText,
              initialDate: DateTime.parse("${selectedDateTime ?? DateTime.now()}"),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1));

          if (pickedDate != null) {
            controller.text = DateFormatter.setDateFieldTxt(pickedDate);
            onDateSelected!(pickedDate);
          }
        },
        suffixIcon: const Icon(Icons.calendar_today_outlined, color: gray500Clr, size: 20));
  }
}
