import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  final int length;
  final void Function(String otp)? onCompleted;
  final Color activeColor;
  final Color inactiveColor;
  final double spacing;
  final double size;
  final TextStyle? textStyle;
  final bool obscureText;
  final bool autoFocus;
  final bool showCursor;

  const OtpInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.spacing = 8.0,
    this.size = 60.0,
    this.textStyle,
    this.obscureText = false,
    this.autoFocus = true,
    this.showCursor = false,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }

      // Update OTP
      _currentOtp = _controllers.map((e) => e.text).join();

      // Check if OTP is complete
      if (_currentOtp.length == widget.length) {
        widget.onCompleted?.call(_currentOtp);
      }
    } else {
      // Handle backspace when field is cleared
      _currentOtp = _controllers.map((e) => e.text).join();
    }

    setState(() {});
  }

  void _onBackspace(int index, String value) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      // Clear previous field on backspace
      _controllers[index - 1].clear();
      setState(() {});
    }
  }

  void _onPaste(String? value) {
    if (value != null && value.length == widget.length) {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = value[i];
        if (i == widget.length - 1) {
          _focusNodes[i].unfocus();
        } else {
          _focusNodes[i].unfocus();
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      }
      _currentOtp = value;
      widget.onCompleted?.call(value);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ??
        Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.keyV &&
                event.isControlPressed) {
              // Handle paste
              Clipboard.getData(Clipboard.kTextPlain).then((clipboardData) {
                if (clipboardData != null && clipboardData.text != null) {
                  _onPaste(clipboardData.text);
                }
              });
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.length, (index) {
                final isFocused = _focusNodes[index].hasFocus;
                final hasValue = _controllers[index].text.isNotEmpty;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNodes[index]);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isFocused
                              ? widget.activeColor
                              : widget.inactiveColor,
                          width: isFocused ? 2.0 : 1.5,
                        ),
                        boxShadow: isFocused
                            ? [
                          BoxShadow(
                            color: widget.activeColor.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                            : null,
                      ),
                      child: Center(
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          cursorColor: widget.activeColor,
                          showCursor: widget.showCursor,
                          cursorWidth: 2,
                          obscureText: widget.obscureText,
                          obscuringCharacter: '●',
                          style: textStyle?.copyWith(
                            color: Colors.black87,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) => _onChanged(value, index),
                          onTap: () {
                            // Select all text when tapped
                            _controllers[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _controllers[index].text.length,
                            );
                          },
                          onSubmitted: (_) => _onBackspace(index, ''),
                          onEditingComplete: () {
                            if (index < widget.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  bool _isDesktop() {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;
  }
}