class Post {
  String id, title, content, date_written, featured_image;
  int votes_up, votes_down;
  List<int> voters_up, voters_down;
  int user_id;
  String  autherName, autherAvater;
  int category_id;
  String  categoryTitle;
  Post(
      {this.id,
      this.title,
      this.content,
      this.date_written,
      this.featured_image,
      this.votes_up,
      this.votes_down,
      this.voters_up,
      this.voters_down,
      this.user_id,
      this.autherName,
      this.autherAvater,
      this.category_id,
      this.categoryTitle});
}
