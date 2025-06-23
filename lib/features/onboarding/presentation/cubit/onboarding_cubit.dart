import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import 'onboarding_state.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: AppAssets.search,
      title: 'تطبيق دليلي يساعدك في الاجابه علي اسئلتك واستفساراتك حول الكليه',
      body:
          '.',
    ),
    BoardingModel(
      image: AppAssets.jobs,
      title: 'تعرف علي طاقم التدريس من خلال تطبيق دليلي',
      body:
          '.',
    ),
    BoardingModel(
      image: AppAssets.interview,
      title: 'تحدث مع بوت دليلي لفهم اعمق',
      body:
          '.',
    ),
  ];

  bool isLast = false;

  void onChangePageView(int index) {
    if (index == boarding.length - 1) {
      isLast = true;
      emit(OnChangePageViewState());
    } else {
      isLast = false;
      emit(OnChangePageViewState());
    }
  }
}
