import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw9/model/item.dart' as it;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit():super(CategoryInitState());
  List<it.Item> items = [];
  List<it.Item> cart = [];
  SharedPreferences? sharedPreferences;


  getItem(List<it.Item> lists)async{
    items.clear();
    print("cart after save: $cart");
    for(it.Item item in cart){
      for(it.Item iteml in lists){
        if(item == iteml){
          iteml.isAdd=true;
        }
      }
    }
    items.addAll(lists);
    emit(CategoryGettingState());

   // print('get items: $items');

    Future.delayed(const Duration(seconds: 1),(){
      emit(CategoryGetSuccessState());
    });


  }



  addCartItems(it.Item item) async {
      if(!cart.contains(item)){
        cart.add(item);
      }
      for(int i=0;i<items.length;i++){
          for(int j=0;j<cart.length;j++){
            if(items[i].id==cart[j].id) {
              items[i].isAdd = true;
            }
          }
      }
      print('Cart: $cart');
      emit(CategoryAddState());
      await saveCart();

      // Future.delayed(const Duration(seconds: 1),(){
      //   getItemCart();
      //   emit(CategoryCartSuccessState());
      // });
  }


  getItemCart(List<it.Item> items) async {
     for(it.Item itemz in items){
      if(!cart.contains(itemz)){
        cart.addAll(items);
      }
    }
    emit(CategoryCartGetState());
    print('get cart: $cart');
    Future.delayed(const Duration(seconds: 1),(){
      if(cart.isNotEmpty){
        emit(CategoryCartSuccessState());
      }else{
        emit(CategoryEmptyState());
      }
    });
    //await saveCart();
  }

  removeCartItems(it.Item item) async {
    if(cart.isNotEmpty){
      for(int i=0;i<cart.length;i++){
        cart.removeWhere((element) => element.id == item.id);
      }

      for (it.Item item in items){
          if(!cart.contains(item)){
              item.isAdd = false;
          }
      }

      print('After remove: $items');
      emit(CategoryCartSuccessState());
      if(cart.isEmpty||cart.length==0){
        emit(CategoryCartEmptyState());
      }

    }else{
      emit(CategoryCartEmptyState());
    }
    await saveCart();
  }

  Future saveCart() async {

    List<String> listDataString =[];

    for(it.Item item in cart){
      // model => map
      Map<String, dynamic> dataJson = Map<String, dynamic>();
      dataJson['id'] = item.id;
      dataJson['name'] = item.name;
      dataJson['isAdd'] = item.isAdd;
      dataJson['price'] = item.price;

      //map => string
      String dataString = jsonEncode(dataJson);
      listDataString.add(dataString);
    }
    if(sharedPreferences==null){
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences!.setStringList('data', listDataString);
  }

  Future getCart() async{
    if(sharedPreferences==null){
      sharedPreferences = await SharedPreferences.getInstance();
    }
    List<String>? data = sharedPreferences!.getStringList('data');
    if(data!=null){
      for(String str in data){
        //string => map
        Map<String,dynamic> dataMap = jsonDecode(str);
        //map => model
        it.Item item =  it.Item(null, null, null, null);
        item.id = dataMap['id'];
        item.name = dataMap['name'];
        item.isAdd = dataMap['isAdd'];
        item.price = dataMap['price'];
        if(!cart.contains(item)){
          cart.add(item);
        }


      }
    }
  }

}

class CategoryState{}

class CategoryInitState extends CategoryState{}

class CategoryRemoveState extends CategoryState{}

class CategoryAddState extends CategoryState{}

class CategoryEmptyState extends CategoryState{}

class CategoryGettingState extends CategoryState{}

class CategoryGetSuccessState extends CategoryState{}

class CategoryCartSuccessState extends CategoryState{}

class CategoryCartGetState extends CategoryState{}

class CategoryCartEmptyState extends CategoryState{}