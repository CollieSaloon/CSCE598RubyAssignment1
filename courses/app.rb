require "sinatra"
require "./course"
require "./course_store"

store = CourseStore.new("courses.yml")

get('/courses') do
 @courses = store.all
erb :index
end

get('/courses/new') do
erb :new
end

get('/courses/:id') do
 id = params['id'].to_i
 @course = store.get(id)
 erb :show
end

post('/courses/create') do
 @course = Course.new
 @course.title = params['title']
 @course.instructor = params['instructor']
 @course.semester = params['semester']

 store.save(@course)
 redirect "/courses/new"
end

post('/courses/edit/:id') do   
    id = params['id'].to_i        
    @oldcourse = store.get(id)

    @newcourse = Course.new
    @newcourse.title = params['title']
    @newcourse.instructor = params['instructor']
    @newcourse.semester = params['semester']
    @newcourse.id = @oldcourse.id

    store.edit(@newcourse)    

    redirect "/courses/" + id.to_s
end

 post('/courses/delete/:id') do  
    id = params['id'].to_i
    @course = store.get(id)
    store.remove(@course)

    redirect "/courses"
 end