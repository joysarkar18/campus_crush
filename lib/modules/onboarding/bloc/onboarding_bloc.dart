import 'package:bloc/bloc.dart';
import 'package:campus_crush/modules/onboarding/bloc/onboarding_event.dart';
import 'package:campus_crush/modules/onboarding/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {});
  }
}
