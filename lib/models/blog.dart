class Blog {
  String title;
  String imageUrl;
  DateTime time;
  String tags;
  String content;

  Blog({
    this.title,
    this.imageUrl,
    this.time,
    this.tags,
    this.content,
  });

  Blog.fromMap(Map<dynamic, dynamic> snapshot, String id)
      : title = snapshot['title'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '',
        time = snapshot['time'] ?? '',
        tags = snapshot['tags'] ?? '',
        content = snapshot['content'] ?? '';

  toJson() {
    return {
      "title": title,
      "imageUrl": imageUrl,
      "time": time,
      "tags": tags,
      "content": content,
    };
  }
}
