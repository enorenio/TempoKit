import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/home/project/column_view.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';

class ColumnCarousel extends StatefulWidget {
  _ColumnCarouselState createState() => _ColumnCarouselState();
}

class _ColumnCarouselState extends State<ColumnCarousel> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetColumnsAndTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is HomeError) {
        showError(context, state);
      } else if (state is ColumnsAndTasksState) {
        if (state.columnsAndTasks.length > 0) {
          return SizedBox(
            // you may want to use an aspect ratio here for tablet support
            // height: 245.0,
            child: PageView.builder(
              // store this controller in a State to save the carousel scroll position
              physics: BouncingScrollPhysics(),
              controller: PageController(viewportFraction: 0.8),
              itemCount: state.columnsAndTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ColumnView(
                  columnAndTasks: state.columnsAndTasks[index],
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('No columns created yet'),
          );
        }
      }
      return tempWidget;
    });
  }
}