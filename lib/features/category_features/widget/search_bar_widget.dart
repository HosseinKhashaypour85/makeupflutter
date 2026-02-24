import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final bool autofocus;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onSearch,
    this.initialValue,
    this.focusNode,
    this.controller,
    this.hintText = "جستجو در محصولات...",
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3EDE6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD7C2B0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8D6E63).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF5D4037),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFF8D6E63),
                size: 22,
              ),
              onPressed: onSearch,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          suffixIcon: initialValue != null || (controller?.text.isNotEmpty ?? false)
              ? Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xFFBCAAA4),
                size: 18,
              ),
              onPressed: () {
                controller?.clear();
                if (onChanged != null) onChanged!('');
              },
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          )
              : null,
          hintText: hintText,
          hintStyle: AppFontStyles().secondFontStyle(12.sp, Colors.grey,),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          isDense: true,
        ),
        cursorColor: const Color(0xFF8D6E63),
        cursorWidth: 2,
        cursorRadius: const Radius.circular(2),
      ),
    );
  }
}