require_relative "test_helper"
require "json"

class TodoCliTest < Minitest::Test
attr_reader :client

  def setup
    @client = Development.new("http://localhost:4567/")
  end

  def teardown
    Task.delete_all
    List.delete_all
  end

  def test_create_new_task
    stub_request(:post, "http://localhost:4567/tasks").to_return(body: File.read("./stubbed_requests/post_tasks.json"), headers: { "Content-Type" => "application/json" })
    task = client.create_new_task({name: "Tastey Cakes", priority: "Urgent"})
    assert_equal task["name"], "Tastey Cakes"
  end

  def test_create_list
    stub_request(:post, "http://localhost:4567/lists").to_return(body: File.read("./stubbed_requests/post_lists.json"), headers: { "Content-Type" => "application/json" })
    list = client.create_new_list({name: "Food"})
    assert_equal list["name"], "Food"
  end

  def test_add_task_to_list
    stub_request(:get, "http://localhost:4567/lists/1/tasks/1").to_return(body: File.read("./stubbed_requests/list_tasks.json"), headers: { "Content-Type" => "application/json" })
    client.add_task_to_list("1", "1")
  end

  def test_complete
    stub_request(:patch, "http://localhost:4567/tasks/1").to_return(body: File.read("./stubbed_requests/complete_task.json"), headers: { "Content-Type" => "application/json" })
    assert_equal 1, client.complete_tasks("1")["id"]
  end

  def test_display_all
    stub_request(:get, "http://localhost:4567/tasks").to_return(body: File.read("./stubbed_requests/get_tasks.json"), headers: { "Content-Type" => "application/json" })
    assert_equal 1, client.get_tasks["id"]
  end

  def test_diplay_complete
    stub_request(:get, "http://localhost:4567/tasks/complete").to_return(body: File.read("./stubbed_requests/completed.json"), headers: { "Content-Type" => "application/json" })
     client.get_tasks
  end
end
