function createTaskIndex(list){
  clearTasksFromList();
  getTasksFromList(list);
};

function clearTasksFromList(){
  $('#list_tasks')[0].innerHTML = '';
};

function getTasksFromList(list){
  $.ajax({
    url: 'list_tasks',
    type: 'GET',
    data: { 'task': { 'list_id': list.id } },
    success: function(response){
      if(response.length === 0){
        addNoTasksMessage();
      } else {
        response.forEach(function(task){
          createTaskCard(list, task);
        });
      }
    }
  });
};

function createTaskCard(list, task){
  var li = document.createElement("li");
  li.innerHTML = getCardHTML(task);
  appendTaskToDOM(li);
  addButtonsToTask(list, task);
};

function addNoTasksMessage(){
  var li = document.createElement("li");
  li.innerHTML = "No tasks created yet."
  $('#list_tasks')[0].appendChild(li);
};

function appendTaskToDOM(task_card){
  $('#list_tasks')[0].appendChild(task_card);
};

function getUserData(task){
  $.ajax({
    url: '/users/'+task.user_id,
    type: 'GET',
    data: { 'user': { 'id': task.user_id } },
    success: function(response){
      getCardHTML(task, response)
    }
  })
}

function getCardHTML(task, user_data){
  var card = "<div class='card deep-orange lighten-5'>"
              +"<div class='card-content black-text'>"
                +"<div><span class='card-title black-text' id='task_title'>Task title: "+task.title+"</span></div>"
                +"<div><span class='card-title black-text' id='task_notes'>Notes: "+task.notes+"</span></div>"
                +"<div><span class='card-title black-text' id='task_status'>Status: "+task.status+"</span></div>"
                +"<div><span class='card-title black-text' id='task_image'>Submitter: <div id='submitter'></div></span></div>"
              +"</div>"
              +"<div class='card-action'>"
               +"<div id='delete_task_button'></div>"
              +"</div>"
            +"</div>"
  return card;
};