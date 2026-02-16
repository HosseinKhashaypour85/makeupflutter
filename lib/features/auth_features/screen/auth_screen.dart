import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/config/app_config/app_inputs/app_phone_input.dart';
import 'package:makeupflutter/config/app_config/app_shapes/border_radius.dart';
import 'package:makeupflutter/config/app_config/app_shapes/media_query.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_assets_url.dart';
import 'package:makeupflutter/features/auth_features/logic/auth_bloc.dart';
import 'package:makeupflutter/features/auth_features/screen/confirm_otp_screen.dart';
import 'package:makeupflutter/features/auth_features/services/auth_api_services.dart';
import 'package:makeupflutter/features/public_features/widget/snack_bar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String screenId = 'auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String normalizeIranPhone(String input) {
    var phone = input.trim();

    // Accept "98..." and convert to "0..."
    if (phone.startsWith('98')) {
      phone = '0${phone.substring(2)}';
    }

    return phone;
  }

  String? validateIranPhone(String input) {
    var phone = input.trim();
    if (phone.isEmpty) return 'شماره تلفن را وارد کنید';

    // allowed starts: 0 or 98
    if (!(phone.startsWith('0') || phone.startsWith('98'))) {
      return 'شماره باید با 0 یا 98 شروع شود';
    }

    phone = normalizeIranPhone(phone);

    if (!phone.startsWith('0')) return 'شماره نامعتبر است';
    if (phone.length != 11) return 'شماره باید 11 رقم باشد';
    if (!RegExp(r'^\d+$').hasMatch(phone)) return 'فقط عدد وارد کنید';
    if (!phone.startsWith('09')) return 'شماره موبایل معتبر نیست';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthApiServices()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Hero
              Center(
                child: Image.asset(
                  AppAssetsUrl.heroSectionUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 7.h),

              Text(
                'خوش آمدید',
                style: AppFontStyles().firstFontStyle(20.sp, Colors.black),
              ),
              Text(
                'به دنیای زیبایی و اصالت وارد شوید!',
                style: AppFontStyles().firstFontStyle(18.sp, Colors.black),
              ),

              SizedBox(height: 10.h),

              Padding(
                padding: EdgeInsets.all(10.sp),
                child: PhoneNumberInput(controller: phoneController),
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.only(bottom: 30.sp),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthCompletedState) {
                      getSnackBarWidget(
                        context,
                        'ارسال با موفقیت انجام شد',
                        Colors.green,
                      );
                      Future.delayed(
                        Duration(milliseconds: 900),
                        () => Navigator.pushNamed(
                          context,
                          ConfirmOtpScreen.screenId,
                          arguments: {
                            "phoneNum" : phoneController.text
                          }
                        ),
                      );
                    }
                    if (state is AuthErrorState) {
                      getSnackBarWidget(context, state.msg, Colors.red);
                      print(state.msg);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.runtimeType
                        .toString()
                        .toLowerCase()
                        .contains('loading');

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldPrimary,
                        fixedSize: Size(
                          getAllWidth(context) - 20.sp,
                          getHeight(context, 0.06),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(10.sp),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              final raw = phoneController.text;
                              final err = validateIranPhone(raw);
                              if (err != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(err)));
                                return;
                              }

                              final phoneToServer = normalizeIranPhone(raw);
                              context.read<AuthBloc>().add(
                                CallAuthEventSendOtp(
                                  phoneNumber: phoneToServer,
                                ),
                              );
                            },
                      child: isLoading
                          ? SizedBox(
                              width: 20.sp,
                              height: 20.sp,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: primaryColor,
                              ),
                            )
                          : Text(
                              'ارسال کد تایید',
                              style: AppFontStyles().firstFontStyle(
                                17.sp,
                                Colors.white,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
