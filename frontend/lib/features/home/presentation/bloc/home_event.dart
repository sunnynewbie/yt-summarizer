abstract class HomeEvent{
}
class SubmitForm extends HomeEvent{
  String data;
  SubmitForm(this.data);
}