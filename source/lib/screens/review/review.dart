import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Review extends StatefulWidget {
  final ProductModel product;

  const Review({Key? key, required this.product}) : super(key: key);

  @override
  State<Review> createState() {
    return _ReviewState();
  }
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    super.initState();
    AppBloc.reviewCubit.onLoad(widget.product.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await AppBloc.reviewCubit.onLoad(widget.product.id);
  }

  ///On navigate write review
  void _onWriteReview() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.writeReview,
      );
      if (result != Routes.writeReview) {
        return;
      }
    }
    if (!mounted) return;
    Navigator.pushNamed(
      context,
      Routes.writeReview,
      arguments: widget.product,
    );
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    Navigator.pushNamed(context, Routes.profile, arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('review'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('write'),
            onPressed: _onWriteReview,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ReviewCubit, ReviewState>(
          builder: (context, state) {
            RateModel? rate;

            ///Loading
            Widget content = ListView(
              children: List.generate(8, (index) => index).map(
                (item) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: AppCommentItem(),
                  );
                },
              ).toList(),
            );

            ///Success
            if (state is ReviewSuccess) {
              rate = state.rate;

              ///Empty
              if (state.list.isEmpty) {
                content = Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.sentiment_satisfied),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          Translate.of(context).translate('review_not_found'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                content = RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      final item = state.list[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCommentItem(
                          item: item,
                          onPressUser: () {
                            _onProfile(item.user);
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor.withOpacity(
                                .05,
                              ),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(
                            0,
                            2,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: AppRating(rate: rate),
                  ),
                  Expanded(child: content),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
