import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/config/app_config/app_inputs/otp_input.dart';
import 'package:makeupflutter/config/app_config/app_local_storage/app_local_storage.dart';
import 'package:makeupflutter/config/app_config/app_shapes/border_radius.dart';
import 'package:makeupflutter/config/app_config/app_shapes/media_query.dart';
import 'package:makeupflutter/features/auth_features/logic/auth_bloc.dart';
import 'package:makeupflutter/features/auth_features/services/auth_api_services.dart';
import 'package:makeupflutter/features/home_features/screen/home_screen.dart';
import 'package:makeupflutter/features/public_features/widget/snack_bar.dart';
import 'package:uuid/uuid.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({super.key});

  static const String screenId = 'confirmOtp';

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  dynamic _otpCode = '';
  late LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final phoneNum = args['phoneNum'];

    void setToken() async {
      final uuid = Uuid();
      String createToken = uuid.v4();
      localStorage = await LocalStorage.getInstance();
      final setToken = await localStorage.set('token', createToken);
    }

    return BlocProvider(
      create: (context) => AuthBloc(AuthApiServices()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'تایید تلفن همراه',
            style: AppFontStyles().firstFontStyle(20.sp, Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.only(right: 20.sp),
              child: Row(
                children: [
                  Text(
                    'کد تایید را وارد کنید',
                    style: AppFontStyles().firstFontStyle(19.sp, Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                'پیامک حاوی کد 6 رقمی به شماره شما ارسال شد , آن را در کادر پایین وارد کنید',
                style: AppFontStyles().firstFontStyle(17.sp, Colors.black),
              ),
            ),
            OtpInput(
              onCompleted: (otp) {
                setState(() {
                  _otpCode = otp;
                });
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 30.sp),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthConfirmOtpCompletedState) {
                    getSnackBarWidget(
                      context,
                      'ورود با موفقیت انجام شد',
                      Colors.green,
                    );
                    setToken();

                    Future.delayed(
                      Duration(seconds: 1),
                      () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.screenId,
                        (route) => false,
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
                        getAllWidth(context) - 10.sp,
                        getHeight(context, 0.05.sp),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: getBorderRadiusFunc(10.sp),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                              CallConfirmOtp(
                                phoneNumber: phoneNum,
                                otp: _otpCode,
                              ),
                            );
                          },
                    child: isLoading
                        ? SizedBox(
                            width: 20.sp,
                            height: 20.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'ورود به اپلیکیشن',
                            style: AppFontStyles().firstFontStyle(
                              17.sp,
                              Colors.black,
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
