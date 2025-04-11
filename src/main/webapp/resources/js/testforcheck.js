/**
 * 
 */


function getOnlyDistrictAutoComp(txtSearch, event, txtdivid, txtId, hiddenId,
		type) {
	document.getElementById("districtHiddenId").value = "";
	divid = txtdivid;
	txtid = txtSearch.id;
	checkKeyPressEvent(event, divid, txtdivid, txtSearch, txtId, '2');
}


function checkKeyPressEvent(event, divid, txtdivid, txtSearch, txtId, flag) {
	if (event.keyCode == 40)
		downArrowKey(txtdivid);
	else if (event.keyCode == 38) //up key
		upArrowKey(txtdivid);
	else if (event.keyCode == 13) // RETURN
	{
		if (document.getElementById(divid))
			document.getElementById(divid).style.display = 'block';
		if (flag != null && flag != '') {

			if (flag == '1')
				document.getElementById("districtORSchoolName").focus();

			if (flag == '2')
				document.getElementById("onlyDistrictName").focus();
			if (flag == '3')
				document.getElementById("onlyHeadQuarterName").focus();
			if (flag == '4')
				document.getElementById("onlyBranchName").focus();
		}
	} else if (txtSearch.value != '') {
		index = -1;
		length = 0;
		document.getElementById(divid).style.display = 'block';
		if (flag != null && flag != '') {
			if (flag == '1')
				searchArray = getDistrictMasterArray(txtSearch.value);
			if (flag == '2')
				searchArray = getDistrictMasterOnlyArray(txtSearch.value);
			if (flag == '3')
				searchArray = getHeadQuarterOnlyArray(txtSearch.value);
			if (flag == '4')
				searchArray = getBranchOnlyArray(txtSearch.value);
		}
		fatchData(txtSearch, searchArray, txtId, txtdivid);
	} else if (txtSearch.value == "") {
		document.getElementById(divid).style.display = 'none';
	}
}



function getDistrictMasterOnlyArray(districtOrSchoolName) {

	var searchArray = new Array();
	var branchId = $('#branchHiddenId').val();
	if ($('#userEntityType').val() == 6) {
		branchId = $('#branchId').val();
	}
	var headQuarterId = $('#headQuarterHiddenId').val();
	UserAjax.getFieldOfDistrictListByBranchOrHQId(districtOrSchoolName,
			branchId, headQuarterId, {
				async : false,
				callback : function(data) {
					hiddenDataArray = new Array();
					showDataArray = new Array();
					for (var i = 0; i < data.length; i++) {
						searchArray[i] = data[i].districtName;
						showDataArray[i] = data[i].districtName;
						hiddenDataArray[i] = data[i].districtId;
					}
				},
				errorHandler : handleError
			});
	return searchArray;
}

var selectFirst = "";
var fatchData = function(txtSearch, searchArray, txtId, txtdivid) {
	var result = document.getElementById(txtdivid);
	try {
		result.style.display = 'block';
		result.innerHTML = '';
		var items = '';
		count = 0;
		var len = searchArray.length;
		if (document.getElementById(txtId).value != "") {
			for ( var i = 0; i < len; i++) {
				items += "<div id='divResult" + txtdivid + count
						+ "'  class='normal'>" + searchArray[i].toUpperCase()
						+ "</div>";
				count++;
				length++;
				if (count == 10)
					break;
			}
		} 
		if (count != 0)
			result.innerHTML = items;
		else {
			result.style.display = 'none';
			selectFirst = "";
		}
		if (txtSearch.value != ''
				&& document.getElementById('divResult' + txtdivid + 0)) {
			document.getElementById('divResult' + txtdivid + 0).className = 'over';
			selectFirst = document.getElementById('divResult' + txtdivid + 0).innerHTML;
		}

		scrolButtom();
	} catch (err) {
	}
}

function hideDistrictDiv(dis, hiddenId, divId) {
	$('#errordiv').empty();
	if (parseInt(length) > 0) {
		if (index == -1)
			index = 0;
		if (hiddenDataArray && hiddenDataArray[index]
				&& document.getElementById(hiddenId)) {
			document.getElementById(hiddenId).value = hiddenDataArray[index];
			document.getElementById("districtOrSchooHiddenlId").value = hiddenDataArray[index];
		}

		if (dis.value == "") {
			$('#districtORSchoolName').attr('readonly', true);
			document.getElementById(hiddenId).value = "";
		} else if (showDataArray && showDataArray[index]) {
			$('#districtORSchoolName').attr('readonly', false);
			dis.value = showDataArray[index];
			document.getElementById("districtOrSchooHiddenlId").value = hiddenDataArray[index];
			document.getElementById("districtOrSchooHiddenlId").value = hiddenDataArray[index];
		}
	} else {
		if (document.getElementById(hiddenId))
			document.getElementById(hiddenId).value = "";
		if (dis.value != "") {
			onlyDistrictName = 2;
			$('#errordiv').empty();
			$('#errordiv').show();
			$('#errordiv').append(
					"&#149; " + resourceJSON.msgvaliddistrict + "<br>");
			if (focus == 0)
				$('#onlyDistrictName').focus();
			focus++;
		}
	}

	if (document.getElementById(divId))
		document.getElementById(divId).style.display = "none";
	index = -1;
	length = 0;
}


var downArrowKey = function(txtdivid) {
	if (txtdivid) {
		if (index < length - 1) {
			for ( var i = 0; i < 10; i++) {
				{
					if (document.getElementById('divResult' + txtdivid + i))
						var div_id = document.getElementById('divResult'
								+ txtdivid + i);
					if (div_id) {
						if (div_id.className == 'over')
							index = div_id.id.split('divResult' + txtdivid)[1];
						div_id.className = 'normal';
					}
				}
			}
			index++;
			if (document.getElementById('divResult' + txtdivid + index)) {
				var divId = document.getElementById('divResult' + txtdivid
						+ index);
				divId.className = 'over';
				document.getElementById(txtid).value = divId.innerHTML;
				selectFirst = divId.innerHTML;
			}
		}
	}
}
var upArrowKey = function(txtdivid) {
	if (txtdivid) {
		if (index > 0) {
			for ( var i = 0; i < length; i++) {

				var div_id = document
						.getElementById('divResult' + txtdivid + i);
				if (div_id) {
					if (div_id.className == 'over')
						index = div_id.id.split('divResult' + txtdivid)[1];
					div_id.className = 'normal';
				}
			}
			index--;
			if (document.getElementById('divResult' + txtdivid + index))
				document.getElementById('divResult' + txtdivid + index).className = 'over';
			if (txtid
					&& document.getElementById('divResult' + txtdivid + index)) {
				document.getElementById(txtid).value = document
						.getElementById('divResult' + txtdivid + index).innerHTML;
				selectFirst = document.getElementById('divResult' + txtdivid
						+ index).innerHTML;
			}
		}
	}
}

var overText = function(div_value, txtdivid) {
	for ( var i = 0; i < length; i++) {
		if (document.getElementById('divResult' + i)) {
			var div_id = document.getElementById('divResult' + i);

			if (div_id.className == 'over')
				index = div_id.id.split(txtdivid)[1];
			div_id.className = 'normal';
		}
	}
	div_value.className = 'over';
	document.getElementById(txtid).value = div_value.innerHTML;
}
























