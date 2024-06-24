class book_models {
  late String bk_booktype;
  late String bk_prayertype;
  late String bk_prdate;
  late String bk_slot;
  late String status;
  late String bid;

  book_models({
    required this.bk_booktype,
    required this.bk_prayertype,
    required this.bk_prdate,
    required this.bk_slot,
    required this.status,
    required this.bid,
  });
}

class allbook_models {
  late String ch_nm;
  late String bk_booktype;
  late String bk_prayertype;
  late String bk_prdate;
  late String bk_slot;
  late String status;
  late String bid;
  late String img;

  allbook_models({
    required this.ch_nm,
    required this.bk_booktype,
    required this.bk_prayertype,
    required this.bk_prdate,
    required this.bk_slot,
    required this.status,
    required this.bid,
    required this.img,
  });
}

class pending_models {
  late String b_id;
  late String user_id;
  late String booktype;
  late String prayertype;
  late String pr_date;
  late String slot;
  late String sts;

  pending_models({
    required this.b_id,
    required this.user_id,
    required this.booktype,
    required this.prayertype,
    required this.pr_date,
    required this.slot,
    required this.sts,
  });
}

class Upcoming_models {
  late String b_id;
  late String user_id;
  late String booktype;
  late String prayertype;
  late String pr_date;
  late String slot;
  late String sts;

  Upcoming_models({
    required this.b_id,
    required this.user_id,
    required this.booktype,
    required this.prayertype,
    required this.pr_date,
    required this.slot,
    required this.sts,
  });
}

class completed_models {
  late String b_id;
  late String user_id;
  late String booktype;
  late String prayertype;
  late String pr_date;
  late String slot;
  late String sts;

  completed_models({
    required this.b_id,
    required this.user_id,
    required this.booktype,
    required this.prayertype,
    required this.pr_date,
    required this.slot,
    required this.sts,
  });
}
