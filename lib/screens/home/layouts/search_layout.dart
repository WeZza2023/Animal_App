import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:animal_app/screens/view_animal/view_animal_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLayout extends StatelessWidget {
  const SearchLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Column(
        children: [
          cubit.searchModel == null || state is SearchAnimalLoadingState
              ? AppLoadingProgress()
              : cubit.searchModel!.data!.isEmpty
                  ? BodyLargeText(S.of(context).thereIsNoAnimalWithThisName)
                      .tP25
                  : Wrap(spacing: 12, children: [
                      for (int i = 0; i < cubit.searchModel!.data!.length; i++)
                        SearchItem(
                            image: cubit.searchModel!.data![i].images!.isEmpty
                                ? "https://static.vecteezy.com/system/resources/previews/004/968/529/original/search-no-results-found-concept-illustration-flat-design-eps10-simple-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-with-editable-stroke-line-outline-linear-vector.jpg"
                                : cubit.searchModel!.data![i].images![0].path!,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) {
                                      return ViewAnimalSearchScreen(
                                        outIndex: i,
                                      );
                                    },
                                  ));
                            },
                            subTitle: cubit.searchModel!.data![i].sex!,
                            age: cubit.searchModel!.data![i].age!,
                            name: cubit.searchModel!.data![i].title!,
                            location: cubit.searchModel!.data![i].location!)
                    ]),
        ],
      ),
    );
  }
}
