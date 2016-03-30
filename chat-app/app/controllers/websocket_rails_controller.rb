class WebsocketRailsController < WebsocketRails::BaseController
# handle web socket info

  def client_connected
    #show that client is connected
    p 'Opening chat'
    send_message :new_user, {:message => 'This is a message'}
  end

  def new_message
    #broadcast new message
    p message
    p 'testing to see if messages are hitting server'
  end

end
