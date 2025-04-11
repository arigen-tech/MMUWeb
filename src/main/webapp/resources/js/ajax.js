/**
 * Get the contents of the URL via an Ajax call
 * url - to get content from (e.g. /struts-ajax/sampleajax.do?)
 */
/**
 * Functions for Displaying Message through Ajax
 */
function ajaxFunction(formName, action) {
	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			document.getElementById("statusMessage").innerHTML = xmlHttp.responseText;
		}
	}
	var url = action + "&" + getNameAndData(formName)

	xmlHttp.open("GET", url, true);

	xmlHttp.send(null);
}

function submitFormAjax(formName, action, extraFunction, extraFunction2,
		extraFunction3) {
	errorMsg = "";
	ob1 = true;
	ob2 = true;
	ob3 = true;
	obj = eval('document.' + formName)

	if (eval("window." + extraFunction))
		ob1 = eval(extraFunction + "()")

	if (eval("window." + extraFunction2))
		ob2 = eval(extraFunction2 + "()")

	if (eval("window." + extraFunction3))
		ob3 = eval(extraFunction3 + "()")

	if (validateFields(formName) == true & ob1 & ob2 & ob3) {
		obj.action = action;
		ajaxFunction(formName, action);
	} else {
		if (errorMsg != "") {
			alert(errorMsg);
			return false;
		}
		return true;
	}
}

function getNameAndData(formName) {
	var str = "";
	inputs = eval('document.' + formName + '.elements');
	for (i = 0; i < inputs.length; i++) {
		str = str + inputs[i].name + "=" + inputs[i].value + "&"
	}
	return str;
}

// End of Functions for Displaying Message through Ajax

function getPatientInfo(formName) {

	var nameId = document.getElementById('nameId');
	var hinNo = document.getElementById('hinNo');
	var searchField = document.getElementById('searchField').value
	if (nameId.checked) {
		temp = 1;
	} else {
		temp = 2;
	}
	var url;
	if (formName == 'search') {
		url = "/hms/hms/registration?method=searchPatient&temp=" + temp
				+ "&searchField=" + searchField;
	} else if (formName == 'visitSearch') {
		url = "/hms/hms/registration?method=showVisitDetails&temp=" + temp
				+ "&searchField=" + searchField;
	}
	request.open("GET", url, true);
	request.onreadystatechange = updatePage;
	request.send(null);
}

function updatePage() {
	if (request.readyState == 4)
		if (request.status == 200) {
			var response = request.responseText;
			document.getElementById("resultOfSearch").innerHTML = response;

		} else if (request.status == 404)
			alert("Request URL does not exist");
		else
			alert("Error: status code is " + request.status);
}

// -----------------------For Registration & Admission---------------------

var request = false;
function calcAge() {
	dob = document.getElementById('dobId').value;
	url = "/hms/hms/registration?method=calculateAge&dateOfBirth=" + dob;
	try {
		request = new XMLHttpRequest();
	} catch (e) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	request.open("GET", url, true);
	request.onreadystatechange = callback;
	request.send(null);
}

function callback() {
	if ((request.readyState == 4) && (request.status == 200)) {
		document.registration.ageLabel.value = request.responseText;
		document.getElementById('age').style.display = 'none';
		document.getElementById('ageLabelId').style.display = 'block';
		document.getElementById('ageId').setAttribute('validate',
				'Age,string,no');
		document.getElementById('idForAge').setAttribute('validate',
				'Age,string,yes');
	}
}

function getHin() {

	var url = '';
	var serviceType = document.getElementById('serviceTypeId').value;
	if (serviceType == "7") {
		document.getElementById('serviceNoId').value = '';
		document.getElementById('relationId').value = '8'
		// document.getElementById('serviceStatusId').value;
		var serviceNo = document.getElementById('serviceNoId').value;
		var relation = "8";
		var serviceStatus = "1";
		url = "/hms/hms/registration?method=getHinNo&serviceNo=" + serviceNo
				+ "&serviceTypeId=" + serviceType + "&relationId=" + relation
				+ "&serviceStatus=" + serviceStatus;
	} else {
		var serviceNo = document.getElementById('serviceNoId').value;
		var relation = document.getElementById('relationId').value;
		// var serviceStatus = document.getElementById('serviceStatusId').value;
		var serviceStatus = 1;
		document.getElementById('hinNoDivId').innerHTML = "";
		if (serviceType != 0 && serviceNo != '' && serviceStatus != 0) {
			if (serviceNo != 0) {
				url = "/hms/hms/registration?method=getHinNo&serviceNo="
						+ serviceNo + "&serviceTypeId=" + serviceType
						+ "&relationId=" + relation + "&serviceStatus="
						+ serviceStatus;
			} else {
				alert("Employee No. can not be 0.")
				document.getElementById('serviceNoId').value = "";
			}
		}
	}
	try {
		request = new XMLHttpRequest();
	} catch (e) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	if (url != '') {
		request.open("GET", url, true);
		request.onreadystatechange = callbackFunc;
		request.setRequestHeader("If-Modified-Since",
				"Sat, 1 Jan 2000 00:00:00 GMT");
		request.send(null);
	}

}

function getHinHAL(flag, relationId) {
	

	var url = '';
	
	var serviceNo = document.getElementById('serviceNoId').value;	
	var patientTypeName = document.getElementById('patientTypeName').value;	
	document.getElementById('hinNoDivId').innerHTML = "";
	if (flag == 'registration') {
		/*var patientTypeName = document.getElementById('patientTypeName').value;*/
		
		if (serviceNo != '0') {
		
			url = "/hms/hms/registration?method=getHinNoHAL&patientTypeName="+patientTypeName;
		} else {
			alert("HIN. can not be 0.")
			document.getElementById('serviceNoId').value = "";
		}
	} else {
		
		/*var patientTypeId = document.getElementById('patientTypeId').value;*/
		/*var relationId = document.getElementById('regHinId').value;*/
		if (serviceNo != '0') {
			url = "/hms/hms/registration?method=getHinNoHAL&serviceNo="
					+ serviceNo + "&patientTypeName="+patientTypeName+"&relationId=" + relationId+"&serviceNo="+serviceNo;
		} else {
			alert("Employee No. can not be 0.")
			document.getElementById('serviceNoId').value = "";
		}
	}

	try {
		request = new XMLHttpRequest();
	} catch (e) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	if (url != '') {
		request.open("GET", url, true);
		request.onreadystatechange = callbackFuncHAL;
		request.setRequestHeader("If-Modified-Since",
				"Sat, 1 Jan 2000 00:00:00 GMT");
		request.send(null);
	}

}

function callbackFuncHAL() {

	if ((request.readyState == 4) && (request.status == 200)) {
		// document.getElementById('hinNoDivId').style.display = 'block';
		/*document.getElementById('hinNoDivId').innerHTML = request.responseText;*/
		// document.getElementById('defaulthinno').style.display = 'none';
		
		document.getElementById('hinNoId').value = trimAll(request.responseText);

		
	}
}

function callbackFunc() {

	if ((request.readyState == 4) && (request.status == 200)) {
		// document.getElementById('hinNoDivId').style.display = 'block';
		document.getElementById('hinNoDivId').innerHTML = request.responseText;
		// document.getElementById('defaulthinno').style.display = 'none';
		document.getElementById('hinNoId').value = trimAll(request.responseText);

		if (document.getElementById('relationId').value == '8') {
			if (document.getElementById('sFNameId').value != '') {
				document.getElementById('pFirstNameId').value = document
						.getElementById('sFNameId').value;
			}
			if (document.getElementById('sMNameId').value != '') {
				document.getElementById('pMiddleNameId').value = document
						.getElementById('sMNameId').value;
			}
			if (document.getElementById('sLNameId').value != '') {
				document.getElementById('pLastNameId').value = document
						.getElementById('sLNameId').value;
			}
			if (document.getElementById('srAgeId')
					&& document.getElementById('srAgeId').value != '')
				document.getElementById('ageId').value = document
						.getElementById('srAgeId').value;
			if (document.getElementById('srAgeUnitId')
					&& document.getElementById('srAgeUnitId').value != '')
				document.getElementById('ageUnitId').value = document
						.getElementById('srAgeUnitId').value;
			if (document.getElementById('srdobId')
					&& document.getElementById('srdobId').value != '')
				document.getElementById('dobId').value = document
						.getElementById('srdobId').value;
			if (document.getElementById('srSexId')
					&& document.getElementById('srSexId').value != '')
				document.getElementById('gender').value = document
						.getElementById('srSexId').value;
		}
	}
}

function getMotherName() {
	motherHinNo = document.getElementById('motherHinId').value;
	if (motherHinNo != "") {
		url = "/hms/hms/registration?method=getMothersName&motherHinNo="
				+ motherHinNo;

		try {
			request = new XMLHttpRequest();
		} catch (e) {
			try {
				request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		request.open("GET", url, true);
		request.onreadystatechange = callbackFuncForHin;
		request.send(null);
	}
}

function callbackFuncForHin() {
	if ((request.readyState == 4) && (request.status == 200)) {
		document.getElementById('motherNameId').innerHTML = request.responseText;
		document.getElementById('motherNameId').style.display = 'block';
	}
}

function getMotherAdNo() {
	motherAd = document.getElementById('ad').value;
	if (motherAd != "") {
		url = "/hms/hms/adt?method=getMotherName&motherAd=" + motherAd;

		try {
			request = new XMLHttpRequest();
		} catch (e) {
			try {
				request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		request.open("GET", url, true);
		request.onreadystatechange = responseForMotherName;
		request.send(null);
	}
}

function responseForMotherName() {
	if ((request.readyState == 4) && (request.status == 200)) {
		document.getElementById('motherName').innerHTML = request.responseText;
		document.getElementById('motherName').style.display = 'block';
	}
}
function getFinancialYearInfo() {
	financialId = document.getElementById('financialId').value;
	maxFina = document.getElementById('maxFina').value;
	if (financialId == 0) {
		financialId = maxFina;
	}
	if (financialId == 0) {

		alert('Pl. Select any financial Year!...');
		return;
	}
	budgetCode = document.getElementById('budgetCode').value;
	url = "/hms/hms/pharmacy?method=getFinancialYearDetails&financialId="
			+ financialId + "&budgetCode=" + budgetCode;

	try {
		request = new XMLHttpRequest();
	} catch (e) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	request.open("GET", url, true);
	request.onreadystatechange = responseForFinancial;
	request.send(null);
}

function responseForFinancial() {
	if ((request.readyState == 4) && (request.status == 200)) {
		document.getElementById('financial').innerHTML = request.responseText;
		document.getElementById('financial').style.display = 'block';
		document.getElementById('test').style.display = 'none';
		// calulateBalanceAmount();
	}
}

/*
 * function calulateBalanceAmount(){ var totalAmt =
 * document.getElementById('totalAmt').value; var prevSpendAmt =
 * document.getElementById('prevSpendAmt').value; var spendAmt =
 * document.getElementById('spendAmt').value; //var num1 =
 * document.form1.text1.value-0; //var num2 = document.form1.text2.value-0;
 * //var num3 = parseFloat(num1,10)+parseFloat(num2,10);
 * //document.form1.text3.value = num3; var spend =
 * parseFloat(prevSpendAmt,10)+parseFloat(spendAmt,10); var balance =
 * parseFloat(totalAmt,10)-parseFloat(spend,10);
 * 
 * if(!isNaN(spendAmt) && spendAmt != ""){ if(!isNaN(balance)){
 * document.getElementById('balance').value = balance; } }else{
 * document.getElementById('balance').value = totalAmt; } }
 */

function trimAll(strValue) {
	var objRegExp = /^(\s*)$/;

	// check for all spaces
	if (objRegExp.test(strValue)) {
		strValue = strValue.replace(objRegExp, '');
		if (strValue.length == 0)
			return strValue;
	}

	// check for leading & trailing spaces
	objRegExp = /^(\s*)([\W\w]*)(\b\s*$)/;
	if (objRegExp.test(strValue)) {
		// remove leading and trailing whitespace characters
		strValue = strValue.replace(objRegExp, '$2');
	}
	return strValue;
}

function ajaxFunctionForAutoInDefectiveDrug(formName, action, rowVal) {
	alert("ajax function")
	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var items = xmlHttp.responseXML.getElementsByTagName("items")[0];
			for (loop = 0; loop < items.childNodes.length; loop++) {
				var item = items.childNodes[loop];
				var id = item.getElementsByTagName("id")[0];
				var pvms = item.getElementsByTagName("pvms")[0];
				var au = item.getElementsByTagName("au")[0];
				document.getElementById('codeItem' + rowVal).value = pvms.childNodes[0].nodeValue
				document.getElementById('idItem' + rowVal).value = id.childNodes[0].nodeValue
				document.getElementById('idAu' + rowVal).value = au.childNodes[0].nodeValue
			}
		}
	}
	var url = action + "&" + getNameAndData(formName)

	xmlHttp.open("GET", url, true);

	xmlHttp.send(null);
}

function checkPvmsForAlreadyExist() {
	pvmsNo = document.getElementById('pvmsNo').value;
	var editstyle = document.getElementById('editbutton').style.display;
	if (editstyle != 'inline') {
		url = "/hms/hms/pharmacy?method=checkForExistingPvmsNo1&pvmsNo="
				+ pvmsNo;
		try {
			request = new XMLHttpRequest();
		} catch (e) {
			try {
				request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		request.open("GET", url, true);
		request.onreadystatechange = function() {
			if ((request.readyState == 4)) {
				var items = request.responseXML.getElementsByTagName("items")[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
					var found = item.getElementsByTagName("found")[0]
					if (found.childNodes[0].nodeValue == 'true') {
						alert("Mat. Code Already Exists.");
						document.getElementById('pvmsNo').value = "";
						document.getElementById('pvmsNo').focus();
					}
				}
			}
		}
		request.open("GET", url, true);
		request.send(null);
	}
}




function checkPvmsForAlreadyExistNIP() {
	pvmsNo = document.getElementById('pvmsNo').value;
	var editstyle = document.getElementById('editbutton').style.display;
	if (editstyle != 'inline') {
		url = "/hms/hms/pharmacy?method=checkForExistingPvmsNo1NIP&pvmsNo="
				+ pvmsNo;
		try {
			request = new XMLHttpRequest();
		} catch (e) {
			try {
				request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		request.open("GET", url, true);
		request.onreadystatechange = function() {
			if ((request.readyState == 4)) {
				var items = request.responseXML.getElementsByTagName("items")[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
					var found = item.getElementsByTagName("found")[0]
					if (found.childNodes[0].nodeValue == 'true') {
						alert("Mat. Code Already Exists.");
						document.getElementById('pvmsNo').value = "";
						document.getElementById('pvmsNo').focus();
					}
				}
			}
		}
		request.open("GET", url, true);
		request.send(null);
	}
}
