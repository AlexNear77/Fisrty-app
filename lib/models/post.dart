class Post {
  String? id;
  String? description;
  bool isDone;

  Post({required this.id, required this.description, this.isDone = false});

  static List<Post> PostList() {
    return [
      Post(id: '01', description: 'Messi Messi en cara Messi'),
      Post(id: '02', description: 'Messi Messi en cara Messi'),
      Post(id: '03', description: 'Goool Gooool Goool'),
      Post(id: '04', description: 'Goool Gooool Goool'),
      Post(id: '05', description: 'Goool Gooool Goool'),
      Post(id: '06', description: '*Back ground Sound'),
      Post(id: '07', description: 'Tururururururururu'),
    ];
  }
}
