Rebelchat::App.controllers :chatmessage, :parent => :chatroom do
  
  get :index do
    content_type :json
    chatroom = Chatroom[params[:chatroom_id]]
    if (!chatroom)
      halt 404
    end
    
    Chatmessage.filter(:chatroom_id => chatroom.id).all.to_json
  end

  post :index do
    chatroom = Chatroom[params[:chatroom_id]]
    if (!chatroom)
      halt 404
    end

    data = JSON.parse(request.body.read); 
    puts data  
    chatroom.add_chatmessage(:author=>data["author"], :content=>data["content"], :timestamp=>Time.now).to_json
  end
  
end
