require "httparty"
require_relative "development"
class TodoCli
  attr_reader :args, :client
  def initialize(args)
    @args = args
    @client = Development.new("http://localhost:4567/")

    case @args.first
    when "create_task"
      create_task
    when "create_list"
      create_list
    when "add_task"
      add_task
    when "complete"
      complete
    when "display_all"
      list_tasks
    when "display_complete"
      display_complete
    when "display_lists"
      display_lists
    else
      usage
    end
  end

  def create_task
    client.create_new_task({ name: args[1], priority: args[2] })
    puts "You have created #{args[1]}"
  end

  def create_list
    client.create_new_list({ name: args[1] })
    puts "You have created #{args[1]}"
  end

  def add_task
    puts "What task would you like to add? Please type in ID number."
    list_tasks
    task_id = STDIN.gets.chomp
    puts "What list would you like to add this task too? Please type in ID number."
    display_lists
    list = STDIN.gets.chomp
    list_to_add_to = { list_id: list }
    client.add_task_to_list(list_to_add_to, task_id)
  end

  def complete
    puts "Which task would you like to complete? Please type in ID number"
    list_tasks
    task_id = STDIN.gets.chomp
    complete = { completed_at: Time.now }
    client.complete_tasks(task_id, complete)
  end

  def display_complete
    client.display_complete
  end

  def list_tasks
    tasks = client.get_tasks
    tasks.each { |el| puts el["name"], el["id"] }
  end

  def usage
    "Please choose between from create_task, create_list, add_task, complete, or display_all."
  end

  def display_lists
    lists = client.display_lists
    lists.each { |el| puts el["name"], el["id"] }
  end
end
