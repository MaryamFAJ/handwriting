import 'package:bloc/bloc.dart';
import 'package:handwriting/slider//pages/About_us.dart';
import 'package:handwriting/slider/pages/FAQs.dart';
import 'package:handwriting/slider/pages/Contact_us.dart';
import 'package:handwriting/slider/pages/Services.dart';
import 'package:handwriting/home.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  AboutUsClickedEvent,
  ContactUSClickedEvent,
  FAQsClickedEvent,
  ServicesClickedEvent,

}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => FirstRoute();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield FirstRoute();
        break;
      case NavigationEvents.AboutUsClickedEvent:
        yield AboutUs();
        break;
      case NavigationEvents.ContactUSClickedEvent:
        yield ContactUs();
        break;
      case NavigationEvents.FAQsClickedEvent:
        yield FAQ();
        break;
      case NavigationEvents.ServicesClickedEvent:
        yield Services();
        break;
    }
  }
}
