function addButtonsToTask(list, task){
  getTaskCardToAddButtons(list, task);
};

function getTaskCardToAddButtons(list, task){
  var card = document.getElementById("list_tasks").lastChild;
  addCompleteTaskButton(card, list, task);
  addShowEditTaskButton(card, list, task);
};

function addCompleteTaskButton(card, list, task){
  var taskId = task.id;
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn pink accent-2 task-btn");
  if(task.status === 'complete'){
    button.innerHTML = "Not Complete";    
  } else {
    button.innerHTML = "Complete";
  }
  button.addEventListener('click', function(){
    $.ajax({
      url: '/tasks/'+taskId,
      type: 'DELETE',
      data: { 'task': { 'id': taskId } },
      success: function(){
        createTaskIndex(list);
      }
    });
  }); 
  appendDeleteTaskButtonToDOM(card, button);
}

function addShowEditTaskButton(card, list, task){
  var taskId = task.id;
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn light-green darken-2 task-btn");
  button.innerHTML = "Edit Task";
  button.addEventListener('click', function(){
    setEditTaskView(list, task);
  }); 
  appendShowEditTaskButtonToDOM(card, button);
}

function setEditTaskView(list, task){
  clearTasksFromList();
  var li = document.createElement("li");
  li.innerHTML = getEditTaskHTML(task);
  appendTaskToDOM(li);
  addUpdateButtonToEditTaskForm(list, task);
};

function updateTaskAJAX(list, task){
  var title = $('#edit_task_title')[0].value;
  var notes = $('#edit_task_notes')[0].value;
  var startDate = $('#edit_task_start_date')[0].value;
  var dueDate = $('#edit_task_due_date')[0].value;
  var userId = $('#user_id')[0].innerHTML;
  $.ajax({
    url: '/tasks/'+task.id,
    type: 'PUT',
    data: { 'task': { 'title': title, 'notes': notes, 'user_id': userId, 'list_id': list.id, 'start_date': startDate, 'due_date': dueDate } },
    success: function(){
      createTaskIndex(list);
    }
  });
};

function addUpdateButtonToEditTaskForm(list, task){
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn light-green darken-2 task-btn");
  button.innerHTML = "Update";
  button.addEventListener('click', function(){
    updateTaskAJAX(list, task);
  }); 
  appendUpdateTaskButtonToDOM(button);
};

function appendUpdateTaskButtonToDOM(button){
  $('#edit_task_button_div')[0].appendChild(button);
};

function appendDeleteTaskButtonToDOM(card, button){
  card.querySelectorAll('#delete_task_button')[0].appendChild(button);
}

function appendShowEditTaskButtonToDOM(card, button){
  card.querySelectorAll('#show_edit_task_button')[0].appendChild(button);
}

function appendShowEditTaskButtonToDOM(card, button){
  card.querySelectorAll('#show_edit_task_button')[0].appendChild(button);
}

function getEditTaskHTML(task){
  var cardHTML = "<div id='edit_task'>"
                +"<div class='card deep-orange lighten-5'>"
                  +"<div class='card-content black-text'>"
                    +"Title:<br>"
                    +"<input type='text' name='firstname' id='edit_task_title' value='"+task.title+"'><br>"
                    +"Description:<br>"
                    +"<input type='text' name='lastname' id='edit_task_notes' value='"+task.notes+"'><br>"
                    +"Start Date:"
                    +"<input type='date' id='edit_task_start_date' value='"+parseDate(task.start_date)+"'><br>"
                    +"Due Date:"
                    +"<input type='date' id='edit_task_due_date' value='"+parseDate(task.due_date)+"'><br>"
                    +"<div id='edit_task_button_div'></div>"
                  +"</div>"
                +"</div>"
              +"</div>"
  return cardHTML;
};