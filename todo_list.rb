require 'yaml'

class TodoList
  attr_reader :items

  def initialize
    load
  end

  def add_item(content)
    @items << Item.new(content)
    save
    @items.last
  end

  def list
    @items.inspect
  end
  private

  def save
    File.open("todo_list.yml", "w") { |file| file.write(@items.to_yaml) }
  end

  def load
    if File.exist?('todo_list.yml') && YAML.load(File.read('todo_list.yml'))
      @items = YAML.load(File.read('todo_list.yml'))
    else
      @items = Array.new
    end

    @items
  end
end

class Item
  attr_accessor :content, :date

  def initialize(content)
    @content = content
    @date = Time.now
  end
end

todo_list = TodoList.new
command = ARGV[0]

if command == '-a'
  item = todo_list.add_item(ARGV[1])
  puts "#{item.content} was added the todo list"
elsif command == '-l'
  puts todo_list.list
else
  puts 'Undefined command'
end