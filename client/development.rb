require "httparty"
require "pry"

class Development
  attr_reader :base_url

  def initialize(base_url)
    @base_url = base_url
  end

  def get_tasks
    HTTParty.get("#{base_url}tasks")
  end

  def complete_tasks(task_id)
    HTTParty.patch("#{base_url}tasks/#{task_id}", completed_at: Time.now.to_json)
  end

  def add_task_to_list(list_to_add_to, task_id)
    HTTParty.patch("#{base_url}tasks/#{task_id}", body: list_to_add_to.to_json)
  end

  def create_new_task(task_data)
    HTTParty.post("#{base_url}tasks", body: task_data.to_json)
  end

  def create_new_list(list_data)
    HTTParty.post("#{base_url}lists", body: list_data.to_json)
  end

  def display_lists
    HTTParty.get("#{base_url}lists")
  end

  def display_complete
    HTTParty.get("#{base_url}tasks/complete")
  end
end
