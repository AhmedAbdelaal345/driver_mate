import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/splach/manager/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplachPage extends StatelessWidget {
  const SplachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startAnimation(),
      child: const _SplachPageView(),
    );
  }
}

class _SplachPageView extends StatelessWidget {
  const _SplachPageView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          Navigator.of(context).pushNamed(AppConstants.loginPage);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppConstants.veryDarkBlue,
                AppConstants.darkBlue,
                AppConstants.blue,
              ],
            ),
          ),
          child: Stack(
            children: [
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  final isStart =
                      state is SplashAnimationStart || state is SplashNavigate;
                  return Positioned(
                    top: SizeConfig.height(context) * 0.1,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: TweenAnimationBuilder<int>(
                        tween: IntTween(
                          begin: 0,
                          end: isStart ? AppConstants.driverMate.length : 0,
                        ),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, child) {
                          return Text(
                            AppConstants.driverMate.substring(0, value),
                            style: TextStyle(
                              color: AppConstants.white,
                              fontSize: AppConstants.f32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  final isStart =
                      state is SplashAnimationStart || state is SplashNavigate;
                  return AnimatedPositioned(
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    bottom: SizeConfig.height(context) * 0.1,
                    left: isStart ? 0 : -SizeConfig.width(context),
                    right: isStart ? 0 : SizeConfig.width(context),
                    child: Image.asset(
                      AppConstants.carPath,
                      fit: BoxFit.scaleDown,
                      height: SizeConfig.height(context) * 0.18,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
