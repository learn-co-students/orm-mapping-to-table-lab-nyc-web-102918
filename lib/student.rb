class Student
	def self.create_table
		DB[:conn].execute(<<-SQL
			CREATE TABLE IF NOT EXISTS students(
			id INTEGER PRIMARY KEY,
			name TEXT,
			grade TEXT
		);
		SQL
		)
	end

	def self.drop_table
		DB[:conn].execute("DROP TABLE IF EXISTS students;")
	end

	def self.create(name:, grade:)
		student = Student.new(name, grade)
		student.save

		student
	end

	attr_reader :name, :grade, :id

	def initialize(name, grade)
		@name = name
		@grade = grade
	end

	def save
		DB[:conn].execute("INSERT INTO students(name, grade) VALUES (?, ?)", @name, @grade)

		@id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
	end
end
