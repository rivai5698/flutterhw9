class Item{
  int? id;
  String? name;
  bool? isAdd;
  int? price;
  Item(this.id, this.name, this.isAdd, this.price);


  // @override
  // bool operator == (Object other){
  //   return (other is Item) &&
  //     other.name == name &&
  //       other.id == id &&
  //       other.isAdd == isAdd &&
  //     other.price == price;
  // }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, isAdd: $isAdd, price: $price}';
  }
}
List<Item> items = [
  Item(1, 'Chicken Fries', false, 10),
  Item(2, 'Bubble Tea', false, 12),
  Item(3, 'Potatoes', false, 14),
  Item(4, 'Cole Slaw', false, 8),
  Item(5, 'Mac and Cheese', false, 5),
  Item(6, 'Biscuit', false, 7),
  Item(7, 'Pot Pie', false, 9),
  Item(8, 'Extra Crispy Tenders', false, 15),
  Item(9, 'Sandwich', false, 12),
  Item(10, 'Cookies', false, 16),
  Item(11, 'Popcorn', false, 6),
  Item(12, 'Coke', false, 3),
  Item(13, 'Pepsi', false, 4),
];