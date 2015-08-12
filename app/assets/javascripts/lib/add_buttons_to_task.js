function addButtonsToTask(list, task){
  getTaskCardToAddButtons(list, task);
};

function getTaskCardToAddButtons(list, task){
  var card = document.getElementById("list_tasks").lastChild;
  addCompleteTaskButton(card, list, task);
};

function addCompleteTaskButton(card, list, task){
  var taskId = task.id;
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn pink accent-2 task-btn");
  button.innerHTML = "Complete";
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

function appendDeleteTaskButtonToDOM(card, button){
  card.querySelectorAll('#delete_task_button')[0].appendChild(button);
}
