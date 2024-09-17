import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_new_feature/bloc/country_list_bloc.dart';
import 'package:test_new_feature/data/model/country_list_model.dart';

import '../../state/enums.dart';

class CountryListBlocPage extends StatefulWidget {
  const CountryListBlocPage({super.key});

  @override
  State<CountryListBlocPage> createState() => _CountryListBlocPageState();
}

class _CountryListBlocPageState extends State<CountryListBlocPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountryListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Countries",style: TextStyle(color: Colors.white70),),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers : [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: Selector<CountryListBloc,List<CountryListModel>>(
                  selector: (context,bloc) => bloc.secondCountryList,
                  builder: (context,countryList,_) => HorizontalCountryListView(countryList: countryList),
                ),
              ),
            ),

            Selector<CountryListBloc,CountryState>(
              selector: (context,bloc) => bloc.countryState,
              builder: (context,countryState,_) {
                var bloc = context.read<CountryListBloc>();
                if(countryState == CountryState.error){
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_off),
                          const SizedBox(height: 10),
                          Text(bloc.errorMessage ?? ''),
                          const SizedBox(height: 10),
                          ElevatedButton(onPressed: () => bloc.getCountryList(), child: const Text('Try Again'))
                        ],
                      ),
                    ),
                  );
                }
                else if (countryState == CountryState.success) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context,index){
                          return CountryListView(countryListModel : bloc.countryList[index]);
                        },
                        childCount: bloc.countryList.length,
                      )
                  );
                }
                else {
                  return const SliverToBoxAdapter(child: Center(child:  CircularProgressIndicator()));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CountryListView extends StatelessWidget {

  final CountryListModel countryListModel;
  const CountryListView({super.key, required this.countryListModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(countryListModel.countryName?.commonName ?? ''),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                countryListModel.flag?.png ?? '',
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalCountryListView extends StatelessWidget {
  const HorizontalCountryListView({super.key, required this.countryList});

  final List<CountryListModel> countryList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(countryList[index].countryName?.commonName ?? ''),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  countryList[index].flag?.png ?? '',
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
