require 'pry'

class Student

  attr_accessor :name, :grade

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name, grade)
    @name = name
    @grade=grade
  end

  def self.create_table
    sql="CREATE TABLE students (id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql="DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?,?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def id
    DB[:conn].execute("SELECT students.id FROM students ORDER BY students.id DESC LIMIT 1")[0][0]
  end

  def self.create(attribute_hash)
    new_student=Student.new(attribute_hash[:name], attribute_hash[:grade])
    new_student.save
    new_student
  end
end
