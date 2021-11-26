class DirectorySubModel {
  String image;
  String title;
  String address;
  double rating;
  String time;

  DirectorySubModel(
      {required this.image,
      required this.title,
      required this.address,
      required this.rating,
      required this.time});
}

List<DirectorySubModel> directoryBannerList = [
  DirectorySubModel(
      address: "GRA Phase 2",
      image:
          "https://images.unsplash.com/photo-1502301103665-0b95cc738daf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
      rating: 4.3,
      time: "25mins",
      title: "Buns & Barter"),
  DirectorySubModel(
      address: "Lekki Phase 1",
      image:
          "https://media.istockphoto.com/photos/hot-dogs-for-game-day-picture-id1326146587?b=1&k=20&m=1326146587&s=170667a&w=0&h=PXRYyxj4ZN5HXPzQIRG8t5a-B4Np0z-vqVWlRYDQ7g4=",
      rating: 4.2,
      time: "30mins",
      title: "Chips & Fries"),
  DirectorySubModel(
      address: "Stadium Road, Port Harcourt.",
      image:
          "https://images.unsplash.com/photo-1606728035253-49e8a23146de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpY2tlbiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
      rating: 4.5,
      time: "15mins",
      title: "Chicken Republic"),
  DirectorySubModel(
      address: "GRA Phase 2",
      image:
          "https://images.unsplash.com/photo-1502301103665-0b95cc738daf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
      rating: 4.3,
      time: "25mins",
      title: "Buns & Barter"),
  DirectorySubModel(
      address: "Stadium Road, Port Harcourt.",
      image:
          "https://images.unsplash.com/photo-1606728035253-49e8a23146de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpY2tlbiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
      rating: 4.5,
      time: "15mins",
      title: "Chicken Republic"),
];

class FeaturedVendorsModel {
  String photo;
  String image;
  String title;
  String name;
  String address;
  double rating;
  String time;
  String delivery;
  bool isOpen;

  FeaturedVendorsModel(
      {required this.image,
      required this.photo,
      required this.title,
      required this.address,
      required this.rating,
      required this.time,
      required this.name,
      required this.delivery,
      required this.isOpen});
}

List<FeaturedVendorsModel> vendorsList = [
  FeaturedVendorsModel(
    image:
        'https://media.istockphoto.com/photos/large-american-style-pepperoni-and-cheese-pizza-in-cardboard-delivery-picture-id1256339158?b=1&k=20&m=1256339158&s=170667a&w=0&h=XFNxZmudE_SZqqz3-nrIM6dCvvfuxU8xrvDLYkFHFAg=',
    title: 'Pizza',
    address: 'Olu-Obasanjo road...',
    rating: 4.2,
    time: '25mins',
    name: 'Dominos',
    delivery: 'Free Delivery',
    isOpen: true,
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
  ),
  FeaturedVendorsModel(
    image:
        'https://images.unsplash.com/photo-1606728035253-49e8a23146de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpY2tlbiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
    title: 'Waffle',
    address: 'Sani Abacha road by...',
    rating: 3.8,
    time: '55mins',
    name: 'Dominos',
    delivery: '',
    isOpen: false,
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
  ),
  FeaturedVendorsModel(
    image:
        'https://media.istockphoto.com/photos/large-american-style-pepperoni-and-cheese-pizza-in-cardboard-delivery-picture-id1256339158?b=1&k=20&m=1256339158&s=170667a&w=0&h=XFNxZmudE_SZqqz3-nrIM6dCvvfuxU8xrvDLYkFHFAg=',
    title: 'Pizza',
    address: 'Olu-Obasanjo road...',
    rating: 4.2,
    time: '25mins',
    name: 'Dominos',
    delivery: 'Free Delivery',
    isOpen: false,
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
  ),
];
