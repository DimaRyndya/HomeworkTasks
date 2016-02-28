require_relative "main.rb"

class Team
  def initialize(&block)
    @all_programmers = {}
    @priorities = []
    @additional_actions = {}
    instance_eval &block
  end
  def have_seniors(*names)
    @all_programmers[:seniors] = names.map { |name| SeniorDeveloper.new(name) }

  end

  def have_developers(*names)
    @all_programmers[:developers] = names.map { |name| Developer.new(name) }
  end

  def have_juniors(*names)
    @all_programmers[:juniors] = names.map { |name| JuniorDeveloper.new(name) }

  end

  def priority(*args)
    @priorities = args
  end
  def add_task(task_name)
    @priorities.each do |priority|
      free_developer = @all_programmers[priority].find{|dev| dev.can_add_task?}
      if free_developer
        block = @additional_actions[free_developer.developer_type]
        if block
          block.call(free_developer, task_name)
        end 
        return free_developer.add_task(task_name)
      end
    end
    raise 'Никого свободного нет'
  end

  def on_task(type, &block)
    @additional_actions[type] = block
  end
  
  def juniors
    return @all_programmers[:juniors]
  end

  def developers
    return @all_programmers[:developers]
  end

  def seniors
    return @all_programmers[:seniors]
  end

  def all
    return @all_programmers.values.flatten
  end

  def report
    @priorities.each do |priority|
      devs = @all_programmers[priority].sort_by do |dev|
        dev.tasks_list.count
      end
      devs.each do |dev|
        puts "#{dev.name} (#{dev.developer_type.to_s}): #{dev.tasks_list.join(',')}"
      end
    end 
  end

end

team = Team.new do
  # создаём команду, описываем её в этом блоке

  # описываем, какие в команде есть разработчики
  have_seniors "Олег", "Оксана"
  have_developers "Олеся", "Василий", "Игорь-Богдан"
  have_juniors "Владислава", "Аркадий", "Рамеш"

  # описываем в каком порядке выдавать задачи:
  # * сначала любому джуниору
  # * потом любому обычному разработчику
  # * потом любому старшему
  priority :juniors, :developers, :seniors

  # описываем дополнительные действия, когда задача выдана джуну
  on_task :junior do |dev, task|
    puts "Отдали задачу #{task} разработчику #{dev.name}, следите за ним!"
  end

  # ...и так можно для любого типа разработчиков описать, например:
  on_task :senior do |dev, task|
    puts "#{dev.name} сделает #{task}, но просит больше с такими глупостями не приставать"
  end
end

team.add_task('Написать программу')
team.all
team.report

