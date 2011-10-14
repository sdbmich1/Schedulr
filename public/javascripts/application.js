jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript");
      	$('#spinner').show()
	    },
    'complete': function(){
        $('#spinner').hide()
            },
    'success': function() {}  
}); 


$(function (){
  // when the #event id field changes
    $("#channel_channel_interest_category_id").live('change',function() {

    // make a POST call and replace the content
	var category = $('select#channel_channel_interest_category_id :selected').val();
	if(category == "") category="0";

$.ajax({
  dataType: 'json',
  url: '/channels/category_select/' + category,
  error: function(XMLHttpRequest, errorTextStatus, error){
              alert("Failed to submit : "+ errorTextStatus+" ;"+error);
             },
  success:  function(data){
		 $("#interest_id option").remove();
 	         $.each(data, function(i, j){
                       row = "<option value=\"" + j.interest.id + "\">" + j.interest.name + "</option>";   
	               $(row).appendTo("#interest_id");                     
	              });     
         }
	});

    });
});

$(function () {
  $('#user_host_profiles_attributes_0_Company').autocomplete({
    source: '/registrations/list'
   })
});


function add_fields(link, association, content) {  
  var new_id = new Date().getTime();  
  var regexp = new RegExp("new_" + association, "g");  
  $(link).up().insert({  
       before: content.replace(regexp, new_id)  
    });  
} 

function remove_fields(link) {  
  $(link).previous("input[type=hidden]").value = "1";  
  $(link).up(".fields").hide();  
}  
