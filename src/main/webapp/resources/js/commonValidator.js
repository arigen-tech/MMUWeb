var $j = jQuery.noConflict();

function validateText(id, length, data){

	 
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should be less than or equal to "+length);	
		 
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
	
}

function validateTextForMenuName(id, length, data){
	//Length of menu name should not be greater than 40
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should not be greater than "+length);	
		 
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
	
}

function validateURLPattern(data) {
	
	$('input').keyup(function() {
	    var $th = $(this);
	    $th.val( $th.val().replace(/[^/#a-zA-Z]/g, function(str) {	    	
	    	alert("Please Enter Valid "+data+" Pattern");
	    	return ''; 
	    	} ) );
	});
}

function validateTextGen(id, length, data){

	 
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should be equal to "+length);	
		 
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
	
}

function validateTextField(id,length){	
	if($j("#"+id).val().length >= length){
		 alert("Length of "+id+" should be less than 30");
		 
		 var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
}

function validateCommonTextField(id,length,data){	
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should not be greater than "+length);
		 
		 var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
}



function enableAddButton(id){
	if(document.getElementById(id).value!=null || !document.getElementById(id).value==""){
		$j('#btnAddCommand').attr("disabled", false);
	}else if( document.getElementById(id).value!=null || !document.getElementById(id).value==""){
		$j('#btnAddCommand').attr("disabled", false);
	}else{
		$j('#btnAddCommand').attr("disabled", true);
	}

}

function checkNumberFormat(id){
	 $("#"+id).keypress(function (e) {
	     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	    	 $("#"+id).val("");
	    	 return false;
	    }
	   });
}




function validateEmail(sEmail){
	var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    if (filter.test(sEmail)) {
	        return true;
	    }
	    else {
	        return false;
	    }
}
//code added by rajdeo
function validateTextForMenu(id, length, data){
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should be less than or equal to "+length);	
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 $j("#"+id).val(str);
		 return false;
	 }
	
}

function validateTextForURL(id, length, data){
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should be less than or equal to "+length);	
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
	
}

 function phonenumberValidation(inputtxt)
 {
  var phoneno = /^\d{10}$/;
  var phonenumberva=$("#"+inputtxt).val();
  if((phonenumberva.match(phoneno)))
        {
      return true;
        }
      else
        {
        $("#"+inputtxt).val("");
        alert("Mobile number not valid");
        return false;
        }
   }