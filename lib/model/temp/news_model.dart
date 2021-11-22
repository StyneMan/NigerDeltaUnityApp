class NewsModel {
  String? category;
  String? title;
  String? body;
  String? image;

  NewsModel(
      {required this.body,
      required this.category,
      required this.image,
      required this.title});
}

List<NewsModel> newsList = [
  NewsModel(
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem magna condimentum neque, maecenas id ut diam tristique aenean. Nullam auctor diam, elit tincidunt. Elit ipsum magna lacus, vulputate...',
      category: 'World news',
      image:
          'https://images.unsplash.com/photo-1603377583150-869f5bdf263b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZW5kJTIwc2Fyc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
      title: 'End police brutality'),
  NewsModel(
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem magna condimentum neque, maecenas id ut diam tristique aenean. Nullam auctor diam, elit tincidunt. Elit ipsum magna lacus, vulputate...',
      category: 'Sports news',
      image:
          'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      title: 'Tokyo Olympics 2020')
];
