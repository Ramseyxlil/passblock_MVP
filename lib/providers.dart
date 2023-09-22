//
//  password_manager
//  providers
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter_bloc/flutter_bloc.dart';

import 'passblock/state/autofill_bloc.dart';
import 'shared/state/connectivity_status/connectivity_status_bloc.dart';
import 'shared/state/navigation/navigation_bloc.dart';

List<BlocProvider> providers = [
  BlocProvider<ConnectivityStatusBloc>(
    lazy: false,
    create: (_) => ConnectivityStatusBloc(),
  ),
  BlocProvider<NavigationBloc>(
    create: (_) => NavigationBloc(),
  ),
  BlocProvider<AutofillBloc>(
    create: (_) => AutofillBloc(),
  )
];
