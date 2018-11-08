class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name=name
    @grade=grade
    @id=id
  end

  def self.create(name:, grade:)
    Student.new(name,grade).save
  end

  def self.create_table
    create_table = <<-SQL
    CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
    )
    SQL

  DB[:conn].execute(create_table)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql="INSERT INTO students(name, grade) VALUES(?, ?)"

    DB[:conn].execute(sql,self.name,self.grade)
    sql="SELECT id FROM students ORDER BY id DESC LIMIT 1 "
    last_id=DB[:conn].execute(sql).flatten
    @id=last_id[0]
    self
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
