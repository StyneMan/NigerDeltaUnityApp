class DirectoriesModel {
  String image;
  String category;
  double rating;

  DirectoriesModel(
      {required this.image, required this.rating, required this.category});
}

List<DirectoriesModel> directoriesList = [
  DirectoriesModel(
      category: 'Restaurant',
      image:
          'https://images.unsplash.com/photo-1502301103665-0b95cc738daf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
      rating: 4.3),
  DirectoriesModel(
      category: 'Hotels',
      image:
          'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
      rating: 4.0),
  DirectoriesModel(
      category: 'Boutique',
      image:
          'https://media.istockphoto.com/photos/this-one-match-perfect-with-me-picture-id1293366109?b=1&k=20&m=1293366109&s=170667a&w=0&h=2z_h2WlM3291IRKFXrdmtObnCt93rNNdNN6mqvnKD1I=',
      rating: 4.2),
  DirectoriesModel(
      category: 'Events',
      image:
          'https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZXZlbnRzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
      rating: 4.5),
  DirectoriesModel(
      category: 'Sports',
      image:
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHNwb3J0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      rating: 4.2),
];
