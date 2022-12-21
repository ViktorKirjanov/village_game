import 'package:flutter_bloc/flutter_bloc.dart';

class DialogCubit extends Cubit<String?> {
  DialogCubit() : super(null);

  void addDialog(String text) => emit(text);

  void removeDialog() => emit(null);
}
