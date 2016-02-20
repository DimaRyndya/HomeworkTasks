class Developer
  MAX_TASKS = 10

  def initialize (name)
    @name = name
    @tasks_list = []
  end

  def add_task (task)
    raise ("Слишком много работы!") if @tasks_list.count >= self.class::MAX_TASKS
    @tasks_list.push (task)
    puts  "#{@name}: добавлена задача \"#{task}\". Всего в списке задач: #{@tasks_list.count}"
  end

  def tasks
    @tasks_list.each_with_index {|task,i| puts "#{i+1}. #{task}"}
  end

  def work!
    raise ("Нечего делать!") if @tasks_list.empty?
    puts "#{@name}: выполнена задача \"#{@tasks_list[0]}\". Осталось задач: #{@tasks_list.count - 1}"
    @tasks_list.shift
  end

  def status
    return "свободен" if @tasks_list.empty?
    return "работаю" if @tasks_list.count.between?(1, self.class::MAX_TASKS- 1)
    "занят"
  end

  def can_add_task?
    return true if @tasks_list.count.between?(0, self.class::MAX_TASKS-1)
    false
  end

  def can_work?
    return false if @tasks_list.empty?
    true
  end  

end

class JuniorDeveloper < Developer
  MAX_TASKS = 5

  def add_task (task)
    raise ("Слишком сложно!") if task.length > 20
    super
  end

  def work!
    raise ("Нечего делать!") if @tasks_list.empty?
    puts "#{@name}: пытаюсь делать задачу \"#{@tasks_list[0]}\". Осталось задач: #{@tasks_list.count - 1}"
    @tasks_list.shift
  end

end

class SeniorDeveloper < Developer
  MAX_TASKS = 15

  def work!
    return puts "Что-то лень" if rand(2).zero?
    2.times { super }
  end
end