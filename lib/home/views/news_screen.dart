import 'package:authentication_with_bloc/home/bloc/home_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_with_bloc/home/repository/home_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'description_view.dart';

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
                      return ListTile(
                        leading: Text(
                          timeago.format(
                              state.results![index].publishedAt
                                  .subtract(const Duration(minutes: 1)),
                              locale: 'en_short'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        title: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '${state.results![index].title} news',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          WidgetSpan(
                              child: Icon(
                            Icons.link_outlined,
                            color: Colors.grey,
                            size: 15.0,
                          )),
                          TextSpan(
                              text: '${state.results![index].domain} ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DescriptionView(
                                            index: index, state: state)),
                                  );
                                }),
                        ])),
                       // trailing: Text('${state.results![index].createdAt}'),
                      );
                    });
              }
              return Container();
            },
          ),
        )));
  }
}
