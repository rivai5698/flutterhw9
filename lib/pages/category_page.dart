import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw9/category_bloc/category_bloc.dart';
import 'package:flutterhw9/pages/cart_page.dart';
import '../model/item.dart' as it;

class CategoryPage extends StatefulWidget {
  final List<it.Item> items;
  final List<it.Item> cart;
  const CategoryPage({super.key, required this.items, required this.cart});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //final List<it.Item> items = [];
  final CategoryCubit _categoryCubit = CategoryCubit();

  @override
  void initState() {
    // TODO: implement initState
    //items.addAll(it.items);
    print('Catepage: ${widget.items}');
    //_categoryCubit.getItemCart(widget.cart);
    _categoryCubit.getCart();
    _categoryCubit.getItem(widget.items);

    super.initState();
  }
  void myInitState(CategoryCubit categoryCubit) async {
    await _categoryCubit.getCart();
    await _categoryCubit.getItem(widget.items);
  }

  @override
  void setState(VoidCallback fn) {
    _categoryCubit.getItem(widget.items);
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //myInitState(_categoryCubit);
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<CategoryCubit, CategoryState>(
              bloc: _categoryCubit,
              builder: (ctx, state) {
                return cart(_categoryCubit.cart.length, _categoryCubit.cart.isNotEmpty);

              }),
        ],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (ctx, state) {
          if (state is CategoryGettingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryGetSuccessState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _categoryCubit.items.length,
              itemBuilder: (BuildContext context, int index) {
                return item(_categoryCubit.items[index],
                    _categoryCubit.items[index].isAdd);
              },
            );
          }
          if (state is CategoryAddState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _categoryCubit.items.length,
              itemBuilder: (BuildContext context, int index) {
                return item(_categoryCubit.items[index],
                    _categoryCubit.items[index].isAdd);
              },
            );
          }

          return const Center(
            child: Text('Empty'),
          );
        },
      ),
    );
  }

  Widget cart(int total, bool hasItems) {
    if (total > 0) {
      hasItems = true;
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => CartPage(
                              cart: _categoryCubit.cart,
                              items: widget.items,
                            )));
                //_categoryCubit.getItemCart();
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Stack(
          children: [

            const Positioned.fill(
                child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            )),
            Visibility(
              visible: hasItems,
              child: Positioned(
                  right: 15,
                  top: 5,
                  child: Text(
                    '$total',
                    style: const TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(it.Item item, bool? vis) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 80,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${item.name}',
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(
                        visible: vis!,
                        child: const Positioned(
                          child: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                        )),
                    Visibility(
                      visible: !vis,
                      child: Positioned(
                        child: GestureDetector(
                          onTap: () {
                            _categoryCubit.addCartItems(item);
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
