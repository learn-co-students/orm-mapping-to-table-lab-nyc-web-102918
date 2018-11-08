class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    table = "CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER)"
    DB[:conn].execute(table)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    student = "INSERT INTO students (name, grade)
    VALUES (?, ?)"

    DB[:conn].execute(student, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
