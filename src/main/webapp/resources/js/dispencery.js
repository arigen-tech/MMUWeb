/**
 * 
 */
var itemIdPrescription= '';
var i=1;
var  j=1;
function addNomenclatureRow1() {
	//var nomenclature = $("#nomenclatureGrid").closest('tr').find("td:eq(2)").find(":input").val(); 
	var nomenclature=$('#nomenclatureGrid').children('tr:last').children('td:eq(2)').find(':input').val();
	var reqQty=$('#nomenclatureGrid').children('tr:last').children('td:eq(4)').find(':input').val();
	var remarks=$('#nomenclatureGrid').children('tr:last').children('td:eq(8)').find(':input').val();
	var itemId=$('#nomenclatureGrid').children('tr:last').children('td:eq(9)').find(':input').val();
	/* var reqQty=$j("#requiredQty"+i).val();
	var nomenclature=$j("#nomenclature"+i).val();
	var remarks=$j("#remarks"+i).val(); */
	
	 if (nomenclature == null || nomenclature == "") {
         alert("Please select the nomenclature");
         return false;
     }
	 if(itemId == "" || itemId == null){
    	 alert("Please enter valid data");
         return false;
     }
     if (reqQty == null || reqQty == "") {
        alert("Please enter the required quantity");
        return false;
    }
    
     if (remarks == null || remarks == "") {
         alert("Please enter the reason for indent");
         return false;
     } 
    
    
    i++;
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	/* aClone.find("td:eq(0)").find(":input").prop('id', 'chkbox'+i+'');
	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+i+'');
	aClone.find("td:eq(9)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'pvmsNo'+i+''); */
	aClone.find("td:eq(2)").find(":input").prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(3)").find(":input").prop('id', 'dispensingUnit'+i+'');
	aClone.find("td:eq(4)").find(":input").prop('id', 'requiredQty'+i+'');
	aClone.find("td:eq(5)").find(":input").prop('id', 'availableStock'+i+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'stockInDispencery'+i+'');
	aClone.find("td:eq(7)").find(":input").prop('id', 'stockInStore'+i+'');
	aClone.find("td:eq(8)").find(":input").prop('id', 'remarks'+i+'');
	//aClone.find('input[type="text"]').prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(9)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'pvmsNo'+i+'');
	aClone.find("td:eq(1)").html(i);
	//aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(2)").find(":input")[0];
	autocomplete(val, arryNomenclature);
	
}


//delete
// delete selected records
$('#deleteNomenclature').on('click', function(e) {
	var rowCount = $('#nomenclatureGrid tr').length;
	var acountChkBox=$('input[name=chkbox]:checked').length;
	if(rowCount!==1){
	var r = confirm("Are you sure want to delete?");
	if (r == true) {
		
		if(rowCount!==acountChkBox){
			jQuery('input:checkbox:checked').parents("tr").remove();
			i=i-acountChkBox;
	}
		else
			alert("All data can't be deleted");
	}
	 else {
		  return false;
	 }
	} else {
	  return false;
	}
	
	
});

var pvmsNo = '';
function populatePVMS1(val, inc) {
	//alert("called");
	if (val != "") {
		
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		// alert("pvms no--"+pvmsNo)

		if (pvmsNo == "") {
			// alert("pvms no1111--"+pvmsNo)
			// document.getElementById('nomenclature' + inc).value = "";
			// document.getElementById('pvmsNo' + inc).value = "";
			return false;
		} else {
			//document.getElementById('pvmsNo' + inc).value = pvmsNo
			return true;

		}

	} else {
		return false;
	}
}

//

function submitForm() {
	  var fromDate = $j("#indentDate").val();
	  if (fromDate == null || fromDate == "") {
          alert("Please select fromDate");
          return false;
      }
	  var departmentId = $j("#departmentId").val();
	  if (departmentId == null || departmentId == 0) {
          alert("Please select department");
          return false;
      }
	 	 var nomenclature=$('#nomenclatureGrid').children('tr:last').children('td:eq(2)').find(':input').val();
		 var reqQty=$('#nomenclatureGrid').children('tr:last').children('td:eq(4)').find(':input').val();
		 var remarks=$('#nomenclatureGrid').children('tr:last').children('td:eq(8)').find(':input').val();
		 var itemId=$('#nomenclatureGrid').children('tr:last').children('td:eq(9)').find(':input').val();
			
		 if (nomenclature == null || nomenclature == "") {
	         alert("Please select the nomenclature");
	         return false;
	     }
		 if (itemId == null || itemId == "") {
	         alert("Please enter valid data");
	         return false;
	     }
	     if (reqQty == null || reqQty == "") {
	        alert("Please enter the required quantity");
	        return false;
	    }
	    
	     if (remarks == null || remarks == "") {
	         alert("Please enter the reason for indent");
	         return false;
	     }
	
		$("#submitIndentDispencery").submit();
	
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
