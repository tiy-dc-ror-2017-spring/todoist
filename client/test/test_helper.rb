require "minitest/autorun"
require "minitest/pride"
require "minitest/focus"
require "webmock/minitest"
require "httparty"

require_relative "../todo_cli"
require_relative "../../server/app/task"
require_relative "../development"

# begin
#   CreateTasksTable.migrate(:down)
# rescue ActiveRecord::StatementInvalid
# end
# CreateTasksTable.migrate(:up)
#
# begin
#   CreateListsTable.migrate(:down)
# rescue ActiveRecord::StatementInvalid
# end
# CreateListsTable.migrate(:up)
