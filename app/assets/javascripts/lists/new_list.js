function newList(){
  setCreateListButton();
  setCreateListForm();
};

function setCreateListButton(){
  $('#click_create_list').click(function(){
    $('#top_list')[0].style.display = 'none';
    $('#new_list')[0].style.display = 'block';
  });
};

function setCreateListForm(){
  $('#new_list_button').on('click', function(){
    var title       = $('#new_list_title')[0].value;
    var description = $('#new_list_description')[0].value;
    createNewList(title, description);
  });
};

function createNewList(title, description){
  $.ajax({
    url: '/lists',
    type: 'POST',
    data: { 'list': { 'title': title, 'description': description } },
    success: function(){
      populateLists();
    }
  });
};

