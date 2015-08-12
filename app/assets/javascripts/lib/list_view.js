function createListView(list){
  removeOldButtons(); 
  setCardData(list);
  buildDeleteListButton(list);
  buildEditListButton(list);
  buildShowEditListButton(list);
  createTaskIndex(list);
};

function setCardData(list){
  $('#list_title')[0].innerHTML       = "List title: "+list.title;
  var description = list.description
  if(!description){
    description = "No description provided."
  }
  $('#list_description')[0].innerHTML = "Description: "+description;
};

function buildDeleteListButton(list){
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn pink accent-2 list-btn");
  button.innerHTML = "Delete List!";
  button.addEventListener('click', function(){
    $.ajax({
      url: '/lists/'+list.id,
      type: 'DELETE',
      success: function(){
        removeOldButtons();      
        populateLists();
      }
    });
  }); 
  appendDeleteListButtonToDOM(button);
}

function buildEditListButton(list){
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn light-green darken-2 list-btn");
  button.innerHTML = "Update List";
  button.addEventListener('click', function(){
    makeListUpdates(list);
  }); 
  appendEditListButtonToDOM(button);
};

function makeListUpdates(list){
  var title = $('#update_list_title')[0].value;
  var description = $('#update_list_description')[0].value;
  $.ajax({
    url: '/lists/'+list.id,
    type: 'PUT',
    data: { 'list': { 'title': title, 'description': description } },
    success: function(){
      populateLists();
    }, error: function(){
      showUserError("Title cannot be blank.")
    }
  });
};

function buildShowEditListButton(list){
  var button = document.createElement("button");
  $(button).addClass("waves-effect waves-light btn light-green darken-2 list-btn");
  button.innerHTML = "Edit List";
  button.addEventListener('click', function(){
    $('#top_list')[0].style.display = 'none';
    $('#edit_list')[0].style.display = 'block';
    setUpdateListInputs(list);
  }); 
  appendShowEditListButtonToDOM(button);
};

function appendDeleteListButtonToDOM(button){
  $("#delete_list_button")[0].appendChild(button);
};

function appendEditListButtonToDOM(button){
  $("#edit_list_button")[0].appendChild(button);
};

function appendShowEditListButtonToDOM(button){
  $("#show_edit_list_button")[0].appendChild(button);
};

function setUpdateListInputs(list){
  $('#update_list_title')[0].value = list.title;
  $('#update_list_description')[0].value = list.description;
};

function removeOldButtons(){
  $("#delete_list_button")[0].innerHTML = '';
  $("#edit_list_button")[0].innerHTML = '';
  $("#show_edit_list_button")[0].innerHTML = '';
};

