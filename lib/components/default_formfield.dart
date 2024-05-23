import 'package:animal_app/extention/extetion.dart';
import 'package:flutter/material.dart';
import '../constants/constant_colors.dart';

/// default form field

class DefaultFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final bool isPassword;
  final bool readOnly;
  final String? Function(String?)? validate;
  final String label;
  final IconData? prefix;
  final Widget? suffix;
  final Function()? prefixPressed;
  final Function()? onTap;
  final bool isClickable;

  const DefaultFormField({
    Key? key,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.isPassword = false,
    this.readOnly = false,
    required this.validate,
    required this.label,
    this.prefix,
    this.suffix,
    this.prefixPressed,
    this.onTap,
    this.isClickable = true,
  }) : super(key: key);

  @override
  _DefaultFormFieldState createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  late TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46.0),
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        keyboardType: widget.type,
        obscureText: widget.isPassword,
        onFieldSubmitted: widget.onSubmit,
        onChanged: (value) {
          setState(() {
            _textDirection = _getTextDirection(value);
          });
        },
        onTap: widget.onTap,
        enabled: widget.isClickable,
        validator: widget.validate,
        textDirection: _textDirection,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
              color: KMaintextColor, fontWeight: FontWeight.bold, fontSize: 12),
          prefixIcon: widget.prefix != null
              ? IconButton(
                  onPressed: widget.prefixPressed,
                  icon: Icon(
                    widget.prefix,
                  ),
                )
              : null,
          suffixIcon: widget.suffix,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3, color: KDefaultColor)),
        ),
      ),
    );
  }

  TextDirection _getTextDirection(String text) {
    bool hasArabicCharacters = RegExp(
            r'[\u0600-\u06FF\u0750-\u077F\u0590-\u05FF\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]')
        .hasMatch(text);
    return hasArabicCharacters ? TextDirection.rtl : TextDirection.ltr;
  }
}

/// main text form field

class MianTextFormField extends StatelessWidget {
  const MianTextFormField({
    super.key,
     this.animalNameController,
    required this.labelText,
    this.textInputType,
    this.height,
    this.validation,
    this.isReadOnly ,
  });

  final TextEditingController? animalNameController;
  final String labelText;
  final TextInputType? textInputType;
  final double? height;
  final String? Function(String?)? validation;
  final bool? isReadOnly ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      decoration: BoxDecoration(
        border: const BorderDirectional(
          bottom: BorderSide(color: KDefaultColor, width: 1),
          start: BorderSide(color: KDefaultColor, width: 0.5),
        ),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(

        readOnly: isReadOnly ?? false,
        controller: animalNameController,
        keyboardType: textInputType,
        obscureText: false,
        onFieldSubmitted: (value) {},
        onChanged: (value) {},
        validator: validation,
        decoration: InputDecoration(
          labelText: labelText,
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),

          floatingLabelStyle: const TextStyle(color: KMaintextColor),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
              color: KMaintextColor, fontWeight: FontWeight.bold, fontSize: 12),
          enabledBorder: const OutlineInputBorder(
              gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(width: 2, color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(
              gapPadding: 50,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(width: 3, color: Colors.transparent)),
        ),
      ),
    ).hP16.tP16;
  }
}

/// main drop down form field


class MianDropDownFormField extends StatelessWidget {
  const MianDropDownFormField({
    Key? key,
    required this.animalTypeController,
    required this.labelText,
    required this.items,
    this.validation
  }) : super(key: key);

  final TextEditingController animalTypeController;
  final String labelText;
  final List<String> items;
  final String? Function(String?)? validation;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const BorderDirectional(
          bottom: BorderSide(color: KDefaultColor, width: 1),
          start: BorderSide(color: KDefaultColor, width: 0.5),
        ),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow:  [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        style: const TextStyle(
          color: KMaintextColor,
        ),
        borderRadius: BorderRadius.circular(30),
        validator: validation,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: KMaintextColor),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
              color: KMaintextColor, fontWeight: FontWeight.bold, fontSize: 12),
          enabledBorder: OutlineInputBorder(
              gapPadding: 20,
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 2, color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              gapPadding: 50,
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: Colors.transparent)),
        ),
        isExpanded: true,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            animalTypeController.text = value;
          }
        },
      ),
    ).hP16.tP16;
  }
}

