class TextService 
  attr_reader   :client, :from, :user_id
  attr_accessor :reply, :body

  def initialize(from, body)
    @client  = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"] 
    @from    = from
    @body    = body
    @user_id = User.find_by(nickname: "Guest").id 
    @reply   = ""
  end

  def take_action
    action = body.split
    if action.first.downcase == "done" 
      mark_task_complete(action.second)
    elsif action.first == "/l"
      add_task_to_list(action.second)
    else
      add_task_to_sms_list
    end
    send_reply
  end

  def mark_task_complete(id)
    if Task.exists?(id)
      Task.find(id).update(status: 'complete')
      @reply = "Task #{id} has been marked complete!"
    else
      @reply = "Task #{id} does not exist, so could not be marked complete."
    end
  end

  def add_task_to_list(list)
    if List.exists?(title: list)
      list_id = List.find_by(title: list).id
      title   = body.split.drop(2).join(' ')
      task    = Task.create(title: title, user_id: user_id, list_id: list_id)
      @reply  = "Task #{task.id} has been added to list #{list}"
    else
      @reply  = "List #{list} does not exist, task was not created."
    end
  end

  def add_task_to_sms_list
    sms_list_id = List.find_by(title: "SMS Tasks").id
    task        = Task.create(title: body, user_id: user_id, list_id: sms_list_id)
    @reply      = "Your task has been added to SMS Tasks, task ID: #{task.id}"
  end

  def send_reply
    client.account.messages.create(from: ENV["TWILIO_NUMBER"], to: from, body: reply)
  end

end