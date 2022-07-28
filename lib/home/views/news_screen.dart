import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:crypto_currency/constants/constants.dart';
import 'package:crypto_currency/home/bloc/home_bloc.dart';
import 'package:crypto_currency/home/repository/home_repository.dart';

import 'description_view.dart';

///create stateless widget to display the news
class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(
              RepositoryProvider.of<HomeRepository>(context),
            )..add(LoadEvent()),
        child: Scaffold(
            body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            Future.delayed(const Duration(seconds: 10), () {
              context.read<HomeBloc>().add(LoadEvent());
            });
          },
          builder: (contex, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }
            if (state is HomeLoadedState) {
              /// To refresh the page
              return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(LoadEvent());
                  },
                  child: ListView.builder(
                      itemCount: state.results!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Text(
                                timeago.format(

                                    /// list out  the  published time
                                    state.results![index].publishedAt
                                        .subtract(const Duration(minutes: 1)),
                                    locale: 'en_short'),
                                style: kDomainStyle,
                              ),
                              title: Text(
                                /// list out the news title
                                '${state.results![index].slug} news',
                                style: kTextStyle,
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.link_outlined,
                                    color: Colors.grey,
                                    size: 15.0,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        /// Navigate to Description page
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DescriptionView(
                                                        index: index,
                                                        state: state)));
                                      },
                                      child: Text(
                                        /// display the Domain of the news
                                        '${state.results![index].domain}',
                                        style: kDomainStyle,
                                      )),
                                ],
                              ),
                              trailing: Text(
                                /// Display the currency of corresponding news
                                '${state.results![index].currencies?[0].code ?? ''}',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 1.0,
                            )
                          ],
                        );
                      }));
            }
            return Container();
          },
        )));
  }
}
