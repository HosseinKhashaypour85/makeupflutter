import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String validPhone)? onValidPhone;

  const PhoneNumberInput({
    super.key,
    required this.controller,
    this.onValidPhone,
  });

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String? errorText;
  bool _isValid = false;
  bool _hasFocus = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validatePhone(String value) {
    String phone = value.trim();

    if (phone.isEmpty) {
      setState(() {
        errorText = null;
        _isValid = false;
      });
      return;
    }

    // starts with 98 -> convert to 0
    if (phone.startsWith('98')) {
      phone = '0${phone.substring(2)}';
    }

    // must start with 0
    if (!phone.startsWith('0')) {
      setState(() {
        errorText = 'شماره باید با 0 یا 98 شروع شود';
        _isValid = false;
      });
      return;
    }

    // length check
    if (phone.length != 11) {
      setState(() {
        errorText = 'شماره تلفن معتبر نیست';
        _isValid = false;
      });
      return;
    }

    // valid
    setState(() {
      errorText = null;
      _isValid = true;
    });
    widget.onValidPhone?.call(phone);
  }

  // Gold color palette
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldLight = Color(0xFFFFD700);
  static const Color goldAccent = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFFDF6E3);
  static const Color borderColor = Color(0xFFE6D3A7);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hasFocus
                ? [
                    BoxShadow(
                      color: goldPrimary.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            onChanged: _validatePhone,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              counterText: '',
              hintText: '۰۹۱۲۳۴۵۶۷۸۹',
              hintStyle: AppFontStyles().firstFontStyle(16.sp, Colors.grey),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isValid
                        ? Colors.green
                        : _hasFocus
                        ? goldPrimary
                        : Colors.grey.shade400,
                  ),
                  child: Icon(
                    _isValid ? Icons.check : Icons.phone_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              suffixIcon: _isValid
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: Icon(
                        Icons.verified_rounded,
                        color: Colors.green.shade600,
                        size: 20,
                      ),
                    )
                  : null,
              errorText: errorText,
              filled: true,
              fillColor: backgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: goldPrimary, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              errorStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ),
        if (widget.controller.text.isNotEmpty && !_isValid && errorText == null)
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 4),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 14, color: goldDark),
                const SizedBox(width: 6),
                Text(
                  'در حال وارد کردن...',
                  style: TextStyle(
                    fontSize: 13,
                    color: goldDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        if (_isValid)
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 4),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 14,
                  color: Colors.green.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  'شماره تلفن معتبر است',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
