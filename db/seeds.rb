# create colleges or find existing ones
college_rows = [
  { name: 'Wake Forest' },
  { name: 'Turing'},
]
colleges = college_rows.map { |row| College.where(row).first_or_create }

# create exams, assigning each to a college, or find existing ones
exam_rows = [
  { name: 'Music 101', college: colleges.first },
  { name: 'Coding 101', college: colleges.last },
  { name: 'Final Exam', college: colleges.first },
  { name: 'Final Exam', college: colleges.last }, # exam names do not need to be unique
]
exams = exam_rows.map { |row| Exam.where(row).first_or_create }

# add exam windows to exams (exams can have multiple windows, so does not matter if any exist or not)
exam_windows = ExamWindow.create([
  { start_time: 1.day.ago, end_time: 1.day.from_now},
  { start_time: 1.day.ago },
  { start_time: 7.days.from_now, end_time: 8.days.from_now },
  { start_time: 7.days.from_now },
])
exams.each_with_index { |exam, index| exam.exam_windows << exam_windows[index] }

# No users are seeded by default. To create a user, submit a successful request to /exam_sessions or use the console