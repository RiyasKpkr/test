import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import '../utils/colors.dart';
import '../utils/date_formatter.dart';
import 'app_text_field.dart';

class AppDateAndTimePickerField extends StatelessWidget {
  AppDateAndTimePickerField(
      {super.key,
      this.selectedDateTime,
      this.labelText,
      this.helperText,
      required this.onDateSelected,
      required this.dateFormat,
      required this.displayDateFormat,
      required this.minDate,
      this.isFutureEnable = true});

  final dynamic selectedDateTime;
  final DateTime minDate;
  final String dateFormat;
  final String displayDateFormat;
  final String? labelText, helperText;
  final TextEditingController controller = TextEditingController();
  final void Function(DateTime dateTime) onDateSelected;
  final bool isFutureEnable;

  @override
  Widget build(BuildContext context) {
    controller.text = DateFormatter.getFormattedTxt("$selectedDateTime",
        format: displayDateFormat);

    return AppTextField(
        controller: controller,
        labelText: labelText,
        hint: "Choose Date",
        helperText: helperText,
        onTap: () async {
          DatePicker.showDatePicker(
            context,
            dateFormat:
                dateFormat, // dateFormat: 'dd MMM yyyy HH:mm', give format like this
            pickerMode: DateTimePickerMode.datetime,
            initialDateTime: DateTime.now(),
            minDateTime: minDate,
            maxDateTime:
                isFutureEnable == false ? DateTime.now() : DateTime(3000),
            onMonthChangeStartWithFirstDate: true,
            onConfirm: (dateTime, List<int> index) {
              DateTime pickedDate = dateTime;
              debugPrint("$pickedDate");
              controller.text = DateFormatter.getFormattedTxt("$pickedDate",
                  format: displayDateFormat);
              debugPrint("control value  ${controller.text}");
              onDateSelected(pickedDate);
            },
          );
        },
        suffixIcon: const Icon(Icons.calendar_today_outlined,
            color: gray500Clr, size: 20));
  }
}
