class Pagination {
  final int currentPage;
  final int limit;
  final int skip;
  final int total;
  final int totalPage;

  Pagination({
    required this.currentPage,
    required this.limit,
    required this.skip,
    required this.total,
    required this.totalPage,
  });

  factory Pagination.empty() {
    return Pagination(
      currentPage: 1,
      limit: 20,
      skip: 0,
      total: 0,
      totalPage: 0,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int,
      limit: json['limit'] as int,
      skip: json['skip'] as int,
      total: json['total'] as int,
      totalPage: json['total_page'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'limit': limit,
      'skip': skip,
      'total': total,
      'total_page': totalPage,
    };
  }
}
