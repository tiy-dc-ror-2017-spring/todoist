require "httparty"

class TodoCli
  attr_reader :args
  def initialize(args)
    @args = args

    # Extract the "subcommand"
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
    else
      usage
    end
  end

  def create_task
    Development.new.create_new_task, { name: @args.second, priority: args.third }.to_json
  end

  def create_list
    Development.new.create_new_list, { name: @args.second }.to_json
  end

  def add_task
    list_to_add_to = List.all.where(name: @args.second).first
    task_to_add = Task.all.where(name: @args.third).first
    Development.new.add_task_to_list(list_to_add_to.id, task_to_add.id)
  end

  def complete
    task = Task.where(name: @args.second).first
    Development.new.complete_tasks(task.id), { completed_at: Time.now }
  end

  def list_tasks
    Development.new.get_tasks
  end

  def usage
    "Please choose between from create_task, create_list, add_task, complete, or display_all."
  end
end
