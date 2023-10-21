import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/backend_initial.dart';
import 'package:project3/src/view/authenticaton_screen/data/repo/auth_helper_body.dart';
import 'package:project3/src/view/authenticaton_screen/data/repo/auth_repo_body.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_helper_head.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_repo_head.dart';
import 'package:project3/src/view/authenticaton_screen/domain/usecase/auth_usecase.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/remote_data.dart';
import 'package:project3/src/view/main_screens/data/model/backend_db_model.dart';
import 'package:project3/src/view/main_screens/data/repo/backend/backend_db_helper_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/backend/backend_db_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/cart_db_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/chat_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/contact_db_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/contacts_db_helper_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/favorite_db_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/payment_card_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/products_repo_body.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_helper_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/cart_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/chat_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/contact_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/contacts_db_helper_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/favorite_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/payment_card_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/products_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/usecse/backend_db_usecase.dart';
import 'package:project3/src/view/main_screens/domain/usecse/cart_db_usecase.dart';
import 'package:project3/src/view/main_screens/domain/usecse/chat_usecase.dart';
import 'package:project3/src/view/main_screens/domain/usecse/cotact_db_usecase.dart';
import 'package:project3/src/view/main_screens/domain/usecse/favorite_db_usecaes.dart';
import 'package:project3/src/view/main_screens/domain/usecse/payment_card_usecase.dart';
import 'package:project3/src/view/main_screens/domain/usecse/products_usecase.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/favorite_db_bloc/favorite_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/payment_card_bloc/payment_card_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';

final GetIt locator = GetIt.instance;

Future getItSetup() async {
  locator.registerSingleton<ThemeCubit>(ThemeCubit());



  locator.registerSingleton<AuthRepoHead>(AuthRepoBody());
  locator.registerSingleton<AuthHelperHead>(AuthHelperBody(locator()));
  locator.registerSingleton<AuthUseCase>(AuthUseCase(authRepo: locator()));
  locator.registerSingleton<AuthBloc>(AuthBloc(locator()));

  locator.registerSingleton<ApiProvider>(ApiProvider());
  locator.registerSingleton<ProductsRepoHeader>(ProductsRepoBody(locator()));
  locator.registerSingleton<ProductsUseCase>(ProductsUseCase(locator()));
  locator.registerSingleton<ProductsBloc>(ProductsBloc(locator()));

  locator.registerSingleton<CartDBRepoHeader>(CartDBRepoBody());
  locator.registerSingleton<CartDBUseCase>(CartDBUseCase(locator()));
  locator.registerSingleton<CartDbBloc>(CartDbBloc(locator()));

  locator.registerSingleton<FavoriteDBRepoHeader>(FavoriteDBRepoBody());
  locator.registerSingleton<FavoriteDBUseCase>(FavoriteDBUseCase(locator()));
  locator.registerSingleton<FavoriteDbBloc>(FavoriteDbBloc(locator()));

  Storage storage = Storage(BackendInitial.instance.client);
  Databases databases = Databases(BackendInitial.instance.client);
  Account account = Account(BackendInitial.instance.client);
  locator.registerSingleton<BackendDBRepoHeader>(BackendDBRepoBody(locator(), storage, databases,account));
  locator.registerSingleton<BackendDBHelperRepoHeader>(BackendDBHelperRepoBody(locator()));
  locator.registerSingleton<BackendDBUseCase>(BackendDBUseCase(locator()));
  locator.registerSingleton<BackendDbBloc>(BackendDbBloc(locator()));

  locator.registerSingleton<ChatRepoHeader>(ChatRepoBody());
  locator.registerSingleton<ChatUseCase>(ChatUseCase(locator()));
  locator.registerSingleton<ChatBloc>(ChatBloc(locator()));

  locator.registerSingleton<ContactDBRepoHeader>(ContactDBRepoBody());
  locator.registerSingleton<ContactsDBHelperRepoHeader>(ContactsDBHelperRepoBody(locator()));
  locator.registerSingleton<ContactDBUsecase>(ContactDBUsecase(locator()));
  locator.registerSingleton<ContactDbBloc>(ContactDbBloc(locator()));

  locator.registerSingleton<PaymentCardRepoHeader>(PaymentCardRepoBody());
  locator.registerSingleton<PaymentCardUsecase>(PaymentCardUsecase(locator()));
  locator.registerSingleton<PaymentCardBloc>(PaymentCardBloc(locator()));
}
