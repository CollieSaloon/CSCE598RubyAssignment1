#Courses_Store
require "./course"
require "yaml/store"

class CourseStore
   
   def initialize(filename)
	@store = YAML::Store.new(filename)
   end

   def save(course)
	@store.transaction do
	   unless course.id
	      highest_id = @store.roots.max || 0
	      course.id = highest_id + 1
           end
	   @store[course.id] = course
	end
   end

   def remove(course)
	@store.transaction do
		@store.delete(course.id)
	 end
   end

   def edit(newcourse)
	@store.transaction do
		@store[newcourse.id] = newcourse;
	 end
    end
   
   def get(id)
	@store.transaction do
		@store[id]
	end
   end

   def all
	@store.transaction do
		@store.roots.map{ |id| @store[id]}
	end
   end

end
   
