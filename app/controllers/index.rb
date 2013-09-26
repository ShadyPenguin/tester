get '/' do
  # render home page
  @users = User.all

  erb :index
end

get '/skills' do 
  @user = User.find(session[:user_id])
  erb :skills
end
# not quite working
post '/skills' do 
  user = User.find(session[:user_id])
  skill = Skill.new(name: params[:skill_name], context: params[:skill_context])
  
  redirect '/skills' unless skill
  user.skills << skill
  formal = params[:formal] == 'yes' ? true : false
  prof = Proficiency.new(years: params[:years].to_i, formal: formal, skill_id: user.skills.last.id)
  if prof
    
    user.proficiencies << prof
    redirect '/'
  else
    redirect '/skills'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/skills'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end
