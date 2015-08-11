function populateLists(){
  hideEditList();
  hideCreateList();
  showTopList();
  getLists();
};

function showTopList(){
  $('#top_list')[0].style.display = 'block';
};

function hideCreateList(){
  $('#new_list')[0].style.display = 'none';
};

function hideEditList(){
  $('#edit_list')[0].style.display = 'none';
};

function getLists(){
  $.ajax({
    url: '/all_lists',
    type: 'GET',
    success: function(response){
      cleanList();
      createListView(response[0]);
      response.forEach(function(list){
        createListItem(list);
      });
    }
  });
};

function cleanList(){
  $('#lists_list')[0].innerHTML = '';
};

function createListItem(list){
  var li = document.createElement("li");
  li.innerHTML = '<strong>'+list.title+'</strong>';
  li.addEventListener('click', function(){
    createListView(list)
  }); 
  appendListItemToDOM(li);
};

function appendListItemToDOM(list_item){
  $('#lists_list')[0].appendChild(list_item);
};