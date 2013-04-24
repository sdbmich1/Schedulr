$.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript");
      	$('#spinner').show('fast')
	    },
    'complete': function(){
        $('#spinner').hide('fast')
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

$(document).ready(function(){
    $("#mform label").inFieldLabels();
  });

$(function () {
   $("#session-list .pagination a, #sub-list .pagination a,#pres-list .pagination a,#event-list .pagination a,#rsvp-list .pagination a,#ch-list .pagination a, #spon-list .pagination a, #ex-list .pagination a").live('click', function () {
         $.getScript(this.href);
	 return false;
   });
});

$(function (){

  if ($(".pres-fields").length != 0) {

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
  }  
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

// shows/hides the rsvp/subscription list on clicking link
$(function (){
  $("#slist, #rlist").live('click',function() {
  $(this).text($(this).text() == 'Show List' ? $('#sub-list, #rsvp-list').show('fast') : $('#sub-list, #rsvp-list').hide('fast') );
  $(this).text($(this).text() == 'Show List' ? 'Hide List' : 'Show List');
  });
});

$(function (){ 

  // add date picker code and synch start & end dates
  var dateFormat = "mm/dd/yy";
	
    $('#start-date').datepicker({ 
      minDate:'-0d',
      dateFormat:dateFormat,
      buttonImage: '/images/date_picker1.gif', 
      buttonImageOnly: true, 
      showOn: 'button',
      onSelect: function (dateText, inst) { 
          var nyd = $.datepicker.parseDate(dateFormat,dateText);
          $('#end-date').datepicker("option", 'minDate', nyd ).val($(this).val());
      }, 
      onClose: function () { $(this).focus() } 
  	 }).change(function () {  
  	 	$('#end-date').val($(this).val())
     }); 
  
    $('#promo-start-date').datepicker({ 
      minDate:'-0d',
      dateFormat:dateFormat,
      buttonImage: '/images/date_picker1.gif', 
      buttonImageOnly: true, 
      showOn: 'button',
      onSelect: function (dateText, inst) { 
          var nyd = $.datepicker.parseDate(dateFormat,dateText);
          $('#promo-end-date').datepicker("option", 'minDate', nyd ).val($(this).val());
      }, 
      onClose: function () { $(this).focus() } 
  	 }).change(function () {  
  	 	$('#promo-end-date').val($(this).val())
     }); 
  
    $('#end-date, #promo-end-date').datepicker({ 
      onClose: function () { $(this).focus(); }, 
      minDate:'-0d',
      dateFormat:dateFormat,
      buttonImage: '/images/date_picker1.gif', 
      buttonImageOnly: true, 
      showOn: 'button',
      onSelect: function(dateText, inst){ }                       
    }); 
    	
});

$(function (){ 

  /* Apply fancybox to multiple items */
  $("a#modalGroup").fancybox({
    	'width'		:   '560',
    	'height'	:	'340',
	'transitionIn'	:	'elastic',
	'transitionOut'	:	'elastic',
	'speedIn'	:	600, 
	'speedOut'	:	600, 
	'titleShow'	:       false,
	'overlayShow'	:	true
  });	
	
  $('.show_event').bind('ajax:success', function() {
	$("#modalGroup").trigger('click');
  });
});

// shows schedule availability based on selected start date
$(function (){
  $("#chk-avail").live('click',function() {
    var cid = $('#curr-cid').attr("data-cid");
    var startdate = $('#start-date').val();
    $.getScript('/schedule.js?start_dt=' + startdate + "&cid=" + cid);
  }).fancybox();
});

function toggleLoading () { 
	$("#spinner").toggle(); 
}

// add spinner to ajax events
$(function (){ 

  $("#connect_btn, #search_btn")
    .bind("ajax:beforeSend",  toggleLoading)
    .bind("ajax:complete", toggleLoading)
    .bind("ajax:success", function(event, data, status, xhr) {
      $("#response").html(data);
    });
}); 

// when the #start time field changes
$(function (){
  $("#start-time").live('change',function() {
    if ($("#eventid").val().length == 0)
      {
      $("#end-time").val($(this).val()); 
      }
  });
});

// when the #promo-start time field changes
$(function (){
  $("#promo-start-time").live('change',function() {
      $("#promo-end-time").val($(this).val()); 
  });
});
