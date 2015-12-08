class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def salary_underneath
    @salary
  end

end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    sub_salary = 0
    @employees.each do |employee|
      sub_salary += employee.salary_underneath
    end
    sub_salary * multiplier
  end

  def salary_underneath
    salary_underneath = @salary
    employees.each do |employee|
      salary_underneath += employee.salary_underneath
    end
    salary_underneath
  end

end

david = Employee.new("David", "TA", 10000, "Darren")
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78000, "Ned", [david, shawna])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])
