class Meeting{
  final String start_time;
  final String end_time;
  final String meeting_name;
  final String holder;

  const Meeting(this.start_time, this.end_time, this.meeting_name, this.holder);

  Meeting.fromJson(Map<String, dynamic> json)
    : start_time = json['start_time'],
      end_time = json['end_time'],
      meeting_name = json['meeting_name'],
      holder = json['holder'];

  Map<String, dynamic> toJson() => {
    'start_time': start_time,
    'end_time': end_time,
    'meeting_name': meeting_name,
    'holder': holder,
  };
}

final List<Map<String, dynamic>> meetings = [
  {
    'start_time': '2019-03-04-8:00',
    'end_time': '2019-03-04-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-04-11:00',
    'end_time': '2019-03-04-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-04-14:00',
    'end_time': '2019-03-04-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-04-19:00',
    'end_time': '2019-03-04-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-05-8:00',
    'end_time': '2019-03-05-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-05-11:00',
    'end_time': '2019-03-05-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-05-14:00',
    'end_time': '2019-03-05-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-05-19:00',
    'end_time': '2019-03-05-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-06-8:00',
    'end_time': '2019-03-06-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-06-11:00',
    'end_time': '2019-03-06-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-06-14:00',
    'end_time': '2019-03-06-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-06-19:00',
    'end_time': '2019-03-06-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-07-8:00',
    'end_time': '2019-03-07-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-07-11:00',
    'end_time': '2019-03-07-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-07-14:00',
    'end_time': '2019-03-07-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-07-19:00',
    'end_time': '2019-03-07-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-08-8:00',
    'end_time': '2019-03-08-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-08-11:00',
    'end_time': '2019-03-08-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-08-14:00',
    'end_time': '2019-03-08-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-08-19:00',
    'end_time': '2019-03-08-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-09-8:00',
    'end_time': '2019-03-09-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-09-11:00',
    'end_time': '2019-03-09-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-09-14:00',
    'end_time': '2019-03-09-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-09-19:00',
    'end_time': '2019-03-09-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-10-8:00',
    'end_time': '2019-03-10-10:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-10-11:00',
    'end_time': '2019-03-10-11:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-10-14:00',
    'end_time': '2019-03-10-15:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-10-19:00',
    'end_time': '2019-03-10-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-11-8:30',
    'end_time': '2019-03-10-10:15',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-11-11:00',
    'end_time': '2019-03-11-12:30',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-11-15:00',
    'end_time': '2019-03-11-16:40',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
  {
    'start_time': '2019-03-11-19:00',
    'end_time': '2019-03-11-20:00',
    'meeting_name': '伯伦希尔第一开发部例会',
    'holder': '小蓝',
  },
];