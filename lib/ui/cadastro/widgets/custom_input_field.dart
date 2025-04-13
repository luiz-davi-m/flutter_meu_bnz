import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'info_icon.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final bool required;
  final bool showInfo;
  final bool isDropdown;
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final List<String>? dropdownItems;
  final String? fieldType;

  const CustomInputField({
    Key? key,
    required this.label,
    this.required = true,
    this.showInfo = true,
    this.isDropdown = false,
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.dropdownItems,
    this.fieldType,
  }) : super(key: key);

  List<TextInputFormatter>? _getInputFormatters() {
    if (inputFormatters != null) return inputFormatters;

    switch (fieldType) {
      case 'cpf':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          _CpfInputFormatter(),
        ];
      case 'cnpj':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(14),
          _CnpjInputFormatter(),
        ];
      case 'cpfCnpj':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(14),
          _CpfCnpjInputFormatter(),
        ];
      case 'phone':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          _PhoneInputFormatter(),
        ];
      case 'date':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
          _DateInputFormatter(),
        ];
      default:
        return inputFormatters;
    }
  }

  TextInputType? _getKeyboardType() {
    if (keyboardType != null) return keyboardType;

    switch (fieldType) {
      case 'cpf':
      case 'cnpj':
      case 'cpfCnpj':
      case 'phone':
      case 'date':
        return TextInputType.number;
      default:
        return keyboardType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveInputFormatters = _getInputFormatters();
    final effectiveKeyboardType = _getKeyboardType();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (required)
              Text(
                '*',
                style: AppTextStyles.body.copyWith(color: AppColors.required),
              ),
            Text(label, style: AppTextStyles.body),
            if (showInfo) const InfoIcon(),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 1,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: isDropdown
              ? DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 13),
              border: InputBorder.none,
            ),
            value: null,
            hint: Text(
              placeholder ?? 'Selecione uma opção',
              style: AppTextStyles.placeholder,
            ),
            items: dropdownItems?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (controller != null) {
                controller!.text = newValue ?? '';
              }
            },
            validator: validator,
          )
              : TextFormField(
            controller: controller,
            obscureText: obscureText,
            inputFormatters: effectiveInputFormatters,
            keyboardType: effectiveKeyboardType,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 13,
              ),
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: AppTextStyles.placeholder,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}


class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 2 || i == 5) buffer.write('.');
      if (i == 8) buffer.write('-');
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 || i == 4) buffer.write('.');
      if (i == 7) buffer.write('/');
      if (i == 11) buffer.write('-');
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _CpfCnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    if (text.length <= 11) {
      final buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        if (i == 2 || i == 5) buffer.write('.');
        if (i == 8) buffer.write('-');
      }
      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    } else {
      final buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        if (i == 1 || i == 4) buffer.write('.');
        if (i == 7) buffer.write('/');
        if (i == 11) buffer.write('-');
      }
      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    }
  }
}

class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    buffer.write('(');
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write(') ');
      if (i == 7) buffer.write('-');
      buffer.write(text[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(text[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}