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
          parsedTask = JSON.parse(task).task;
          parsedImageUrl = JSON.parse(task).image_url;
          createTaskCard(list, parsedTask, parsedImageUrl);
        });
      }
    }
  });
};

function createTaskCard(list, task, imageUrl){
  var li = document.createElement("li");
  li.innerHTML = getCardHTML(task, imageUrl);
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

function parseDate(dateString){
  return dateString.split("T")[0];
};

function getCardHTML(task, imageUrl){
  var card = "<div class='card deep-orange lighten-5'>"
              +"<div class='card-content black-text'>"
                +"<div><span class='card-title black-text' id='task_title'>Task title: "+task.title+"</span></div>"
                +"<div><span class='card-title black-text' id='task_notes'>Notes: "+task.notes+"</span></div>"
                +"<div><span class='card-title black-text' id='task_status'>Status: "+task.status+"<br>Start: "+parseDate(task.start_date)+"<br>Due: "+parseDate(task.due_date)+"</span></div>"
                +"<div><span class='card-title black-text' id='task_image'>Submitter: <img class='fingernail' src='"+imageUrl+"'></span></div>"
              +"</div>"
              +"<div class='card-action'>"
               +"<div id='delete_task_button'></div>"
              +"</div>"
            +"</div>"
  return card;
};