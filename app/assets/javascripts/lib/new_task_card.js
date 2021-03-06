function buildNewTaskCard(list){
  var li = document.createElement("li");
  li.innerHTML = getNewTaskCardHTML();
  appendNewTaskCardToDOM(li);
  addButtonToNewTaskCard(list);
}

function appendNewTaskCardToDOM(card){
  var list = document.getElementById('list_tasks');
  list.insertBefore(card, list.childNodes[0]);  
};

function addButtonToNewTaskCard(list){
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn light-green darken-2 task-btn");
  button.innerHTML = "Create Task";
  button.addEventListener('click', function(){
    createNewTask(list);
  }); 
  appendCreateNewTaskButtonToDOM(button);
};

function appendCreateNewTaskButtonToDOM(button){
  $("#new_task_button_div")[0].appendChild(button);
};

function createNewTask(list){
  var title = $('#new_task_title')[0].value;
  var notes = $('#new_task_notes')[0].value;
  var userId = $('#user_id')[0].innerHTML;
  var startDate = $('#new_task_start_date')[0].value;
  var dueDate = $('#new_task_due_date')[0].value;
  $.ajax({
    url: '/tasks',
    type: 'POST',
    data: { 'task': { 'title': title, 'notes': notes, 'user_id': userId, 'list_id': list.id, 'start_date': startDate, 'due_date': dueDate } },
    success: function(){
      createTaskIndex(list);
    }
  })
};

function getNewTaskCardHTML(){
  var cardHTML = "<div id='new_task'>"
                  +"<div class='card deep-orange lighten-5'>"
                    +"<div class='card-content black-text'>"
                      +"Title:<br>"
                      +"<input type='text' name='firstname' id='new_task_title'><br>"
                      +"Description:<br>"
                      +"<input type='text' name='lastname' id='new_task_notes'><br>"
                      +"Start Date:"
                      +"<input type='date' id='new_task_start_date'><br>"
                      +"Due Date:"
                      +"<input type='date' id='new_task_due_date'><br>"
                      +"<div id='new_task_button_div'></div>"
                    +"</div>"
                  +"</div>"
                +"</div>"
  return cardHTML;
};