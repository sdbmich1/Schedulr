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
  $("select[id*=event_type]").live('change',function() {

     // make a POST call and replace the content
     var etype = $(this).val().toLowerCase();
     if(etype == "ue" || etype == "mtg" || etype == "te")
        {
         $('#track-site').hide('fast');
   	 return false;
	}
     else
        {
         $('#track-site').show('slow');
   	 return false;
	}
    });
});

$(function (){

  // when the #event id field changes
  $("select[id*=category_id]").live('change',function() {

     // make a POST call and replace the content
     var category = $(this).val();
     if(category == "") category="0";

     var nxtID = $(this).next();
     var nxtWidth = $(nxtID).width() + 5;

  $.ajax({
    dataType: 'json',
    url: '/channels/category_select/' + category,
    error: function(XMLHttpRequest, errorTextStatus, error){
              alert("Failed to submit : "+ errorTextStatus+" ;"+error);
             },
    success:  function(data){
		 $(nxtID).find("option").detach();

                 //put in a empty default line
		 var row = "<option value=\"" + "" + "\">" + "Select" + "</option>";
	         $(row).appendTo(nxtID);                     

 	         $.each(data, function(i, j){
                       row = "<option value=\"" + j.interest.id + "\">" + j.interest.name + "</option>";   
	               $(row).appendTo(nxtID);                     
	              });     
		 $(nxtID).css({width: nxtWidth + 'px' });
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
