class Categories {
  String? image;
  String? title;

  Categories({required this.image, required this.title});
}

List<Categories> categoriesList = [
  Categories(
      image:
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHNwb3J0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      title: 'Sports'),
  Categories(
      image:
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZmFzaGlvbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      title: 'Fashion'),
  Categories(
      image:
          'https://images.unsplash.com/photo-1602327850706-eadbbd6a1522?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8ZW5kJTIwc2Fyc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      title: 'World'),
  Categories(
      image:
          'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      title: 'Food'),
];
