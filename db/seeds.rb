# frozen_string_literal: true

first_list = List.create(title: 'The First List', description: 'The first todo list of November')
second_list = List.create(title: 'My Second List', description: 'My second todo list of November')

5.times do |number|
  first_list.create_task(title: "Task ##{number}")
  second_list.create_task(title: "Task ##{number}")
end
