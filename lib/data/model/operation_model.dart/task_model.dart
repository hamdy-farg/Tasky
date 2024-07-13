class TaskModel {
  String? id;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TaskModel(
      {this.id,
      this.image,
      this.title,
      this.desc,
      this.priority,
      this.status,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class RequistTaskModel {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? dueDate;

  RequistTaskModel(
      {this.image, this.title, this.desc, this.priority, this.dueDate});

  RequistTaskModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['priority'] = this.priority;
    data['dueDate'] = this.dueDate;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString

    return ("image : ${this.image} , title : ${this.title} , desc : ${this.desc} ,prioritu : ${this.priority} duedate : ${this.dueDate}");
  }
}
