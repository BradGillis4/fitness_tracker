class PostController < ApplicationController

    get '/posts' do 
        @posts = Post.all
        if current_user
            erb :'post/index'
          else
            redirect to "/login"
          end
    #    erb :'post/index'
    end

    get '/posts/new' do
        if current_user
            erb :'post/new'
          else
            redirect to "/"
          end
        erb :'post/new'
    end
   
    get '/posts/:id' do
        @post = Post.find_by(id:params[:id]) #if cannot find object it will return nil, find causes error is not found
        erb :'post/show'
        
    end

    post '/posts' do
        #creates new post
        # binding.pry
        @post = Post.new(params)#creates new post object,
        @post.user_id = session[:user_id]
        @post.save(validate: false) #saves post object with post info, validation forces it to save (is save false, yes. -> true)
        redirect "/posts/#{@post.id}"
       
    end

    get '/posts/:id/edit' do
        get_post
        redirect_if_not_authorized
        erb :"/post/edit"
        
    end

    patch '/posts/:id' do 
        get_post
        redirect_if_not_authorized

        @post.update(name: params[:name], content: params[:content])
        @post.save(validate:false)
         redirect "/posts/#{@post.id}"
            
        
        
      

    end    

    delete '/posts/:id' do
        get_post
        @post.delete
        
        # @post.save(validate:false)
        redirect '/posts'
    end

    private 

    def get_post 
        @post = Post.find_by(id:params[:id])
    end 

    def redirect_if_not_authorized
        if @post.user != current_user
            flash[:error] = "You cant make this edit, you don't own this"
            redirect '/posts'
        end 

    end 



end