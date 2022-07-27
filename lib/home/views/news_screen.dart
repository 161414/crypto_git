import 'package:authentication_with_bloc/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_with_bloc/home/repository/home_repository.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(
              RepositoryProvider.of<HomeRepository>(context),
            )..add(LoadEvent()),
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadedState) {
                return ListView.builder(
                    itemCount: state.results!.length,
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.results![index].slug} news',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    });
              }
              return Container();
            },
          ),
        )));
    ;
  }
}
