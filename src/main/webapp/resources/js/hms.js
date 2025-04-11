errorMsg = "";
var childMenuStatus = ""
var parentMenuStatus = ""
var tempVar = "off"
var userUsergroupHospitalArray = new Array();
function getHospital(formName) {

	obj1 = eval('document.' + formName + '.loginName');
	obj2 = eval('document.' + formName + '.password');
	loginName = obj1.value;
	password = obj2.value;
	obj3 = eval('document.' + formName + '.hospital');

	if (loginName == "superadmin") {
		obj3.disabled = true;

	} else {
		obj3.disabled = false;
		obj = eval('document.' + formName)
		obj.action = "/hms/hms/login?method=getHospitalName&loginName="
				+ loginName + "&password=" + password;
		obj.submit();
	}
}

function hospitalList(formName) {

	obj1 = eval('document.' + formName + '.loginName');
	obj2 = eval('document.' + formName + '.password');
	loginName = obj1.value;
	password = obj2.value;
	obj3 = eval('document.' + formName + '.hospitalName');
	if (password != "") {
		if (loginName == "superadmin") {
			obj3.disabled = true;

		} else {

			obj3.disabled = false;
			url = "/hms/hms/login?method=getHospitalName&loginName="
					+ loginName + "&password=" + password;
			retrieveUrl(url);
		}
	}

}

var request = false;
function retrieveUrl(url) {
	try {
		request = new XMLHttpRequest();
	} catch (trymicrosoft) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (othermicrosoft) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (failed) {
				request = false;
			}
		}
	}
	request.open("GET", url, true);
	request.onreadystatechange = updatePage;
	request.send(null);

	if (!request)
		alert("Error initializing XMLHttpRequest!");

}

function updatePage() {
	if ((request.readyState == 4) && (request.status == 200)) {
		if (trimAll(request.responseText) == "Wrong User name or Password") {
			document.getElementById('errorMsg').innerHTML = trimAll(request.responseText);
			document.getElementById('errorMsg').style.display = 'block';
			document.getElementById('loginMsg').style.display = 'none';
			document.getElementById('defaultList').style.display = 'block';
			document.getElementById('responseList').style.display = 'none';

		} else {
			document.getElementById('responseList').innerHTML = request.responseText;
			document.getElementById('defaultList').style.display = 'none';
			document.getElementById('responseList').style.display = 'block';
			document.getElementById('errorMsg').style.display = 'none';

		}
	}
}

function validate(formName) {

	obj1 = eval('document.' + formName + '.userGroup');
	userGroup = obj1.value;

	if (userGroup == 0) {
		errorMsg += "Please select User Group.\n";
	}

	obj2 = eval('document.' + formName + '.access_rights');
	accessRights = obj2.length;

	flag = true;
	for (i = 0; i < accessRights; i++) {
		if (obj2[i].checked == true) {
			flag = true;
			break;
		} else {
			flag = false;
		}

	}
	if (flag == false) {
		errorMsg += "Please select access rights.\n";
	}

	if (errorMsg != "") {
		alert(errorMsg);
		return false;
	} else {
		return true;
	}
}

function checkDelete() {
	if (confirm("Are You sure, You want to delete this country code ?"))
		return true;
	else
		return false;
}
function checkSave() {
	if (confirm("Do you want to save ?"))
		return true;
	else
		return false;
}
function checkSavePrint() {
	if (confirm("Are You sure, You want to Save with Print ?"))
		return true;
	else
		return false;
}
function checkReset() {
	if (confirm("Are You sure, You want to Reset ?"))
		return true;
	else
		return false;
}
function checkReligionDelete() {
	if (confirm("Are You sure, You want to delete this Religion code ?"))
		return true;
	else
		return false;
}

function RadioCheck(formName, radioButtoName, hidName) {
	var selection = eval('document.' + formName + '.' + radioButtoName);
	var temp = 0;

	for (i = 0; i < selection.length; i++)
		if (selection[i].checked == true) {
			temp = selection[i].value;
			obj = eval('document.' + formName + '.' + hidName)
			obj.value = temp;

			return true;
		}

	if (temp == 0) {
		alert('Please Select Country Code ')
		return false;
	}
}

function getCurrency(formName, comboFeildName, textFeildName) {
	var selectedIndex = eval('document.' + formName + '.' + comboFeildName
			+ '.selectedIndex');
	temp = eval('document.' + formName + '.' + comboFeildName
			+ '.options[selectedIndex]');
	var selectedValue = temp.value;

	if (selectedValue != "Select") {
		var temp = eval('document.' + formName + '.' + textFeildName);
		temp.value = selectedValue;

	}
}

function checkDate(formName, dateFeildName) {

	var today = new Date();
	var tempX = today.getYear();
	var tempY = tempX % 100;
	tempY += (tempY < 38) ? 2000 : 1900;
	var year = tempY

	objDate = eval('document.' + formName + '.' + dateFeildName);
	var dateString = objDate.value;

	if (dateString == "") {
		alert('Changed Date can not be blank')
		return false
	}
	try {
		var idx = dateString.indexOf('/');

		if (idx != -1) {
			var pairs = dateString.substring(0, dateString.length).split('/');
			if (pairs.length != 3) {
				alert("Invalid Date.It should be DD/MM/YYYY")
				return false;
			}
			if (pairs[0].length != 2 || pairs[1].length != 2
					|| pairs[2].length != 4) {
				alert("Invalid Date.It should be DD/MM/YYYY")
				return false;
			}

			for (var i = 0; i < pairs.length; i++) {
				vals = eval(pairs[i]);
				if (vals < 0 || vals > 9999) {
					alert("Invalid Date.It should be DD/MM/YYYY")
					return false;
				}
			}

			if (eval(pairs[2]) > year) {
				alert("YEAR Should not be greater than " + year)
				return false
			}

			if (eval(pairs[1]) < 1 || eval(pairs[1]) > 12) {
				alert("Month in between (01,12)");
				return false
			}

			if (eval(pairs[1]) == 1 || eval(pairs[1]) == 3
					|| eval(pairs[1]) == 5 || eval(pairs[1]) == 7
					|| eval(pairs[1]) == 8 || eval(pairs[1]) == 10
					|| eval(pairs[1]) == 12) {
				if (eval(pairs[0]) < 1 || eval(pairs[0]) > 31) {
					alert("Date Should be in 01-31")
					return false;
				}
			}
			if (eval(pairs[1]) == 4 || eval(pairs[1]) == 6
					|| eval(pairs[1]) == 9 || eval(pairs[1]) == 11) {
				if (eval(pairs[0]) < 1 || eval(pairs[0]) > 30) {
					alert("Date Should be in 01-30")
					return false;
				}
			}
			if (eval(pairs[1]) == 2) {
				year1 = (eval(pairs[2]))
				if ((year1 % 4 == 0)) {
					if (year1 % 100 != 0) {
						if (eval(pairs[0]) < 1 || eval(pairs[0]) > 29) {
							alert(" Date Should be in 01-28")
							return false;
						}
					} else {
						if ((year1 % 400 == 0) || (year1 % 4 == 0))
							if (eval(pairs[0]) < 1 || eval(pairs[0]) > 29) {
								alert("Leap Year Date Should be in 01-29")
								return false;
							}

					}

				} else if (eval(pairs[0]) < 1 || eval(pairs[0]) > 28) {
					alert(" Date Should be in 01-28")
					return false;
				}
			}

		} else {
			alert("Invalid Date.It should be DD/MM//YYYY")
			return false;
		}
	} catch (eee) {
		alert("Exp Error");
		return false;
	}

	return true;
}

function checkTime(formName, timeFieldName) {

	objTime = eval('document.' + formName + '.' + timeFieldName);
	var chtime = objTime.value;
	if (chtime == "") {
		alert('Changed Time can not be blank')
		return false
	}

	try {
		var indx = chtime.indexOf(':');

		if (indx != -1) {
			var pairs2 = chtime.substring(0, chtime.length).split(':');
		}

		if (pairs2.length != 2) {
			alert("Invalid Time Format.It should be HH:MM")
			objTime.value = "18:00"
			return false;
		}

		if (pairs2[0].length != 2 || pairs2[1].length != 2) {
			alert("Invalid Time Format.It should be HH:MM")
			objTime.value = "18:00"
			return false;
		}

		val2 = eval(pairs2[0]);

		if (val2 < 0 || val2 > 23) {
			alert("Hours should 00-23")
			objTime.value = "18:00"
			return false;
		}

		val3 = eval(pairs2[1]);

		if (val3 < 0 || val3 > 59) {
			alert("Min should 00-59")
			objTime.value = "18:00"
			return false;
		}

	} catch (e2) {
		alert("Invalid Time")
		objTime.value = "18:00"
		return false;
	}

	return true;
}

// ----------------for Hospital--------------------
function showUpdateHospitalDetails(formName) {

	obj1 = eval('document.' + formName + '.hospitalId');
	hosId = obj1.value;
	obj = eval('document.' + formName)
	obj.action = "/hms/hms/superAdmin?method=showUpdateHospitalWithDetails&hospitalId="
			+ hosId;
	obj.submit();
}

function showDeleteHospitalDetails(formName) {

	obj1 = eval('document.' + formName + '.hospitalId');
	hosId = obj1.value;
	obj = eval('document.' + formName)
	obj.action = "/hms/hms/superAdmin?method=showDeleteHospitalWithDetails&hospitalId="
			+ hosId;
	obj.submit();
}

function nextButtonState(formName, nextState) {

	if (nextState == "disable") {
		obj1 = eval('document.' + formName + '.next');
		obj1.disabled = true;

		return false
	} else
		return true

}

function previousButtonState(formName, previousState) {

	if (previousState == "disable") {
		obj1 = eval('document.' + formName + '.previous');
		obj1.disabled = true;
		return false;
	} else {
		obj1 = eval('document.' + formName + '.previous');
		obj1.disabled = false;
		return true;
	}

}

function checkDelete() {
	if (confirm("Are You sure, You want to delete this Relation ?"))
		return true;
	else
		return false;
}

function showDetails(formName, action) {

	obj = eval('document.' + formName)
	obj.action = action;
	obj.submit();
}

function showUpdatePatientDetails(formName) {
	alert("inside showUpdatePatientDetails function ");
	alert('document.' + formName + '.patient_id');
	obj1 = eval('document.' + formName + '.patient_id');
	alert(obj1);
	patientId = obj1.value;

	obj = eval('document.' + formName)
	obj.action = "/hms/hms/generalMaster?method=showUpdatePatientWithDetails&patientId="
			+ patientId;
	obj.submit();
}

function showDeletePatientDetails(formName) {
	obj1 = eval('document.' + formName + '.patient_id');
	alert(obj1);
	patientId = obj1.value;
	obj = eval('document.' + formName)
	obj.action = "/hms/hms/generalMaster?method=showDeletePatientWithDetails&patientId="
			+ patientId;
	obj.submit();

}

/*-----------------------------Menu------------------------------------*/
openNode = 0;
mouseOn = 0;
function makeMainMenu() {

	cnt = 0;
	temp = '<ul onClick="setOpenNode(this.parentNode)">';
	for (i = 0; i < menu.length; i++) {
		if (menu[i][1] != 0 && menu[i][1] == menu[i][4]) {
			cnt++;
			var menuurl = menu[i][3].substring(0, 1);
			if (menuurl != '#') {
				temp += '<li  id="'
						+ menu[i][0]
						+ '" class="menu'
						+ cnt
						+ '"><a href="#" onclick="submitFormForButton(\'navigation\',\''
						+ menu[i][3] + '\');showMenu(this.parentNode)">'
						+ menu[i][2] + '</a></li>';
			} else {
				temp += '<li  id="' + menu[i][0] + '" class="menu' + cnt
						+ '"><a href="' + menu[i][3]
						+ '" onclick="showMenu(this.parentNode)">' + menu[i][2]
						+ '</a></li>';
			}
		}
	}
	cnt++;
	temp += '<li  id="A324" class="menu'
			+ cnt
			+ '"><a href="#" onClick="showMenu(this.parentNode)" >Security</a></li>';
	temp += '</ul>';
	document.getElementById('menu').innerHTML = temp;
}
isMenu = false;
function showMenu(obj) {
	if (obj.id == mouseOn) {
		return;
	}
	if (document.getElementById('appletId')) {
		document.getElementById('appletId').style.visibility = 'hidden';
	}

	mouseOn = obj.id;
	isMenu = true;

	findOpenSibling(obj.id);

	// ====This is the block of code to to remove menu
	// when you click in same menu again

	if (childMenuStatus != obj.id) {
		childMenuStatus = obj.id
		if (childMenuStatus == parentMenuStatus) {
			childMenuStatus = ""
			parentMenuStatus = ""
			return true
		}
	} else {
		childMenuStatus = ""
		if (parentMenu(obj.id) == 0)
			parentMenuStatus = ""

		return true
	}

	if (parentMenu(obj.id) == 0) {
		if (obj.id == parentMenuStatus) {
			parentMenuStatus = ""
			return true
		}
		parentMenuStatus = obj.id
	}

	// ======================================

	addEvent(obj, 'mouseover', findRes);
	tmptxt = '<ul >';
	for (j = 0; j < menu.length; j++) {
		if (menu[j][1] == obj.id) {

			tmptxt += '<li id="' + menu[j][0] + '"><a ';
			if (hasChild(menu[j][0])) {
				tmptxt += ' class="" ';
			}
			var menuurl = menu[j][3].substring(0, 1);
			if (menuurl != '#') {
				tmptxt += ' href="#" onClick="submitFormForButton(\'navigation\',\''
						+ menu[j][3]
						+ '\');showMenu(this.parentNode)" >'
						+ menu[j][2] + '</a></li>';
			} else {
				tmptxt += ' href="#" onClick="showMenu(this.parentNode)" href="'
						+ menu[j][3] + '">' + menu[j][2] + '</a></li>';
			}
		}
	}
	tmptxt += '</ul>';
	if (tmptxt != '<ul></ul>') {
		obj.innerHTML += tmptxt;
		findRes(obj);
		openNode = obj.id;
	}
}
function hasChild(id) {
	for (a = 0; a < menu.length; a++) {
		if (menu[a][1] == id)
			return true;
	}
	return false;
}
function findRes(ob) {
	if (ob && ob.id) {
		allowedWidth = ((checkWidth() - 780) / 2) + 780;
		pNode = findElement(ob.id);
		if (ob.childNodes[1]) {
			currentPos = findPosX(ob) + 172;
			if (currentPos > allowedWidth && menu[pNode][1] == 0) {
				if (171 - findPosY(ob) > 0) {
					ob.childNodes[1].style.marginLeft = '-'
							+ (171 - findPosY(ob)) + 'px';
				}
			} else if ((currentPos + 172) > allowedWidth && menu[pNode][1] != 0) {
				ob.childNodes[1].style.marginLeft = '';
			}
		}

	}
}
function findOpenSibling(id) {
	prnt = parentMenu(id);

	for (m = 0; m < menu.length; m++) {
		if (menu[m][1] == prnt) {
			if (document.getElementById(menu[m][0])
					&& document.getElementById(menu[m][0]).innerHTML
							.toUpperCase().indexOf('<UL') != -1)
				removeMenu(menu[m][0]);
		}
	}

}
function setOpenNode(obj) {
	if (obj) {
		isMenu = false;
		// To Set the value for mouse time out in MENU
		// tmout = setTimeout("checkIfOpen()",1000);
	}
}

function checkIfOpen() {
	if (!isMenu) {
		makeMainMenu();
		openNode = 0;
		mouseOn = 0;
	}
}
function parentMenu(id) {
	for (l = 0; l < menu.length; l++) {
		if (menu[l][0] == id)
			return menu[l][1];
	}
}

function removeMenu(id) {
	for (k = 0; k < menu.length; k++) {
		if (menu[k][0] == id) {
			if (document.getElementById(id)) {
				tmTxt = '<a ';
				if (menu[k][1] != 0 && hasChild(id))
					tmTxt += 'class=""';

				var menuurl = menu[k][3].substring(0, 1);
				if (menuurl != '#') {
					tmTxt += 'onClick="showMenu(this.parentNode);setOpenNode(this.parentNode);submitFormForButton(\'navigation\',\''
							+ menu[k][3] + '\');">' + menu[k][2] + '</a>';
				} else {
					tmTxt += 'onClick="showMenu(this.parentNode);setOpenNode(this.parentNode);" href="'
							+ menu[k][3] + '">' + menu[k][2] + '</a>';
				}
				document.getElementById(id).innerHTML = tmTxt;
			}
		}
	}
}
function isNodeOpen(id) {
	if (document.getElementById(parentMenu(id)))
		removeMenu(parentMenu(id));
}

function addEvent(obj, type, fn) {
	if (obj.attachEvent) {
		obj['e' + type + fn] = fn;
		obj[type + fn] = function() {
			obj['e' + type + fn](window.event);
		};
		obj.attachEvent('on' + type, obj[type + fn]);
	} else
		obj.addEventListener(type, fn, false);
}

function removeEvent(obj, type, fn) {
	if (obj.detachEvent) {
		obj.detachEvent('on' + type, obj[type + fn]);
		obj[type + fn] = null;
	} else
		obj.removeEventListener(type, fn, false);
}
function checkWidth() {
	var myWidth = 0;
	if (typeof (window.innerWidth) == 'number') {
		myHeight = window.innerWidth;
	} else {
		if (document.documentElement
				&& (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
			myHeight = document.documentElement.clientWidth;
		} else {
			if (document.body
					&& (document.body.clientWidth || document.body.clientHeight)) {
				myHeight = document.body.clientHeight;
			}
		}
	}
	return myHeight;
}

function findPosX(obj) {
	var curleft = 0;
	if (obj.offsetParent) {
		while (obj.offsetParent) {
			curleft += obj.offsetLeft;
			obj = obj.offsetParent;
		}
	} else if (obj.x)
		curleft += obj.x;
	return curleft;
}
function findPosY(obj) {
	var curright = 0;
	if (obj.offsetParent) {
		curright += obj.offsetWidth;
	} else if (obj.width)
		curright += obj.width;
	return curright;
}
function findElement(val) {
	for (h = 0; h < menu.length; h++) {
		if (menu[h][0] == val)
			return h;
	}
}

var stateArr = new Array();
districtArray = new Array();
blockArray = new Array();
pincodeArray = new Array();
doctorArr = new Array();
dependentArray = new Array();
genericArray = new Array();
classArray = new Array();
categoryArray = new Array();
districtLocalArray = new Array();

function populateItem(val, formName) {
	populateItemGeneric(val, formName);
	populateItemClass(val, formName);
	populateItemCategory(val, formName);
}

function populateItemGeneric(val, formName) {
	obj = eval('document.' + formName + '.item_generic');
	obj.length = 1;

	for (i = 0; i < genericArray.length; i++) {
		if (genericArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = genericArray[i][1];
			obj.options[obj.length - 1].text = genericArray[i][2];
		}
	}
}

function populateItemClass(val, formName) {

	obj = eval('document.' + formName + '.itemClassID');
	obj.length = 1;
	for (i = 0; i < classArray.length; i++) {
		if (classArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = classArray[i][1];
			obj.options[obj.length - 1].text = classArray[i][2];
		}
	}
}

function populateItemCategory(val, formName) {

	obj = eval('document.' + formName + '.itemCategoryId');
	obj.length = 1;

	for (i = 0; i < categoryArray.length; i++) {
		if (categoryArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = categoryArray[i][1];
			obj.options[obj.length - 1].text = categoryArray[i][2];
		}
	}
}

// ----------------------For
// Registration------------------------------------------------------------

function populateState(val, formName) {

	obj = eval('document.' + formName + '.state');
	obj.length = 1;
	for (i = 0; i < stateArr.length; i++) {
		if (stateArr[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = stateArr[i][1];
			obj.options[obj.length - 1].text = stateArr[i][2];
		}
	}
}

function populateDistrict(val, formName, cityFieldId) {
	// obj = eval('document.'+formName+'.district');
	obj = document.getElementById(cityFieldId);
	obj.length = 1;

	if (val != 0) {
		for (i = 0; i < districtArray.length; i++) {
			if (districtArray[i][0] == val) {
				obj.length++;
				obj.options[obj.length - 1].value = districtArray[i][1];
				obj.options[obj.length - 1].text = districtArray[i][2];
			}
		}
	} else {
		for (i = 0; i < districtArray.length; i++) {
			obj.length++;
			obj.options[obj.length - 1].value = districtArray[i][1];
			obj.options[obj.length - 1].text = districtArray[i][2];
		}
	}

}
function populateDistrictLocal(val, formName) {
	obj = eval('document.' + formName + '.localCity');
	obj.length = 1;
	for (i = 0; i < districtLocalArray.length; i++) {
		if (districtLocalArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = districtLocalArray[i][1];
			obj.options[obj.length - 1].text = districtLocalArray[i][2];
		}
	}
}
function populateBlock(val, formName) {
	obj = eval('document.' + formName + '.block');
	obj.length = 1;
	for (i = 0; i < blockArray.length; i++) {
		if (blockArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = blockArray[i][1];
			obj.options[obj.length - 1].text = blockArray[i][2];
		}
	}
}

var supplierArray = new Array();
function populateSupplier(val, formName) {

	obj = eval('document.' + formName + '.grnGrid');
	obj.length = 1;
	alert("obj.length    " + obj.length)
	for (i = 0; i < supplierArray.length; i++) {
		if (supplierArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = supplierArray[i][1];
			obj.options[obj.length - 1].text = supplierArray[i][2];
		}
	}
}

function populatePincode(val, formName) {
	obj = eval('document.' + formName + '.pincode');
	obj.length = 1;
	for (i = 0; i < pincodeArray.length; i++) {
		if (pincodeArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = pincodeArray[i][1];
			obj.options[obj.length - 1].text = pincodeArray[i][2];
		}
	}
}

function populateDoctor(val, formName) {
	obj = eval('document.' + formName + '.consultingDoctor');
	obj.length = 1;
	for (i = 0; i < doctorArr.length; i++) {
		if (doctorArr[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = doctorArr[i][1];
			obj.options[obj.length - 1].text = doctorArr[i][2];
		}
	}
}
function populateDoctorName(val, formName) {
	obj = eval('document.' + formName + '.employeeId');
	obj.length = 1;
	for (i = 0; i < doctorArr.length; i++) {
		if (doctorArr[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = doctorArr[i][1];
			obj.options[obj.length - 1].text = doctorArr[i][2];
		}
	}
}

function showInsurance(obj, formName) {
	insuranceNo = eval('document.' + formName + '.insuranceNumber');
	validFrom = eval('document.' + formName + '.validFromDate');
	validTo = eval('document.' + formName + '.validToDate');

	if (obj.checked) {
		insuranceNo.setAttribute('validate', 'Insurance Number,string,yes');
		validFrom.setAttribute('validate', 'Valid From Date,date,yes');
		validTo.setAttribute('validate', 'Valid To Date,date,yes');
		document.getElementById('insurance').style.display = 'block';
	} else {
		insuranceNo.setAttribute('validate', 'Insurance Number,string,no');
		validFrom.setAttribute('validate', 'Valid From Date,string,no');
		validTo.setAttribute('validate', 'Valid To Date,string,no');
		document.getElementById('insurance').style.display = 'none';
	}
}

function populateAge(type, obj1) {
	temp = obj1.value;
	obj1.length = 1;
	if (type == "month")
		till = 12;
	else if (type == "day")
		till = 30;
	else if (type == "year")
		till = 100;
	for (i = 0; i < till; i++) {
		obj1.length++
		obj1.options[i + 1].value = i + 1;
		obj1.options[i + 1].text = i + 1;
	}
	obj1.value = temp;
}

function checkOnTitle() {
	obj = document.getElementById("titleId");
	obj1 = document.getElementsByName("gender");

	var title = obj.options[obj.selectedIndex].text;
	if (title == "Mrs" || title == "Ms" && obj1.value != "feMale") {
		alert("Sorry! Wrong Selection,Please choose according to Title.")
		obj1[1].checked = true;
	}
	if (title == "Mr" || title == "Master" && obj1.value != "Male") {
		alert("Sorry! Wrong Selection,Please choose according to Title.")

		obj1[0].checked = true;
	}

}

subChargeArray = new Array();

function populateSubCharge(val, formName) {
	obj = eval('document.' + formName + '.subChargeCode_id');
	obj.length = 1;
	for (i = 0; i < subChargeArray.length; i++) {
		if (subChargeArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = subChargeArray[i][1];
			obj.options[obj.length - 1].text = subChargeArray[i][2];
		}
	}
}

subChargeArray1 = new Array();

function populateSubChargeCode(val, formName) {
	obj1 = eval('document.' + formName + '.subChargeCodeId');
	obj1.length = 1;
	for (i = 0; i < subChargeArray1.length; i++) {
		if (subChargeArray1[i][0] == val) {
			obj1.length++;
			obj1.options[obj1.length - 1].value = subChargeArray1[i][1];
			obj1.options[obj1.length - 1].text = subChargeArray1[i][2];
		}
	}
}

chargeCodeArray = new Array();

function populateCharge(val, formName) {
	obj = eval('document.' + formName + '.chargeCodeId');
	obj.length = 1;
	for (i = 0; i < chargeCodeArray.length; i++) {
		if (chargeCodeArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = chargeCodeArray[i][1];
			obj.options[obj.length - 1].text = chargeCodeArray[i][2];
		}
	}
}

function showComboAccordingToPatientType(formName) {
	var patientTypeObj = eval('document.' + formName + '.patientType');
	var company = eval('document.' + formName + '.Company');
	var project = eval('document.' + formName + '.Project');
	var insurance = eval('document.' + formName + '.Insurance');
	var staff = eval('document.' + formName + '.staff');
	var dependent = eval('document.' + formName + '.staffDependent');
	var referral = eval('document.' + formName + '.referral');
	var retired = eval('document.' + formName + '.retiredStaff');

	var patientTypeInitial = patientTypeObj.options[patientTypeObj.selectedIndex].text;

	var patientType = patientTypeInitial;
	company.setAttribute('validate', 'Company,string,no');
	insurance.setAttribute('validate', 'Insurance,string,no');
	project.setAttribute('validate', 'Project,string,no');

	if (patientType == 'Company') {
		document.getElementById('Company').style.display = 'block';
		company.setAttribute('validate', 'Company,string,yes');
	} else {
		document.getElementById('Company').style.display = 'none';
		company.setAttribute('validate', 'Company,string,no');
	}

	if (patientType == 'Insurance') {
		document.getElementById('Insurance').style.display = 'block';
		insurance.setAttribute('validate', 'Insurance,string,yes');

	} else {
		document.getElementById('Insurance').style.display = 'none';
		insurance.setAttribute('validate', 'Insurance,string,no');
	}

	if (patientType == 'Project') {
		document.getElementById('Project').style.display = 'block';
		project.setAttribute('validate', 'Project,string,yes');

	} else {
		document.getElementById('Project').style.display = 'none';
		project.setAttribute('validate', 'Project,string,no');
	}

	if (patientType == 'Staff') {
		document.getElementById('Staff').style.display = 'block';
		staff.setAttribute('validate', 'Staff,string,yes');
	} else {
		document.getElementById('Staff').style.display = 'none';
		staff.setAttribute('validate', 'Staff,string,no');
	}

	if (patientType == 'Staff Dependant') {

		document.getElementById('Dependent').style.display = 'block';
		dependent.setAttribute('validate', 'Staff Dependent,string,yes');

		document.getElementById('Staff').style.display = 'block';
		staff.setAttribute('validate', 'Staff,string,yes');

	} else {
		document.getElementById('Dependent').style.display = 'none';
		dependent.setAttribute('validate', 'Staff Dependent,string,no');

	}

	if (patientType == 'Referral') {
		document.getElementById('Referral').style.display = 'block';
		referral.setAttribute('validate', 'Referral,string,yes');

	} else {
		document.getElementById('Referral').style.display = 'none';
		referral.setAttribute('validate', 'Referral,string,no');
	}

	if (patientType == 'Retired') {
		document.getElementById('Retired').style.display = 'block';
		retired.setAttribute('validate', 'Retired,string,yes');

	} else {
		document.getElementById('Retired').style.display = 'none';
		retired.setAttribute('validate', 'Retired,string,no');
	}

}

function populateStaffDependent(val, formName) {
	obj = eval('document.' + formName + '.staffDependent');
	obj.length = 1;
	for (i = 0; i < dependentArray.length; i++) {
		if (dependentArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = dependentArray[i][1];
			obj.options[obj.length - 1].text = dependentArray[i][2];
		}
	}
}

officeAddArr = new Array();
function populateRecordOfficeAddress(val, formName) {
	obj = eval('document.' + formName + '.recordOfficeAddressId');
	obj.length = 1;
	for (i = 0; i < officeAddArr.length; i++) {
		if (officeAddArr[i][0] == val) {
			obj.length++;
			if (obj.options) {
				obj.options[obj.length - 1].value = officeAddArr[i][1];
				obj.options[obj.length - 1].text = officeAddArr[i][2];
			}
		}
	}
}

rankArr = new Array();
function populateRank(formName) {
	/*
	 * var servTypeObj = eval(document.getElementById('serviceTypeId')) var
	 * servType = servTypeObj.value; obj = eval('document.'+formName+'.rankId');
	 * obj.length = 1; for(i=0;i<rankArr.length;i++){ if(rankArr[i][0] ==
	 * servType){ obj.length++; if(obj.options){
	 * obj.options[obj.length-1].value=rankArr[i][1];
	 * obj.options[obj.length-1].text=rankArr[i][2]; } } }
	 */

	var servStatusObj = eval(document.getElementById('serviceStatusId'))
	var servStatus = servStatusObj.value;
	var servTypeObj = eval(document.getElementById('serviceTypeId'))
	var servType = servTypeObj.value;

	obj = eval('document.' + formName + '.rankId');
	obj.length = 1;
	for (i = 0; i < rankArr.length; i++) {
		if (rankArr[i][1] == servType) {
			if (rankArr[i][0] == servStatus) {
				obj.length++;
				obj.options[obj.length - 1].value = rankArr[i][2];
				obj.options[obj.length - 1].text = rankArr[i][3];
			}
		}
	}
}

var tradeArr = new Array();
function populateTrade(val, formName) {
	obj = eval('document.' + formName + '.tradeId');
	obj.length = 1;
	for (i = 0; i < tradeArr.length; i++) {
		if (tradeArr[i][0] == val) {
			obj.length++;
			if (obj.options) {
				obj.options[obj.length - 1].value = tradeArr[i][1];
				obj.options[obj.length - 1].text = tradeArr[i][2];
			}
		}
	}
}
// ------------------------------------------------------------------

function checkBlankForAddBed() {

	var ward = document.getElementById("wardId").value;
	var room = document.getElementById("roomId").value;
	var bedStatus = document.getElementById("bedStatusId").value;

	if (trimAll(ward) == "") {
		errorMsg += "Ward cannot be blank.\n";
	}
	if (trimAll(room) == "") {
		errorMsg += "Room Code cannot be blank.\n";
	}
	if (trimAll(bedStatus) == "") {
		errorMsg += "Bed Status cannot be blank.\n";
	}
	return true;
}

function checkBlankForAddDepartment() {

	var departmentType = document.getElementById("departmentTypeId").value;
	var costCenter = document.getElementById("costCenterId").value;
	var id = document.getElementById("id").value;

	if (trimAll(id) == "") {
		errorMsg += "Code cannot be blank.\n";
	}
	if (trimAll(departmentType) == "") {
		errorMsg += "Department Type cannot be blank.\n";
	}
	if (trimAll(costCenter) == "") {
		errorMsg += "Cost Center cannot be blank.\n";
	}
	return true;
}

function checkBlankForAddHospital() {

	var hospitalCode = document.getElementById("hospitalCode").value;
	var hospitalAdd = document.getElementById("hospitalAdd").value;
	var hospitalContact = document.getElementById("hospitalContact").value;

	if (trimAll(hospitalCode) == "") {
		errorMsg += "Code cannot be blank.\n";
	}
	if (trimAll(hospitalAdd) == "") {
		errorMsg += "Address cannot be blank.\n";
	}
	if (trimAll(hospitalContact) == "") {
		errorMsg += "Phone Number cannot be blank.\n";
	}
	return true;
}

function fetchUserHospValues(obj, formName) {

	object = eval('document.' + formName)
	obj2 = eval('document.' + formName + '.hiddenUserId')

	if (obj.selectedIndex != "") {

		for (var i = 0; i < userUsergroupHospitalArray.length; i++) {

			if (userUsergroupHospitalArray[i][2] == obj.value
					&& userUsergroupHospitalArray[i][1] == obj2.value) {
				object.userUserGroupHospId.value = userUsergroupHospitalArray[i][0];
				object.validDate.value = userUsergroupHospitalArray[i][3];
				object.changed_by.value = userUsergroupHospitalArray[i][4];
				object.changed_date.value = userUsergroupHospitalArray[i][5];
				object.changed_time.value = userUsergroupHospitalArray[i][6];
				break;
			}
		}
	} else {
		alert("In else")
	}
}

function checkBlankForAddUserMaintenence() {

	var hospName = document.getElementById("hospId").value;

	if ((hospName == "") || (hospName == 0)) {

		errorMsg += "Hospital Name can not be blank.\n";

		return false;
	}

	return true;

}
function checkBlankForAddUser() {
	var user_name = document.getElementById("userId").value;
	var password = document.getElementById("pwd").value;

	if ((user_name == "") || (password == "")) {
		if (user_name == "")
			errorMsg += "User Name can not be blank.\n";
		if (password == "")
			errorMsg += "Password can not be blank.\n";
		return false;
	}

	return true;

}

function filterDoctor(val, formName) {
	var departmentId = val;
	alert(departmentId)
	obj = eval('document.' + formName);
	obj.action = "/hms/hms/registration?method=filterDoctorList&departmentId="
			+ departmentId;
	obj.submit();

}

function check(formName) {
	if (document.getElementById('searchField').value == '') {
		alert("Please enter in textfield");
		return false;
	} else {
		new Ajax.Updater('statusMessage',
				'/hms/hms/registration?method=showVisitDetails', {
					asynchronous : true,
					evalScripts : true,
					parameters : Form.serialize(formName)
				});
	}
}

function searchAdmission(formName) {
	if (document.getElementById('searchField').value == '') {
		alert("Please enter in textfield");
		return false;
	} else {
		new Ajax.Updater('statusMessage',
				'/hms/hms/adt?method=searchPatientDetailsForAdmission', {
					asynchronous : true,
					evalScripts : true,
					parameters : Form.serialize(formName)
				});
	}
}

function checkServiceType(obj) {
	document.getElementById('hinNoId').innerHtml = '';
	if (obj == '7') {
		document.getElementById('rankId').value = "0";
		document.getElementById('sFNameId').value = "";
		document.getElementById('sMNameId').value = "";
		document.getElementById('sLNameId').value = "";
		document.getElementById('tradeId').value = "0";
		document.getElementById('unitId').value = "0";
		document.getElementById('newUnitId').value = "";
		document.getElementById('newUnitAddressId').value = "";
		document.getElementById('suffixId').value = "";
		document.getElementById('relationId').value = '8';
		document.getElementById('totalServYrs').value = "";
		document.getElementById('stationId').value = "";
		document.getElementById('sFNameId').setAttribute('validate',
				'First Name of Service Person,string,no');
		document.getElementById('suffixId').setAttribute('validate',
				'Suffix,string,no');
		document.getElementById('rankId').setAttribute('validate',
				'Rank,string,no');
		document.getElementById('serviceNoId').setAttribute('validate',
				'Employee No,string,no');
		document.getElementById('relationId').setAttribute('validate',
				'Relation,string,no');
		document.getElementById('unitId').setAttribute('validate',
				'Unit,string,no');
		document.getElementById('srNoDiv').style.display = 'none';
		document.getElementById('rankDivId').style.display = 'none';

		document.getElementById('srPrDtDiv').style.display = 'none';
		document.getElementById('afDiv').style.display = 'none';
	} else {
		document.getElementById('srNoDiv').style.display = 'block';
		document.getElementById('rankDivId').style.display = 'block';
		document.getElementById('srPrDtDiv').style.display = 'block';
		document.getElementById('afDiv').style.display = 'block';
		document.getElementById('sFNameId').value = "";
		document.getElementById('sMNameId').value = "";
		document.getElementById('sLNameId').value = "";
		document.getElementById('pFirstNameId').value = "";
		document.getElementById('pMiddleNameId').value = "";
		document.getElementById('pLastNameId').value = "";
		document.getElementById('suffixId').setAttribute('validate',
				'Suffix,string,no');
		document.getElementById('rankId').setAttribute('validate',
				'Rank,string,yes');
		document.getElementById('serviceNoId').setAttribute('validate',
				'Employee No,String,yes');
		document.getElementById('sFNameId').setAttribute('validate',
				'Service Person First Name,name,yes');
		document.getElementById('relationId').setAttribute('validate',
				'Relation,string,no');
		document.getElementById('unitId').setAttribute('validate',
				'Unit,string,yes');
		setTimeout(
				"getServicePersonName('registration','registration?method=getServicePersonName&type=registration')",
				800);
		// setTimeout("populateRank('registration')",1800);
	}
	setTimeout("getHin()", 200);

}
// bad implementation
function sleep(milliSeconds) {
	var startTime = new Date().getTime(); // get the current time
	while (new Date().getTime() < startTime + milliSeconds)
		; // hog cpu
}
function checkForNewBorn(obj) {
	if (document.getElementById('caseId').value == 11) {
		document.getElementById('motherAD').style.display = 'block';
	} else {
		document.getElementById('motherAD').style.display = 'none';
	}
}

tokenArr = new Array();
function displayTokenNo(obj) {
	if (document.getElementById('deptId').value == '0') {
		document.getElementById('tokenNoId').value = '';
	} else {
		if (tokenArr[0] == obj) {
			document.getElementById('tokenNoId').value = tokenArr[1];
		} else {
			document.getElementById('tokenNoId').value = '1';
		}
	}
}

bedArr = new Array();
function populateBed(val, formName) {
	obj = eval('document.' + formName + '.toBed');
	obj.length = 1;
	for (i = 0; i < bedArr.length; i++) {
		if (bedArr[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = bedArr[i][1];
			obj.options[obj.length - 1].text = bedArr[i][2];
		}
	}
}

function checkConditionForList() {
	var condition = document.getElementById('conditionId').value;
	if (condition == 'Critical') {
		document.getElementById('listId').disabled = false;
		document.getElementById('listdateId').disabled = false;
		document.getElementById('listtimeId').disabled = false;
	} else {
		document.getElementById('listId').value = "0";
		document.getElementById('listdateId').value = "";
		document.getElementById('listtimeId').value = "";
		document.getElementById('listId').disabled = true;
		document.getElementById('listdateId').disabled = true;
		document.getElementById('listtimeId').disabled = true;
	}

}

function showList(formName) {
	obj = eval('document.' + formName);
	obj.action = "/hms/hms/adt?method=showReadyToDischargeList";
	obj.submit();

}

function checkDischargeStatus() {
	var disSatus = document.getElementById('disSatus');
	var disposedTo = document.getElementById('disposedTo');
	var disposalId = document.getElementById('disposalId');

	if (disSatus.value == 3 && disposedTo.value == 16 && disposalId.value == 8) {
		document.getElementById('dischargeAddId').disabled = false;
		document.getElementById('expiryDetailsId').style.display = 'inline';

	} else {
		document.getElementById('dischargeAddId').disabled = false;
		document.getElementById('expiryDetailsId').style.display = 'none';

	}
}

function checkServiceCardStatus(obj) {
	var serviceStatusId = document.getElementById('serviceStatusId').value
	if (obj == "n" || serviceStatusId == 2) {
		document.getElementById('cardValidityId').value = "";
		document.getElementById('depIssueDateId').value = "";
		document.getElementById('cardValidityId').disabled = true;
		document.getElementById('depIssueDateId').disabled = true;
		document.getElementById('doiCardImgId').style.display = 'none';
		document.getElementById('cardValidityId').setAttribute('validate',
				'I-Card Valid,string,no');
		document.getElementById('depIssueDateId').setAttribute('validate',
				'D_O_I Dep Card,string,no');
	} else {
		document.getElementById('cardValidityId').disabled = false;
		document.getElementById('depIssueDateId').disabled = false;
		document.getElementById('doiCardImgId').style.display = 'inline';
		if (document.getElementById('relationId').value != 8)
			document.getElementById('cardValidityId').setAttribute('validate',
					'I-Card Valid,string,yes');
		document.getElementById('depIssueDateId').setAttribute('validate',
				'D_O_I Dep Card,string,no');

	}

}
function upCheckServiceCardStatus(obj) {
	var serviceStatusId = document.getElementById('serviceStatusId').value
	if (obj == "n" || serviceStatusId == 2) {
		document.getElementById('cardValidityId').value = "";
		document.getElementById('depIssueDateId').value = "";
		document.getElementById('cardValidityId').disabled = true;
		document.getElementById('depIssueDateId').disabled = true;
		// document.getElementById('doiCardImgId').style.display = 'none';
		document.getElementById('cardValidityId').setAttribute('validate',
				'I-Card Valid,string,no');
		document.getElementById('depIssueDateId').setAttribute('validate',
				'D_O_I Dep Card,string,no');
	} else {
		document.getElementById('cardValidityId').disabled = false;
		document.getElementById('depIssueDateId').disabled = false;
		// document.getElementById('doiCardImgId').style.display = 'inline';
		if (document.getElementById('relationId').value != 8)
			document.getElementById('cardValidityId').setAttribute('validate',
					'I-Card Valid,string,yes');
		document.getElementById('depIssueDateId').setAttribute('validate',
				'D_O_I Dep Card,string,no');

	}

}
function changeStatus(inc) {
	var status = "status";
	document.getElementById(status + inc).value = "y";
}
function fillClinical(inc) {
	var incPulse = "incPulse";
	var incResp = "incResp";
	var incBp = "incBp";
	var incFhr = "incFhr";
	var incRemarks = "incRemarks";
	var incPulseTemp = "incPulseTemp";
	var incRespTemp = "incRespTemp";
	var incBpTemp = "incBpTemp";
	var incFhrTemp = "incFhrTemp";
	var incRemarksTemp = "incRemarksTemp";
	var status = "status";

	document.getElementById(status + inc).value = "y";
	if (document.getElementById(incPulseTemp + inc).value != "") {
		document.getElementById(incPulse + inc).value = document
				.getElementById(incPulseTemp + inc).value
	} else
		document.getElementById(incPulse + inc).value = 0

	if (document.getElementById(incRespTemp + inc).value != "") {
		document.getElementById(incResp + inc).value = document
				.getElementById(incRespTemp + inc).value
	} else
		document.getElementById(incResp + inc).value = 0

	if (document.getElementById(incBpTemp + inc).value != "") {
		document.getElementById(incBp + inc).value = document
				.getElementById(incBpTemp + inc).value
	} else
		document.getElementById(incBp + inc).value = 0

		/*
		 * if(document.getElementById(incFhrTemp+inc).value!=""){
		 * document.getElementById(incFhr+inc).value=document.getElementById(incFhrTemp+inc).value }
		 * else document.getElementById(incFhr+inc).value="emptyString";
		 * 
		 * if(document.getElementById(incRemarksTemp+inc).value!=""){
		 * document.getElementById(incRemarks+inc).value=document.getElementById(incRemarksTemp+inc).value }
		 * else document.getElementById(incRemarks+inc).value="emptyString"
		 */
}

errorMsg = "";

function showIntakeOutput(obj, formName) {
	urine = eval('document.' + formName + '.urine');
	stool = eval('document.' + formName + '.stool');
	vom = eval('document.' + formName + '.vom');
	asp = eval('document.' + formName + '.asp');

	if (obj.name == 'urineCheck') {
		if (obj.checked) {
			urine.setAttribute('validate', 'Urine,string,yes');
		} else {
			urine.setAttribute('validate', 'Urine,string,no');

		}
	}
	if (obj.name == 'stoolCheck') {
		if (obj.checked) {
			stool.setAttribute('validate', 'Stool,string,yes');
		} else {
			stool.setAttribute('validate', 'Stool,string,no');

		}
	}
	if (obj.name == 'vomCheck') {
		if (obj.checked) {
			vom.setAttribute('validate', 'Vom,string,yes');
		} else {
			vom.setAttribute('validate', 'Vom,string,no');

		}
	}
	if (obj.name == 'aspCheck') {
		if (obj.checked) {
			asp.setAttribute('validate', 'Asp,string,yes');
		} else {
			asp.setAttribute('validate', 'Asp,string,no');

		}
	}
}
errorMsg = "";
function checkDob() {
	var dob = document.getElementById('dobId').value;
	dateOfBirth = new Date(dob.substring(6), (dob.substring(3, 5) - 1), dob
			.substring(0, 2));
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if (dateOfBirth > currentDate) {
		errorMsg += "Date of Birth is not valid.\n";
		return false;
	}
	return true;

}

function checkFRWIssued(frwIssued) {
	if (frwIssued == 'n') {
		document.getElementById('frwSlNoId').disabled = true;
		document.getElementById('placeOfIssueId').disabled = true;
		document.getElementById('frwSlNoId').setAttribute('validate',
				'FRW Sl. No,string,no');
		document.getElementById('placeOfIssueId').setAttribute('validate',
				'Place of Issue,string,no');
	} else if (frwIssued == 'y') {
		document.getElementById('frwSlNoId').disabled = false;
		document.getElementById('placeOfIssueId').disabled = false;
		document.getElementById('frwSlNoId').setAttribute('validate',
				'FRW Sl. No,alphanumeric,yes');
		document.getElementById('placeOfIssueId').setAttribute('validate',
				'Place of Issue,alphanumeric,yes');
	}

}

function checkValidityOfCard() {
	currentDate = new Date();
	var dependentCardIssue = document.getElementById('depIssueDateId').value;
	var relationId = document.getElementById('relationId').value;
	var serviceStatusId = document.getElementById('serviceStatusId').value;
	var dependentCardIssueDate = new Date(dependentCardIssue.substring(6),
			(dependentCardIssue.substring(3, 5) - 1), dependentCardIssue
					.substring(0, 2));
	var month = dependentCardIssueDate.getMonth() + 1
	var day = dependentCardIssueDate.getDate()
	var year = dependentCardIssueDate.getFullYear()
	var year1 = year + 2
	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	iCardValidity = day + "/" + month + "/" + year1;
	if (relationId != 8)
		document.getElementById('cardValidityId').value = iCardValidity;
	var iCardValidityDate = new Date(iCardValidity.substring(6), (iCardValidity
			.substring(3, 5) - 1), iCardValidity.substring(0, 2));

	if (currentDate < dependentCardIssueDate) {
		alert("Dependent Card Issue Date can not be greater than current date.");
		document.getElementById('depIssueDateId').value = "";
		return false;
	} else {
		if (relationId != 8)
			document.getElementById('cardValidityId').value = iCardValidity;

		var iCardValidityDate = new Date(iCardValidity.substring(6),
				(iCardValidity.substring(3, 5) - 1), iCardValidity.substring(0,
						2));

		if (iCardValidityDate != "") {
			if (iCardValidityDate < currentDate) {
				alert("Dependent Card has been expire.");
			}
		}
	}
	return true;
}

function IsValidTime(timeStr, fieldId) {

	var obj = document.getElementById(fieldId)

	var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;
	if (timeStr != '') {

		var matchArray = timeStr.match(timePat);
		if (matchArray == null) {
			alert("Time should be in HH:MM format.");
			obj.value = "";
			obj.focus();
			return false;
		}
		hour = matchArray[1];
		minute = matchArray[2];
		second = matchArray[4];
		ampm = matchArray[6];

		if (second == "") {
			second = null;
		}
		if (ampm == "") {
			ampm = null
		}

		if (hour < 0 || hour > 23) {
			alert("Hour must be between 0 and 23.");
			obj.value = "";
			obj.focus();
			return false;
		}
		if (minute < 0 || minute > 59) {
			alert("Minute must be between 0 and 59.");
			obj.value = "";
			obj.focus();
			return false;
		}
		if (second != null && (second < 0 || second > 59)) {
			alert("Second must be between 0 and 59.");
			obj.value = "";
			obj.focus();
			return false;
		}
	}
	return true;
}

function IsValidTimeWithBlankCheck(timeStr, fieldId) {
	// Checks if time is in HH:MM:SS format.
	// The seconds are optional.
	if (timeStr != '') {
		var obj = document.getElementById(fieldId)

		var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

		var matchArray = timeStr.match(timePat);
		if (matchArray == null) {
			alert("Time should be in HH:MM format.");
			obj.value = "";
			obj.focus();
			return false;
		}
		hour = matchArray[1];
		minute = matchArray[2];
		second = matchArray[4];
		ampm = matchArray[6];

		if (second == "") {
			second = null;
		}
		if (ampm == "") {
			ampm = null
		}

		if (hour < 0 || hour > 23) {
			alert("Hour must be between 0 and 23.");
			obj.value = "";
			obj.focus();
			return false;
		}
		if (minute < 0 || minute > 59) {
			alert("Minute must be between 0 and 59.");
			obj.value = "";
			obj.focus();
			return false;
		}
		if (second != null && (second < 0 || second > 59)) {
			alert("Second must be between 0 and 59.");
			obj.value = "";
			obj.focus();
			return false;
		}
		return false;
	}
}

// Added by Priyanka Garg on 5th Sept 2008
// for the Appointment Setup JSP and Appointment Investigation setup JSP

function IsValidTimeForSetup(timeStr, fieldId) {
	// Checks if time is in HH:MM:SS format.
	// The seconds are optional.

	var obj = document.getElementById(fieldId)
	// alert(obj.value)
	var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

	var matchArray = timeStr.match(timePat);
	if (obj.value != "" && matchArray == null) {
		alert("Time should be in HH:MM:SS format.");
		obj.value = "";
		obj.focus();
		return false;
	}

	hour = matchArray[1];
	minute = matchArray[2];
	second = matchArray[4];
	ampm = matchArray[6];

	if (second == "") {
		second = null;
	}
	if (ampm == "") {
		ampm = null
	}

	if (hour < 0 || hour > 23) {
		alert("Hour must be between 0 and 23.");
		obj.value = "";
		obj.focus();
		return false;
	}
	if (minute < 0 || minute > 59) {
		alert("Minute must be between 0 and 59.");
		obj.value = "";
		obj.focus();
		return false;
	}
	if (second != null && (second < 0 || second > 59)) {
		alert("Second must be between 0 and 59.");
		obj.value = "";
		obj.focus();
		return false;
	}
	return false;
}



function setOnlineToken(startTokenId, totalTokenId, timeIntervalId,
		totalOnlineTokenId,totalPortalTokenId,totalMobileTokenId, checkORSet) {

	var startToken = document.getElementById(startTokenId).value;
	var totalToken = document.getElementById(totalTokenId).value;
	var timeInterval = document.getElementById(timeIntervalId).value;
	
	if(startToken == "" || timeInterval == "")
	{
	  //alert("blank");
	  return;
	}
	
	if(startToken=="")
		startToken = 0;
	if(totalToken=="")
		totalToken = 0;
	if(timeInterval=="")
		timeInterval = 0;

	var totalOnlineToken = 0;
	var remainder=0;
	
	
 var i = parseInt(startToken) 
	if(totalToken!="" && totalToken>0 && timeInterval!="0"){
	while (i <= totalToken) {
		totalOnlineToken = totalOnlineToken + 1;
		i = +i + +timeInterval;
		}
	}


	if (checkORSet == "1"){
		document.getElementById(totalOnlineTokenId).value = totalOnlineToken;
		remainder = (totalOnlineToken%2);
		
		if(remainder=="0"){
			var divideValue= parseInt(totalOnlineToken/2);
			document.getElementById(totalPortalTokenId).value = divideValue;
			document.getElementById(totalMobileTokenId).value = divideValue;
		}else{
			var divideValue= parseInt(totalOnlineToken/2);
			document.getElementById(totalPortalTokenId).value = (divideValue+1);
			document.getElementById(totalMobileTokenId).value = divideValue;
		}
	}
	else if (checkORSet == "2") {
		if (document.getElementById(totalOnlineTokenId).value > totalOnlineToken) {
			alert("Value should not be greater than " + totalOnlineToken);
			document.getElementById(totalOnlineTokenId).value = totalOnlineToken;
		}
	}
	return totalOnlineToken;

}

var subChargeCodeArray = new Array();

function populateSubChargeCodeForBilling(val, formName) {

	obj = eval('document.' + formName + '.subChargeCodeId');
	obj.length = 1;
	for (i = 0; i < subChargeCodeArray.length; i++) {
		if (subChargeCodeArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = subChargeCodeArray[i][1];
			obj.options[obj.length - 1].text = subChargeCodeArray[i][2];
		}
	}
}

function checkIncidenceDate() {
	var incidenceDate = document.getElementById('incidenceDateId').value;
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);

	var one_day = 1000 * 60 * 60 * 24;
	var incidence = incidenceDate.split("/");
	var date2 = new Date(incidence[2], (incidence[1] - 1), incidence[0])

	diff = Math.ceil((currentDate.getTime() - date2.getTime()) / (one_day));
	if (diff > 8) {
		errorMsg += "Incidence Date can not be older than 8 days from Today.\n";
	}
}
function checkMlcDate() {

	var approxDob = calculateApproxDob();
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	dateToDisplay = day + seperator + month + seperator + year;

	var mlcDateString = document.getElementById('mlcDateId').value;
	var mlcDate = new Date(mlcDateString.substring(6), (mlcDateString
			.substring(3, 5) - 1), mlcDateString.substring(0, 2))
	if (approxDob > mlcDate) {
		alert("MlC Date is not valid.");
		document.getElementById('mlcDateId').value = dateToDisplay;
		return false;
	}
	if (mlcDate > currentDate) {
		alert("MlC Date is not valid.");
		document.getElementById('mlcDateId').value = dateToDisplay;
		return false;
	}

	return true;
}
function checkIncidenceDate() {

	var approxDob = calculateApproxDob();
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	dateToDisplay = day + seperator + month + seperator + year;

	var incidenceDateString = document.getElementById('incidenceDateId').value;
	var incidenceDate = new Date(incidenceDateString.substring(6),
			(incidenceDateString.substring(3, 5) - 1), incidenceDateString
					.substring(0, 2))
	if (approxDob > incidenceDate) {
		alert("Incidence Date is not valid.");
		document.getElementById('incidenceDateId').value = dateToDisplay;
		return false;
	}
	if (incidenceDate > currentDate) {
		alert("Incidence Date is not valid.");
		document.getElementById('incidenceDateId').value = dateToDisplay;
		return false;
	}

	return true;
}

function calculateApproxDob() {
	var age = document.getElementById('idForAge').value;
	var obj = age.split(" ");
	currentDateJ = new Date();

	unit = obj[1];
	year = 0;
	month = 0;
	day = 0;
	if (unit == 'Years') {
		year = currentDateJ.getFullYear() - obj[0];
	} else if (unit == 'Months') {
		month = (currentDateJ.getMonth() + 1) - obj[0]
		if (month <= 0) {
			month = month + 12
			year--;
		}
		month = (month < 10) ? "0" + month : month
	} else if (unit == 'Days') {
		day = (currentDateJ.getDate() - obj[0])
		if (day < 0) {
			day = day + 30
			month--;
		}
		day = (day < 10) ? "0" + day : day

	}

	if (year <= 0)
		year = currentDateJ.getFullYear() + year;
	if (month <= 0)
		month = (((currentDateJ.getMonth() + 1) + month) < 10) ? "0"
				+ ((currentDateJ.getMonth() + 1) + month) : ((currentDateJ
				.getMonth() + 1) + month);
	if (day == 0)
		day = (currentDateJ.getDate() < 10) ? "0" + currentDateJ.getDate()
				: currentDateJ.getDate();

	approxDob = new Date(month + "/" + day + "/" + year);
	return approxDob;

}

function validateServiceNo(serviceNo, formtype) {

	if (trimAll(serviceNo) != '' && serviceNo.toLowerCase() != 'onmouseover') {
		// if(validateAlphaNumeric(serviceNo)){
		if (formtype == 'registration') {
			var prefix = document.getElementById('prefix').value
			if (!validateMetaCharacters(prefix)) {
				alert("Employee No. is not valid")
				document.getElementById('prefix').value = "";
				document.getElementById('serviceNoId').value = "";
			}
		}
		/*if (validateMetaCharacters(serviceNo)) {*/
		if (true) {
			var serNo = trimAll(serviceNo);
			if (serNo != 0) {
				if (formtype == 'registration') {
					getServicePersonName('registration',
							'registration?method=getServicePersonName&type='
									+ formtype);
					populatePatientDetails();
				}

				else if (formtype == 'visitEmployee') {
					getServicePersonNameHAL('visitEmployee',
							'registration?method=responseForVisitOfHALEmployees&type='
									+ formtype);

				}
				// getHin();

			} else {
				alert("Employee No. can not be 0.")
				document.getElementById('serviceNoId').value = "";
			}
		} else {
			alert("Employee No is not valid.")
			document.getElementById('serviceNoId').value = "";
		}
	}
}

function validateServiceNoHAL(serviceNo, formtype) {

	if (trimAll(serviceNo) != '' && serviceNo.toLowerCase() != 'onmouseover') {
		// if(validateAlphaNumeric(serviceNo)){
		/*
		 * if(formtype=='registration'){ var
		 * prefix=document.getElementById('prefix').value
		 * if(!validateMetaCharacters(prefix)){ alert("Service No. is not
		 * valid") document.getElementById('prefix').value = "";
		 * document.getElementById('serviceNoId').value = ""; } }
		 */
		/*if (validateMetaCharacters(serviceNo)) {*/
		if (true) {
			var serNo = trimAll(serviceNo);
			if (serNo != 0) {
				if (formtype == 'registration') {
					getServicePersonNameHAL('registration',
							'registration?method=getServicePersonNameHAL&type='
									+ formtype);
				}

				else if (formtype == 'visitOnline') {
					getServicePersonNameHAL('visitOnline',
							'registration?method=getServicePersonNameHAL&type='
									+ formtype);
				}

				else if (formtype == 'visitOther') {
					getServicePersonNameHAL('registration',
							'registration?method=getServicePersonNameHAL&type='
									+ formtype);
				} else if (formtype == 'visitEmployee') {
					getServicePersonNameHAL('visitEmployee',
							'registration?method=responseForVisitOfHALEmployees&type='
									+ formtype);

				}

				/* populatePatientDetailsHAL(); */
				// getHin();
			} else {
				alert("Employee No. can not be 0.")
				document.getElementById('serviceNoId').value = "";
			}
		} else {
			alert("Employee No is not valid.")
			document.getElementById('serviceNoId').value = "";
		}

	}

	
}

function validateServiceNoHALForOnlineVisit(serviceNo, relationId, formtype) {

	/*if (validateMetaCharacters(serviceNo)) {*/
	if (true) {
		if (parseInt(serviceNo) != 0) {
			if (formtype == 'registration') {
				getServicePersonNameHAL('registration',
						'registration?method=getServicePersonNameHAL&type='
								+ formtype);
			}

			else if (formtype == 'visitEmployee') {
				getServicePersonNameHALForOnlineVisit('visitEmployee',
						relationId,
						'registration?method=responseForVisitOfHALEmployees&type='
								+ formtype);

			}

			/* populatePatientDetailsHAL(); */
			// getHin();
		} else {
			alert("Employee No. can not be 0.")
			document.getElementById('serviceNoId').value = "";
		}
	} else {
		alert("Employee No is not valid.")
		document.getElementById('serviceNoId').value = "";
	}

}

function validateNumeric(strValue) {
	var objRegExp = /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;
	return objRegExp.test(strValue);
}

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

// *--------------------------------Functions For Billing
// Module------------------------------*/

function calculateNetAmount(formName, fieldName) {
	var count;
	count = fieldName.substring(8);

	var qtyObj = eval('document.' + formName + '.quantity' + count);
	var amtObj = eval('document.' + formName + '.amount' + count);
	var disAmtObj = eval('document.' + formName + '.discount' + count);

	qty = qtyObj.value;
	amt = amtObj.value;
	var disAmt;
	totalAmt = qty * amt;
	var netAmt;
	if (disAmtObj.value != "" || disAmtObj.value != 0) {
		disAmt = disAmtObj.value;
		netAmt = totalAmt - disAmt;
	} else {
		netAmt = totalAmt
	}
	var netAmtObj = eval('document.' + formName + '.netamount' + count);
	netAmtObj.value = netAmt;
}

function calculateTotalAmt(formName) {
	var len = document.getElementById("chargeDetails").rows.length;
	var totalNetAmt = 0;
	var totalDisAmt = 0;
	for (var i = 1; i < len - 1; i++) {
		var amtObj = eval('document.' + formName + '.netamount' + i);
		var disAmtObj = eval('document.' + formName + '.disamount' + i);
		var amtObjValue = amtObj.value;
		var disAmtObjValue = disAmtObj.value;
		if (amtObjValue != "") {
			totalNetAmt = parseInt(amtObjValue) + parseInt(totalNetAmt);
		}
		if (disAmtObjValue != "") {
			totalDisAmt = parseInt(disAmtObjValue) + parseInt(totalDisAmt);
		}
	}

	document.getElementById('totalNetId').value = totalNetAmt;
	document.getElementById('totalDisId').value = totalDisAmt;
}
var subChargeArray = new Array();

function populateSubCharge(val, formName) {

	obj = eval('document.' + formName + '.subChargeCodeId');
	obj.length = 1;
	for (i = 0; i < subChargeArray.length; i++) {
		if (subChargeArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = subChargeArray[i][1];
			obj.options[obj.length - 1].text = subChargeArray[i][2];
		}
	}
}

function validateCheque(val, inc) {
	if (val != "") {
		if (!validateInteger(val)) {
			alert("Please enter valid Cheque/Credit Card No.");
			document.getElementById('cqeId' + inc).value = "";
			return false;
		}
	}
	return true;
}

function checkForFilledRow() {
	msg = "";
	if (document.getElementById('noOfRecords').value == 0
			|| document.getElementById('noOfRecords').value == "") {
		alert("Please fill atleast one row to submit.");
		return false;
	} else {
		var noOfRecords = document.getElementById('noOfRecords').value;
		for (var i = 1; i <= noOfRecords; i++) {
			if (document.getElementById('advAmt' + i).value == ""
					&& document.getElementById('advAmt' + i).readOnly == false) {
				msg += "Advance Amount can not be blank in row " + i + ".\n";
			}
			if (document.getElementById('paymentModeId' + i).value == "Q"
					|| document.getElementById('paymentModeId' + i).value == "R") {

				if (document.getElementById('cqeId' + i).value == "") {
					msg += "Cheque/Credit card no can not be blank in row " + i
							+ ".\n";
				}
				if (document.getElementById('chqDate' + i).value == "") {
					msg += "Cheque/Credit card date can not be blank in row "
							+ i + ".\n";
				}
				if (document.getElementById('bank' + i).value == "") {
					msg += "Bank can not be blank in row " + i + ".\n";
				}
			}

		}
		if (msg != "") {
			alert(msg);
			return false;
		}
	}

	return true;

}

// -----------------------------------End of
// Billing------------------------------------

function validateFRW() {
	var frwy = document.getElementById('frwIssuedIdY');
	var frwn = document.getElementById('frwIssuedIdN');
	if (frwy && frwn) {
		if (!frwy.checked && !frwn.checked) {
			errorMsg += "Please select FRW Issued.\n";
		} else {
			return true;

		}
	} else {
		return true;
	}

}
// =======================================================================================
// ------------------------------------------- methods by
// ABHA--------------------------
// ========================================================================================
function checkExpiryDate() {

	var exp = document.getElementById('f3').value;
	var manu = document.getElementById('f2').value;

	expiryDate = new Date(exp.substring(6), (exp.substring(3, 5) - 1), exp
			.substring(0, 2));
	manufacturingDate = new Date(manu.substring(6), (manu.substring(3, 5) - 1),
			manu.substring(0, 2));

	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if (expiryDate != "") {
		if (expiryDate < currentDate) {
			errorMsg += "Expiry Date Should  be greater than current date.\n"
			alert("Expiry Date Should  be greater than current date")

			return false;
		}
	}

	if (manufacturingDate != "") {
		if (manufacturingDate < currentDate) {
			errorMsg += "Manufacturing Date Should  be greater than current date.\n"
			alert("Manufacturing Date Should  be greater than current date")

			return false;
		}
	}
	return true;

}

// for non expendable crv
function checkDateForGrid() {
	var exp = document.getElementById('f7').value;
	var installationDate = document.getElementById('f4').value;
	var amcStartDate1 = document.getElementById('f5').value;

	warrantyDate = new Date(exp.substring(6), (exp.substring(3, 5) - 1), exp
			.substring(0, 2));
	installationDate = new Date(installationDate.substring(6),
			(installationDate.substring(3, 5) - 1), installationDate.substring(
					0, 2));
	amcStartDate1 = new Date(amcStartDate1.substring(6), (amcStartDate1
			.substring(3, 5) - 1), amcStartDate1.substring(0, 2));

	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if (warrantyDate != "") {
		if (warrantyDate < currentDate) {

			errorMsg += "Warranty Date Should  be greater than current date.\n"
			alert(errorMsg)
			return false;
		}
	}

	if (installationDate != "") {
		if (installationDate > currentDate) {

			errorMsg += "Installation Date Should  be less than current date.\n"
			alert(errorMsg)
			return false;
		}
	}

	if (amcStartDate1 != "") {
		if (amcStartDate1 < currentDate || amcStartDate1 == currentDate) {

			errorMsg += "AMC Start Date Should  be Future Date.\n"
			alert(errorMsg)
			return false;
		}
	}

	return true;

}

function calculateEndDate() {

	var amcStartDate1 = document.getElementById('f5').value;
	var amcStartYear = amcStartDate1.substring(6);
	var amcStartMonth = amcStartDate1.substring(3, 5) - 1
	var amcStartDate = amcStartDate1.substring(0, 2);

	var amcEndYear = eval(amcStartYear) + 1;
	var amcEndDate1 = amcStartDate + "/" + amcStartMonth + "/" + amcEndYear;

	document.getElementById('f6').value = amcEndDate1;
}

// ==================================================================================
// =========================METHODS END BY
// ABHA====================================
// ================================================================================
/*
function fillPatientName(obj) {
	var objValue = obj.value;
	var relation = document.getElementById('relationId').value;
	if (relation == '0' || relation == '8') {
		if (obj.id == 'sFNameId') {
			document.getElementById('pFirstNameId').value = objValue;
		}
		if (obj.id == 'sMNameId')
			document.getElementById('pMiddleNameId').value = objValue;
		if (obj.id == 'sLNameId')
			document.getElementById('pLastNameId').value = objValue;
		if (obj.id == 'srAgeId') {
			document.getElementById('ageId').value = objValue;
			document.getElementById('ageUnitId').value = document
					.getElementById('srAgeUnitId').value;
			document.getElementById('dobId').value = document
					.getElementById('srdobId').value;
		}
		if (obj.id == 'srSexId')
			document.getElementById('gender').value = objValue;
		if (obj.id == 'serBldGroupId')
			document.getElementById('bldGrp').value = objValue;
		if (obj.id == 'srdobId') {
			document.getElementById('dobId').value = objValue;
			 calculateAgeInAjax(); 
		}

		if (obj.id == 'srmrstatus')
			document.getElementById('mrstatus').value = objValue;
		if (obj.id == 'sraddr') {
			document.getElementById('addr').value = objValue;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		if (obj.id == 'srcityId')
			document.getElementById('cityId').value = objValue;
		if (obj.id == 'srstateId')
			document.getElementById('stateId').value = objValue;

		if (obj.id == 'phoneNo')
			document.getElementById('contactNo').value = objValue;
		if (obj.id == 'mobileNo')
			document.getElementById('depmobileNo').value = objValue;

	}

	if (obj.id == 'srconsultingDocId') {
		document.getElementById('consultingDocId').value = objValue;
	}
	if (relation != '8') {
		var sfName = "";
		var smName = "";
		var slName = "";
		if (document.getElementById('sFNameId').value != "") {
			sfName = document.getElementById('sFNameId').value;
		}
		if (document.getElementById('sMNameId').value != "") {
			smName = document.getElementById('sMNameId').value;
		}
		if (document.getElementById('sLNameId').value != "") {
			slName = document.getElementById('sLNameId').value;
		}
		if (obj.id == 'addr') {
			document.getElementById('sraddr').value = objValue;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		if (obj.id == 'cityId')
			document.getElementById('srcityId').value = objValue;
		if (obj.id == 'stateId')
			document.getElementById('srstateId').value = objValue;

		if (obj.id == 'contactNo')
			document.getElementById('phoneNo').value = objValue;
		if (obj.id == 'depmobileNo')
			document.getElementById('mobileNo').value = objValue;

		// if(sfName != "" || smName != "" || slName != ""){
		// document.getElementById('nokNameId').value = sfName+" "+smName+"
		// "+slName;
		// }
	}
}*/


function fillSelfDetails() {
		/*var objValue = obj.value;*/
	
	var relation = document.getElementById('relationId').value;
	if (relation == '0' || relation == '8') {
		if (document.getElementById('sFNameId') !=null) {
			document.getElementById('pFirstNameId').value = document.getElementById('sFNameId').value;
		}
		if (document.getElementById('sMNameId') !=null )
			document.getElementById('pMiddleNameId').value = document.getElementById('sMNameId').value;
		if (document.getElementById('sLNameId') != null )
			document.getElementById('pLastNameId').value = document.getElementById('sLNameId').value;
		if (document.getElementById('srAgeId') != null ) {
			document.getElementById('ageId').value = document.getElementById('srAgeId').value;
			document.getElementById('ageUnitId').value = document
					.getElementById('srAgeUnitId').value;
			document.getElementById('dobId').value = document
					.getElementById('srdobId').value;
		}
		if (document.getElementById('srSexId') != null )
			document.getElementById('gender').value = document.getElementById('srSexId').value;
		if (document.getElementById('serBldGroupId') != null )
			document.getElementById('bldGrp').value = document.getElementById('serBldGroupId').value;
		if (document.getElementById('srdobId') !=null) {
			document.getElementById('dobId').value = document.getElementById('srdobId').value;
			/* calculateAgeInAjax(); */
		}

		if (document.getElementById('srmrstatus') !=null)
			document.getElementById('mrstatus').value = document.getElementById('srmrstatus').value;
		if (document.getElementById('sraddr') !=null ) {
			document.getElementById('addr').value = document.getElementById('sraddr').value;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		if (document.getElementById('srcityId') !=null )
			document.getElementById('cityId').value = document.getElementById('srcityId').value;
		if (document.getElementById('srstateId') !=null )
			document.getElementById('stateId').value = document.getElementById('srstateId').value;

		if (document.getElementById('phoneNo') !=null )
			document.getElementById('contactNo').value = document.getElementById('phoneNo').value;
		if (document.getElementById('mobileNo') !=null )
			document.getElementById('depmobileNo').value = document.getElementById('mobileNo').value;

	}

	if (document.getElementById('srconsultingDocId') !=null ) {
		document.getElementById('consultingDocId').value = document.getElementById('srconsultingDocId').value;
	}
	if (relation != '8') {
		var sfName = "";
		var smName = "";
		var slName = "";
		if (document.getElementById('sFNameId') !=null ) {
			sfName = document.getElementById('sFNameId').value;
		}
		if (document.getElementById('sMNameId') !=null ) {
			smName = document.getElementById('sMNameId').value;
		}
		if (document.getElementById('sLNameId') !=null ) {
			slName = document.getElementById('sLNameId').value;
		}
		if (document.getElementById('addr') !=null ) {
			document.getElementById('sraddr').value = document.getElementById('addr').value;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		if (document.getElementById('cityId') !=null )
			document.getElementById('srcityId').value = document.getElementById('cityId').value;
		if (document.getElementById('stateId') !=null )
			document.getElementById('srstateId').value = document.getElementById('stateId').value;

		if (document.getElementById('contactNo') !=null )
			document.getElementById('phoneNo').value = document.getElementById('contactNo').value;
		if (document.getElementById('depmobileNo') !=null )
			document.getElementById('mobileNo').value = document.getElementById('depmobileNo').value;

		// if(sfName != "" || smName != "" || slName != ""){
		// document.getElementById('nokNameId').value = sfName+" "+smName+"
		// "+slName;
		// }
	}
	
	return true;
}

function fillPatientNameHAL(obj) {
	var objValue = obj.value;
	var relation = document.getElementById('relationId').value;
	if (relation == '0' || relation == '8') {
		if (obj.id == 'sFNameId') {
			document.getElementById('pFirstNameId').value = objValue;
		}
		if (obj.id == 'sMNameId')
			document.getElementById('pMiddleNameId').value = objValue;
		if (obj.id == 'sLNameId')
			document.getElementById('pLastNameId').value = objValue;
		if (obj.id == 'srAgeId') {
			document.getElementById('ageId').value = objValue;
			document.getElementById('ageUnitId').value = document
					.getElementById('srAgeUnitId').value;
			document.getElementById('dobId').value = document
					.getElementById('srdobId').value;
		}
		if (obj.id == 'srSexId')
			document.getElementById('gender').value = objValue;
		if (obj.id == 'serBldGroupId')
			document.getElementById('bldGrp').value = objValue;
		if (obj.id == 'srdobId') {
			document.getElementById('dobId').value = objValue;
			/* calculateAgeInAjax(); */
		}

		if (obj.id == 'srmrstatus')
			document.getElementById('mrstatus').value = objValue;
		if (obj.id == 'sraddr') {
			document.getElementById('addr').value = objValue;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		/*
		 * if (obj.id == 'srcityId') document.getElementById('cityId').value =
		 * objValue; if (obj.id == 'srstateId')
		 * document.getElementById('stateId').value = objValue;
		 */

		if (obj.id == 'phoneNo')
			document.getElementById('contactNo').value = objValue;
		if (obj.id == 'mobileNo')
			document.getElementById('depmobileNo').value = objValue;

	}

	if (obj.id == 'srconsultingDocId') {
		document.getElementById('consultingDocId').value = objValue;
	}
	if (relation != '8') {
		var sfName = "";
		var smName = "";
		var slName = "";
		if (document.getElementById('sFNameId').value != "") {
			sfName = document.getElementById('sFNameId').value;
		}
		if (document.getElementById('sMNameId').value != "") {
			smName = document.getElementById('sMNameId').value;
		}
		if (document.getElementById('sLNameId').value != "") {
			slName = document.getElementById('sLNameId').value;
		}
		if (obj.id == 'addr') {
			document.getElementById('sraddr').value = objValue;
			// document.getElementById('nextOfKinAdd').value = objValue;
		}
		/*
		 * if (obj.id == 'cityId') document.getElementById('srcityId').value =
		 * objValue; if (obj.id == 'stateId')
		 * document.getElementById('srstateId').value = objValue;
		 */

		/*
		 * if (obj.id == 'contactNo') document.getElementById('phoneNo').value =
		 * objValue; if (obj.id == 'depmobileNo')
		 * document.getElementById('mobileNo').value = objValue;
		 */

		// if(sfName != "" || smName != "" || slName != ""){
		// document.getElementById('nokNameId').value = sfName+" "+smName+"
		// "+slName;
		// }
	}
}

function checkWardForTransfer(obj) {
	var fromWard = document.getElementById('fromWardId').value;
	if (fromWard == obj) {
		alert("From Ward and To Ward can not be same.")
		document.getElementById('wardId').value = "0"
		return false;
	}
	return true;
}

function showPatientDetails(formName, hinId) {
	obj = eval('document.' + formName);
	var url;
	if (formName == "patientVisitSearch") {
		url = "/hms/hms/registration?method=showVisitDetails&hinId=" + hinId;
	} else if (formName == "patientAdmissionSearch") {
		url = "/hms/hms/adt?method=searchPatientDetailsForAdmission&hinId="
				+ hinId;
	} else if (formName == "patientTransferSearch") {
		url = "/hms/hms/adt?method=searchPatientDetailsForTransfer&inpatientId="
				+ hinId;
	} else if (formName == "patientDischargeSearch") {
		url = "/hms/hms/adt?method=searchPatientDetailsForDischarge&inpatientId="
				+ hinId;
	}
	obj.action = url;
	obj.submit();
}

function checkRelationType(obj) {

	displayPatientName(obj);
	if ((obj == '8')) {

		document.getElementById('sCardIdY').checked = false;
		document.getElementById('sCardIdN').checked = false;
		document.getElementById('cardValidityId').value = "";
		document.getElementById('depIssueDateId').value = "";
		document.getElementById('sCardIdY').disabled = true;
		document.getElementById('sCardIdN').disabled = true;
		document.getElementById('cardValidityId').disabled = true;
		document.getElementById('depIssueDateId').disabled = true;
		document.getElementById('hospitalStaffId').disabled = false;

	} else {
		document.getElementById('sCardIdY').disabled = false;
		document.getElementById('sCardIdN').disabled = false;
		document.getElementById('cardValidityId').disabled = false;
		document.getElementById('depIssueDateId').disabled = false;
		document.getElementById('hospitalStaffId').disabled = true;
		var sfName = "";
		var smName = "";
		var slName = "";
		if (document.getElementById('sFNameId').value != "") {
			sfName = document.getElementById('sFNameId').value;
		}
		if (document.getElementById('sMNameId').value != "") {
			smName = document.getElementById('sMNameId').value;
		}
		if (document.getElementById('sLNameId').value != "") {
			slName = document.getElementById('sLNameId').value;
		}
		if (sfName != "" || smName != "" || slName != "") {
			document.getElementById('nokNameId').value = sfName + " " + smName
					+ " " + slName;
		}
	}

}

function displayPatientName(obj) {
	if (obj == '8') {
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
	} else {
		document.getElementById('pFirstNameId').value = "";
		document.getElementById('pMiddleNameId').value = "";
		document.getElementById('pLastNameId').value = "";
	}
}

function validateICardForMandatory() {
	rel = document.getElementById('relationId').value;
	if (rel != '0' && rel != '8') {
		for (var i = 0; i < document.getElementsByName('iCardVerified').length; i++) {
			if (document.getElementsByName('iCardVerified')[i].checked == true) {
				return true;
			}
		}
		errorMsg += "Please Select I-Card Verif...\n"
		return false;
	}

	return true;
}

function check(obj) {
	if (obj.checked) {
		document.getElementById('urine').focus();

	}
}

function checkPulseValidation(obj, inc) {
	var pulseObj = document.getElementById('incPulseTemp' + inc);

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Pulse should be numeric value.");
			pulseObj.value = "";
			pulseObj.focus();
			return false;
		} else {
			var pulse = parseInt(obj);
			if (pulse < 60 || pulse > 200) {
				alert('Pulse should not less than 60 and greater than 200');
				pulseObj.focus();
				return true;
			}
		}
	}
	return true;
}
function checkPulseIntakeValidation(obj) {
	var pulseObj = document.getElementById('pulse');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Pulse should be numeric value.");
			pulseObj.value = "";
			pulseObj.focus();
			return false;
		} else {
			var pulse = parseInt(obj);
			if (pulse < 60 || pulse > 200) {
				alert('Pulse should not less than 60 and greater than 200');

				pulseObj.focus();
				return true;
			}
		}
	}
	return true;
}

function checkRespirationValidation(obj, inc) {
	var respObj = document.getElementById('incRespTemp' + inc);

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Respiration should be numeric value.");
			respObj.value = "";
			respObj.focus();
			return false;
		} else {
			var resp = parseInt(obj);
			if (resp < 12 || resp > 80) {
				alert('Respiration should not less than 12 and greater than 80');
				respObj.focus();
				return true;
			}
		}
	}
	return true;
}
function checkRespirationIntakeValidation(obj) {
	var respObj = document.getElementById('respiration');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Respiration should be numeric value.");
			respObj.value = "";
			respObj.focus();
			return false;
		} else {
			var resp = parseInt(obj);
			if (resp < 12 || resp > 80) {
				alert('Respiration should not less than 12 and greater than 80');
				respObj.focus();
				return true;
			}
		}
	}
	return true;
}

function checkBpValidation(obj, inc) {
	var bpObj = document.getElementById('incBpTemp' + inc);

	if (obj != "") {
		var bp = parseInt(obj);
		if (bp < 60 || bp > 240) {
			alert('BP should not less than 60 and greater than 240');
			bpObj.value = "";
			bpObj.focus();
			return false;
		}
	}
	return true;
}
function checkBpIntakeValidation(obj) {
	var bpObj = document.getElementById('bp');

	if (obj != "") {
		var bp = parseInt(obj);
		if (bp < 60 || bp > 240) {
			alert('BP should not less than 60 and greater than 240');
			bpObj.value = "";
			bpObj.focus();
			return false;
		}
	}
	return true;
}
function validateBpWithSlash(strValue) {
	if (strValue != "") {
		var objRegExp = /^(\d{1,}[\/]\d*)$/
		obj = objRegExp.test(strValue);
		if (!obj) {
			alert("Slash(/) should be there.");
		}
	}
	return true;
}

function checkFhrValidation(obj, inc) {
	var fhrObj = document.getElementById('incFhrTemp' + inc);
	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Fhr should be numeric value.");
			fhrObj.value = "";
			fhrObj.focus();
			return false;
		}
	}
	return true;
}
function checkIntakeValidation(obj) {
	var intakeObj = document.getElementById('intake');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Intake should be numeric value.");
			intakeObj.value = "";
			intakeObj.focus();
			return false;
		}

	}
	return true;
}

function checkOutputValidation(obj) {
	var outputObj = document.getElementById('output');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Output should be numeric value.");
			outputObj.value = "";
			outputObj.focus();
			return false;
		}

	}
	return true;
}

function checkOralValidation(obj) {
	var oralObj = document.getElementById('oral');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Oral should be numeric value.");
			oralObj.value = "";
			oralObj.focus();
			return false;
		}

	}
	return true;
}

function checkIvValidation(obj) {
	var ivObj = document.getElementById('iv');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("IV should be numeric value.");
			ivObj.value = "";
			ivObj.focus();
			return false;
		}

	}
	return true;
}

function checkUrineValidation(obj) {
	var par = obj.parentNode;
	while (par.nodeName.toLowerCase() != 'tr') {
		par = par.parentNode;
	}
	var inc = par.rowIndex;
	var urineObj = document.getElementsByName('urine')[inc - 1];
	var unrineVal = obj.value;
	if (unrineVal != "") {
		if (!validateNumeric(unrineVal)) {
			alert("Urine should be numeric value.");
			urineObj.value = "";
			urineObj.focus();
			return false;
		}

	}
	return true;
}

function checkStoolValidation(obj) {
	var par = obj.parentNode;
	while (par.nodeName.toLowerCase() != 'tr') {
		par = par.parentNode;
	}
	var inc = par.rowIndex;
	var stoolObj = document.getElementsByName('stool')[inc - 1];
	var stoolVal = obj.value

	if (stoolVal != "") {
		if (!validateNumeric(stoolVal)) {
			alert("Stool should be numeric value.");
			stoolObj.value = "";
			stoolObj.focus();
			return false;
		}

	}
	return true;
}

function checkVomValidation(obj) {
	var par = obj.parentNode;
	while (par.nodeName.toLowerCase() != 'tr') {
		par = par.parentNode;
	}
	var inc = par.rowIndex;
	var vomObj = document.getElementsByName('vom')[inc - 1];
	var vomVal = obj.value

	if (vomVal != "") {
		if (!validateNumeric(vomVal)) {
			alert("Vom should be numeric value.");
			vomObj.value = "";
			vomObj.focus();
			return false;
		}

	}
	return true;
}
function checkAspValidation(obj) {
	var par = obj.parentNode;
	while (par.nodeName.toLowerCase() != 'tr') {
		par = par.parentNode;
	}
	var inc = par.rowIndex;
	var aspObj = document.getElementsByName('asp')[inc - 1];
	var aspVal = obj.value

	if (aspVal != "") {
		if (!validateNumeric(aspVal)) {
			alert("ASP should be numeric value.");
			aspObj.value = "";
			aspObj.focus();
			return false;
		}

	}
	return true;
}
function checkDrainValidation(obj) {
	var drainObj = document.getElementById('drain');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Drain should be numeric value.");
			drainObj.value = "";
			drainObj.focus();
			return false;
		}

	}
	return true;
}

function checkGirthValidation(obj) {
	var girthObj = document.getElementById('girth');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Girth should be numeric value.");
			girthObj.value = "";
			girthObj.focus();
			return false;
		}

	}
	return true;
}

function checkInsulinValidation(obj) {
	var insulinObj = document.getElementById('insulin');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Insulin should be numeric value.");
			insulinObj.value = "";
			insulinObj.focus();
			return false;
		}

	}
	return true;
}
function checkBloodValidation(obj) {
	var bloodObj = document.getElementById('bloodsugar');

	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("BloodSugar should be numeric value.");
			bloodObj.value = "";
			bloodObj.focus();
			return false;
		}

	}
	return true;
}

var varDuration;
var examArray = new Array();
function addAnnualExamDuration() {
	duration = varDuration;
	ameDate = document.getElementById('inputDate').value;
	var newAmeDate = new Date(ameDate.substring(6),
			(ameDate.substring(3, 5) - 1), ameDate.substring(0, 2))
	var nextReviewDate = new Date(newAmeDate.getTime() + varDuration * 24 * 60
			* 60 * 1000);
	document.getElementById("NextReviewDateId").value = nextReviewDate
			.getDate()
			+ "/"
			+ eval(nextReviewDate.getMonth() + 1)
			+ "/"
			+ nextReviewDate.getFullYear();
}

function getDuration() {
	for (i = 0; i < examArray.length; i++) {
		if (examArray[i][0] == document.getElementById("outputToId").value) {
			varDuration = examArray[i][2];
		}
	}
}

function checkCondition() {
	var condition = document.getElementById('conditionId').value;
	if (condition == "Dead") {
		var agree = confirm("Are you sure, Patient Condition is dead.");
		if (agree)
			return true;
		else
			return false
	}
	return true;
}

// ====================Function made by Vivek=========================
function checkForFirstRow() {
	errorMsg = "";
	if (document.getElementById("serviceNoId").value == "") {
		errorMsg += "Please fill Employee No.\n"
	}
	if (document.getElementById("serviceTypeId").value == 0) {
		errorMsg += "Please Select Service Type No.\n"
	}
	/*
	 * if(document.getElementById("serviceStatusId").value==0){ errorMsg +=
	 * "Please Select Service Status .\n" }
	 */

	if (errorMsg != "") {
		alert(errorMsg)
		obj = eval(document.getElementById('relationId'))
		// obj.selectedIndex=0
		return false;
	} else {
		return true;
	}

}

function checkForFirstRowHAL() {
	errorMsg = "";
	if (document.getElementById("serviceNoId").value == "") {
		errorMsg += "Please fill Employee No.\n"
	}
	/*
	 * if (document.getElementById("serviceTypeId").value == 0) { errorMsg +=
	 * "Please Select Service Type No.\n" }
	 */
	/*
	 * if(document.getElementById("serviceStatusId").value==0){ errorMsg +=
	 * "Please Select Service Status .\n" }
	 */

	if (errorMsg != "") {
		alert(errorMsg)
		obj = eval(document.getElementById('relationId'))
		// obj.selectedIndex=0
		return false;
	} else {
		return true;
	}

}

// ---------------Added by Vivek ----------------------
function checkForCancel() {
	if (confirm("Are You sure, You want Cancel admission ?"))
		return true;
	else
		return false;
}
// -------------------------- Added by Priyanka ---------------
// This function adds mask to any field.
function mask(str, textbox, loc, delim) {
	var locs = loc.split(',');
	for (var i = 0; i <= locs.length; i++) {
		for (var k = 0; k <= str.length; k++) {
			if (k == locs[i]) {
				if (str.substring(k, k + 1) != delim) {
					str = str.substring(0, k) + delim
							+ str.substring(k, str.length)
				}

			}

		}

	}
	textbox.value = str
}
function maskWithBackspaceCheck(str, textbox, loc, delim, e) {
	keycode = e.which;
	if (keycode != 8) {
		var locs = loc.split(',');
		for (var i = 0; i <= locs.length; i++) {
			for (var k = 0; k <= str.length; k++) {
				if (k == locs[i]) {
					if (str.substring(k, k + 1) != delim) {
						str = str.substring(0, k) + delim
								+ str.substring(k, str.length)
					}

				}
			}
		}
		textbox.value = str
	}
}
function resetClicked(formName, inc) {
	var a = eval('document.' + formName + '.sampleNo')
	a.style.display = "none";

	alert(eval('document.' + formName + '.sNo'))
	var b = eval('document.' + formName + '.sNo')
	b.style.display = "block";

	// for(var i=1;i<inc;i++){
	// alert(document.getElementById('sampleNoId'+inc))
	// document.getElementById('sampleNoId'+inc).value= "";
	// }
}
// --------------------------- Function for Opd
// Ophthalmology------------------------

function checkBlankForOphthalmology(formName) {
	inputs = eval('document.' + formName + '.elements');
	errors = "";
	flag = "blank"

	for (i = 0; i < inputs.length; i++) {
		textValue = trimAll(inputs[i].value);

		if (inputs[i].type == 'text' || inputs[i].type == 'select-one'
				|| inputs[i].type == 'select-multiple'
				|| inputs[i].type == 'textarea' || inputs[i].type == 'password') {

			if (textValue != "" && textValue != '0') {
				flag = "filled";
				return true;

			}
		}
	}
	if (flag == "blank") {
		alert("Please Fill at least one field.");
		return false;
	}

}
chargeArray1 = new Array();
function populateInvestigationName(val, formName) {
	obj = eval('document.' + formName + '.investigationId');
	obj.length = 1;
	for (i = 0; i < chargeArray1.length; i++) {
		if (chargeArray1[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = chargeArray1[i][1];
			obj.options[obj.length - 1].text = chargeArray1[i][2];
		}
	}
}

function checkValidityStartDate() {
	var validFromDate = document.getElementById('validFromDateId').value;
	validityDate = new Date(validFromDate.substring(6), (validFromDate
			.substring(3, 5) - 1), validFromDate.substring(0, 2));

	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);
	if (validityDate != "") {
		if (validityDate < currentDate) {
			errorMsg += "Validity Start date should not be less than from current date.\n"
			return false;
		}
	}
	return true;

}
function checkFromAndToDate() {

	var fromDate = document.getElementById('fromDateId').value;
	var toDate = document.getElementById('toDateId').value;

	fromDateObj = new Date(fromDate.substring(6),
			(fromDate.substring(3, 5) - 1), fromDate.substring(0, 2));
	toDateObj = new Date(toDate.substring(6), (toDate.substring(3, 5) - 1),
			toDate.substring(0, 2));

	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);

	if (toDateObj < fromDateObj) {
		errorMsg += "To Date should not be less than from From Date.\n"
		return false;
	}
	if (fromDateObj < currentDate || toDateObj < currentDate) {
		errorMsg += "From/To Date should not be less than from current date.\n"
		return false;
	}
	return true;

}

/** code for phase 3 by abha * */
poolArray1 = new Array();

function populatePoolCode(val, formName) {
	obj1 = eval('document.' + formName + '.poolId');
	obj1.length = 1;
	for (i = 0; i < poolArray1.length; i++) {
		if (poolArray1[i][0] == val) {
			obj1.length++;
			obj1.options[obj1.length - 1].value = poolArray1[i][1];
			obj1.options[obj1.length - 1].text = poolArray1[i][2];
		}
	}
}

tradeArray = new Array();

function populateTradeName(val, formName) {
	obj1 = eval('document.' + formName + '.tradeId');
	obj1.length = 1;
	for (i = 0; i < tradeArray.length; i++) {
		if (tradeArray[i][0] == val) {
			obj1.length++;
			obj1.options[obj1.length - 1].value = tradeArray[i][1];
			obj1.options[obj1.length - 1].text = tradeArray[i][2];
		}
	}
}

rankArray1 = new Array();
function populateRankName(formName) {
	var servTypeObj = eval(document.getElementById('serviceTypeId'))
	var servType = servTypeObj.value;
	obj = eval('document.' + formName + '.rankId');
	obj.length = 1;
	for (i = 0; i < rankArray1.length; i++) {
		if (rankArray1[i][0] == servType) {
			obj.length++;
			obj.options[obj.length - 1].value = rankArray1[i][1];
			obj.options[obj.length - 1].text = rankArray1[i][2];
		}
	}
}

deptArray1 = new Array();
function populateDepartmentName(formName) {
	var servTypeObj = eval(document.getElementById('serviceTypeId'))
	var servType = servTypeObj.value;
	obj = eval('document.' + formName + '.deptId');
	obj.length = 1;
	for (i = 0; i < deptArray1.length; i++) {
		if (deptArray1[i][0] == servType) {
			obj.length++;
			obj.options[obj.length - 1].value = deptArray1[i][1];
			obj.options[obj.length - 1].text = deptArray1[i][2];
		}
	}
}

garageArray1 = new Array();

function populateGarageCode(val, formName) {

	obj2 = eval('document.' + formName + '.garageId');
	alert('obj2.length ' + obj2)
	obj2.length = 1;
	for (i = 0; i < garageArray1.length; i++) {
		if (garageArray1[i][0] == val) {

			obj2.length++;
			obj2.options[obj1.length - 1].text = garageArray1[i][1];
		}
	}
}
function checkValidTime(timeStr, fieldId) {
	// Checks if time is in HH:MM:SS format.
	// The seconds are optional.

	var obj = document.getElementById(fieldId)
	// alert(obj.value)
	var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

	var matchArray = timeStr.match(timePat);
	if (obj.value != "" && matchArray == null) {
		alert("Time should be in HH:MM format!!.");
		obj.value = "";
		obj.focus();
		return false;
	}

	hour = matchArray[1];
	minute = matchArray[2];
	second = matchArray[4];
	ampm = matchArray[6];

	if (second == "") {
		second = null;
	}
	if (ampm == "") {
		ampm = null
	}

	if (hour < 0 || hour > 23) {
		alert("Hour must be between 0 and 23.");
		obj.value = "";
		obj.focus();
		return false;
	}
	if (minute < 0 || minute > 59) {
		alert("Minute must be between 0 and 59.");
		obj.value = "";
		obj.focus();
		return false;
	}

	return false;
}

var secondsPerMinute = 60;

var minutesPerHour = 60;

function convertSecondsToHHMMSS(intSecondsToConvert) {

	var hours = convertHours(intSecondsToConvert);

	var minutes = getRemainingMinutes(intSecondsToConvert);
	minutes = (minutes == 60) ? "00" : minutes;

	var seconds = getRemainingSeconds(intSecondsToConvert);

	var time = hours + ":" + minutes;
	return time;

}

function convertHours(intSeconds) {

	var minutes = convertMinutes(intSeconds);

	var hours = Math.floor(minutes / minutesPerHour);

	return hours;

}

function convertMinutes(intSeconds) {

	return Math.floor(intSeconds / secondsPerMinute);

}

function getRemainingSeconds(intTotalSeconds) {

	return (intTotalSeconds % secondsPerMinute);

}

function getRemainingMinutes(intSeconds) {

	var intTotalMinutes = convertMinutes(intSeconds);

	return (intTotalMinutes % minutesPerHour);

}

function HMStoSec1(T) { // h:m:s

	var A = T.split(/\D+/);
	return (A[0] * 60 + +A[1]) * 60 + +A[2]
}

function calculateTime() {

	var time1 = HMStoSec1(document.getElementById('timeOn').value);
	var time2 = HMStoSec1(document.getElementById('timeOff').value);
	var totalTime;
	var diff = time2 - time1;
	if (document.getElementById('timeOn').value == "00:00:00"
			&& document.getElementById('timeOff').value == "00:00:00") {
		alert("Time cannot be 00:00:00");
		document.getElementById('totalHours').value = "00:00:00";
		return false;
	} else if (document.getElementById('timeOff').value >= document
			.getElementById('timeOn').value) {
		totalTime = (convertSecondsToHHMMSS(diff));
		document.getElementById('totalHours').value = totalTime;
		return true;
	} else {
		alert("Time On should be less than Time Off");
		return false;
	}

}

function compareTimes() {
	if (document.getElementById('timeOn').value >= document
			.getElementById('timeOff').value) {
		alert("Time On should be less than Time Off");
		return false;
	}
	return true;

}

catArray = new Array();

function populateBookClass(val, formName) {

	obj1 = eval('document.' + formName + '.bookClassId');
	obj1.length = 1;
	for (i = 0; i < catArray.length; i++) {
		if (catArray[i][0] == val) {
			obj1.length++;
			obj1.options[obj1.length - 1].value = catArray[i][1];
			obj1.options[obj1.length - 1].text = catArray[i][2];
		}
	}
}

classArray = new Array();

function populateBookSubClass(val, formName) {
	obj = eval('document.' + formName + '.bookSubClassId');
	obj.length = 1;
	for (i = 0; i < classArray.length; i++) {
		if (classArray[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = classArray[i][1];
			obj.options[obj.length - 1].text = classArray[i][2];
		}
	}
}
/** end of code by abha * */
stnArr = new Array();
function populateStation(formName) {
	var cmdObj = eval(document.getElementById('commandId'))
	var command = cmdObj.value;
	if (command != 'other') {
		obj = eval('document.' + formName + '.stationId');
		obj.length = 1;
		for (i = 0; i < stnArr.length; i++) {
			if (stnArr[i][1] == command) {
				obj.length++;
				if (obj.options) {
					obj.options[obj.length - 1].value = stnArr[i][2];
					obj.options[obj.length - 1].text = stnArr[i][3];
				}
			}
		}
		obj.length++;
		obj.options[obj.length - 1].value = "other";
		obj.options[obj.length - 1].text = "Other";
	}
}

unitArr = new Array();
function populateUnit(formName) {
	var stnObj = eval(document.getElementById('stationId'))
	var stn = stnObj.value;
	if (stn != '31') {
		obj = eval('document.' + formName + '.unitId');
		obj.length = 1;
		for (i = 0; i < unitArr.length; i++) {
			if (unitArr[i][1] == stn) {
				obj.length++;
				if (obj.options) {
					obj.options[obj.length - 1].value = unitArr[i][2];
					obj.options[obj.length - 1].text = unitArr[i][3];
				}
			}
		}
		obj.length++;
		obj.options[obj.length - 1].value = "other";
		obj.options[obj.length - 1].text = "Other";
	}
}

stnArr = new Array();
function populateSMC(val, formName) {
	obj = eval('document.' + formName + '.hospital');
	obj.length = 1;
	for (i = 0; i < stnArr.length; i++) {
		if (stnArr[i][0] == val) {
			obj.length++;
			obj.options[obj.length - 1].value = stnArr[i][1];
			obj.options[obj.length - 1].text = stnArr[i][2];
		}
	}
}

function calculateWHR() {

	if (document.getElementById('waist').value != ""
			&& document.getElementById('hips').value != "") {
		var waist = parseFloat(document.getElementById('waist').value);
		var hips = document.getElementById('hips').value;
		/*
		 * Code by Mukesh Date 31 Jan 2012
		 */
		if (hips > 0) {
			document.getElementById('WHR').value = (waist / hips).toFixed(2);
		} else {
			document.getElementById('WHR').value = 0;
		}
	}
}
function calculateBMI() {

	if (document.getElementById('height').value != ""
			&& document.getElementById('weight').value != "") {
		var height = parseFloat(document.getElementById('height').value) / 100;
		var weight = document.getElementById('weight').value;

		document.getElementById('bmi').value = (weight / (height * height))
				.toFixed(2);
	}
}
function calculateOverWeight() {
	if (document.getElementById('sdVal').value == 0) {
		calculateIdealWeight(); // to get sd value at the time of update
	}
	if (document.getElementById('weight').value != ""
			&& document.getElementById('idealWeightId').value != "") {
		var idealweight = document.getElementById('idealWeightId').value;
		var weight = document.getElementById('weight').value;
		if (parseInt(idealweight) > 0) {
			var deffranceOfWeight = (parseFloat(weight) - parseFloat(idealweight))
					.toFixed(2);
			// var
			// perOfOverWeight=(parseFloat(deffranceOfWeight)*100/weight).toFixed(2);
			// // commented by vinay as discussed with Khasim
			var perOfOverWeight = (parseFloat(deffranceOfWeight) * 100 / idealweight)
					.toFixed(2);
			document.getElementById('overweight').value = parseFloat(
					perOfOverWeight).toFixed(2);
		} else {
			document.getElementById('overweight').value = 0;
		}

		/**
		 * SD Calculation By Ritu
		 */

		setTimeout('calculateSd()', 500);

	}
}

function calculateSd() {
	var idealweight = document.getElementById('idealWeightId').value;
	var weight = document.getElementById('weight').value;
	var diff = parseInt(weight) - parseInt(idealweight);
	if ((parseFloat(diff) <= parseFloat(document.getElementById('sdVal').value) * 2)) {
		document.getElementById('sd').value = '+/- 2';

	} else if ((parseFloat(diff) > parseFloat(document.getElementById('sdVal').value) * 2)
			&& (parseFloat(diff) <= parseFloat(document.getElementById('sdVal').value) * 3)) {
		document.getElementById('sd').value = '> + 2';

	} else if ((parseFloat(diff) > parseFloat(document.getElementById('sdVal').value) * 3)) {
		document.getElementById('sd').value = '> + 3';

	}

}

function displayCategotries(val) {
	if (val == 4) {
		if (document.getElementById('medExamCategory'))
			document.getElementById('medExamCategory').setAttribute('validate',
					'Exam Category,string,yes');
		if (document.getElementById('medBoardCategory'))
			document.getElementById('medBoardCategory').setAttribute(
					'validate', 'Board Category,string,no');
		document.getElementById('medExamCategoryDiv').style.display = 'block';
		document.getElementById('medBoardCategoryDiv').style.display = 'none';
	} else if (val == 3) {
		if (document.getElementById('medExamCategory'))
			document.getElementById('medExamCategory').setAttribute('validate',
					'Exam Category,string,no');
		if (document.getElementById('medBoardCategory'))
			document.getElementById('medBoardCategory').setAttribute(
					'validate', 'Board Category,string,yes');
		document.getElementById('medExamCategoryDiv').style.display = 'none';
		document.getElementById('medBoardCategoryDiv').style.display = 'block';
	} else {
		if (document.getElementById('medBoardCategory'))
			document.getElementById('medBoardCategory').setAttribute(
					'validate', 'Board Category,string,no');
		if (document.getElementById('medExamCategory'))
			document.getElementById('medExamCategory').setAttribute('validate',
					'Exam Category,string,no');
		document.getElementById('medExamCategoryDiv').style.display = 'none';
		document.getElementById('medBoardCategoryDiv').style.display = 'none';
	}
}

function checkAgeAndService() {
	var age = document.getElementById('srAgeId').value;
	var ageUnit = document.getElementById('srAgeUnitId').value;
	var service = document.getElementById('totalServ').value;
	var serviceUnit = document.getElementById('totalServUnit').value;
	if (age != "" && ageUnit == serviceUnit) {
		if (age - 16 < service) {
			alert("Total Service is not valid.");
			document.getElementById('totalServ').value = "0";
			return false;
		}
	}
	return true;
}

function checkForNomenclature(val, inc) {

	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForChargeCode = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var chargeId = val.substring(index1, index2);
		var indexForChargeCode = indexForChargeCode--;
		var chargeCode = val.substring(0, indexForChargeCode);

		if (chargeId == "") {
			if (document.getElementById('nomenclature' + inc)) {
				document.getElementById('nomenclature' + inc).value = "";
				document.getElementById('pvmsNo' + inc).value = "";
				document.getElementById('dosage' + inc).value = "";
				document.getElementById('frequency' + inc).value = "";
				document.getElementById('noOfDays' + inc).value = "";
				if(document.getElementById('route' + inc))
				document.getElementById('route' + inc).value = "";
				document.getElementById('total' + inc).value = "";
				if (document.getElementById('treatRemarks' + inc))
					document.getElementById('treatRemarks' + inc).value = "";
			}
			// document.getElementById('clinicalNotes'+inc).value="";
			// document.getElementById('qty'+inc).value="";
			return;
		}

		for (i = 1; i <= inc; i++) {

			if (inc != i) {
				if (document.getElementById('nomenclature' + i)
						&& document.getElementById('nomenclature' + i).value == val) {
					alert("Nomenclature already selected...!")
					document.getElementById('nomenclature' + inc).value = ""
					document.getElementById('pvmsNo' + inc).value = "";
					var e = eval(document.getElementById('nomenclature' + inc));
					e.focus();
					return false;
				}
			}
		}

	} else {

		if (document.getElementById('nomenclature' + inc)) {
			document.getElementById('nomenclature' + inc).value = "";
			document.getElementById('pvmsNo' + inc).value = "";
			document.getElementById('dosage' + inc).value = "";
			document.getElementById('frequency' + inc).value = "0";
			document.getElementById('noOfDays' + inc).value = "";
			if(document.getElementById('route' + inc))
			document.getElementById('route' + inc).value = "";
			document.getElementById('total' + inc).value = "";
			if (document.getElementById('treatRemarks' + inc))
				document.getElementById('treatRemarks' + inc).value = "";
		}
	}
	return true;
}

function validateInvestigationAutoComplete(strValue, inc) {

	var index1 = strValue.lastIndexOf("[");
	var index2 = strValue.lastIndexOf("]");
	index1++;
	var id = strValue.substring(index1, index2);

	if (id == "") {
		if (document.getElementById('chargeCodeName' + inc)) {
			document.getElementById('chargeCodeName' + inc).value = "";
			document.getElementById('chargeCode' + inc).value = "";
			return;
		}
	}
	document.getElementById('qty' + inc).value = "1";
	return true;
}

function checkForChargeCode(val, inc, chargeCodeTdDiv) {

	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForChargeCode = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var chargeId = val.substring(index1, index2);
		var indexForChargeCode = indexForChargeCode--;
		var chargeCode = val.substring(0, indexForChargeCode);

		if (chargeId == "") {
			document.getElementById('chargeCodeName' + inc).value = "";
			document.getElementById('chargeCode' + inc).value = "";
			//document.getElementById('clinicalNotes' + inc).value = "";
			//document.getElementById('qty' + inc).value = "";
			return;
		}

		for (i = 1; i < inc; i++) {

			if (inc != 1) {
				if (document.getElementById('chargeCodeName' + i)
						&& document.getElementById('chargeCodeName' + i).value == val) {
					
					if(document.getElementById('investigationDate' + i)
					&& document.getElementById('investigationDate' + i).value== document.getElementById('investigationDate' + inc).value)
				{	
					alert("Investigation name already selected...!")
					document.getElementById('chargeCodeName' + inc).value = ""
					var e = eval(document
							.getElementById('chargeCodeName' + inc));
					e.focus();
					return false;
				}
				}
			}
		}

		var nameOfChargeCodeArray = chargeCode.split('&');
		var tempChargeCodeString = "";
		for (var m = 0; m < nameOfChargeCodeArray.length; m++) {
			tempChargeCodeString = tempChargeCodeString
					+ nameOfChargeCodeArray[m] + "0";
		}

		// ajaxFunctionForAutoCompleteChargeCodeName('orderBooking','lab?method=fillItemsForChargeCode&chargeCode='
		// + tempChargeCodeString , inc);
		// submitProtoAjaxWithDivName('opdMain','/hms/hms/opd?method=fillChargeCodeForInvestigation&chargeCodeNAmeForAjax='+
		// tempChargeCodeString+'&rowVal=1',chargeCodeTdDiv);

	} else {
		document.getElementById('chargeCodeName' + inc).value = "";
		document.getElementById('qty' + inc).value = "";
		document.getElementById('chargeCode' + inc).value = "";
		// document.getElementById('qty'+inc).value = "";
		// document.getElementById('qty'+inc).value = "";
	}
}

function limitText(limitField, limitNum) {
	if (limitField.value.length > limitNum) {

		limitField.value = limitField.value.substring(0, limitNum);

	}
}
var dtCh = "/";
var minYear = 1900;
var maxYear = 2100;
function isDate(dtStr, fieldId) {
	var daysInMonth = DaysArray(12)
	var pos1 = dtStr.indexOf(dtCh)
	var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
	// var strMonth=dtStr.substring(0,pos1)
	// var strDay=dtStr.substring(pos1+1,pos2)
	var strDay = dtStr.substring(0, pos1)
	var strMonth = dtStr.substring(pos1 + 1, pos2)
	// alert("strMonth--"+strMonth);
	// alert("strDay--"+strDay);
	var strYear = dtStr.substring(pos2 + 1)
	strYr = strYear
	if (strDay.charAt(0) == "0" && strDay.length > 1)
		strDay = strDay.substring(1)
	if (strMonth.charAt(0) == "0" && strMonth.length > 1)
		strMonth = strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0) == "0" && strYr.length > 1)
			strYr = strYr.substring(1)
	}
	month = parseInt(strMonth)
	day = parseInt(strDay)
	year = parseInt(strYr)
	if (pos1 == -1 || pos2 == -1) {
		alert("The date format should be : DD/MM/YYYY");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false
	}
	if (strMonth.length < 1 || month < 1 || month > 12) {
		alert("Please enter a valid month");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false
	}
	if (strDay.length < 1 || day < 1 || day > 31
			|| (month == 2 && day > daysInFebruary(year))
			|| day > daysInMonth[month]) {
		alert("Please enter a valid day");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false
	}
	if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
		alert("Please enter a valid 4 digit year between " + minYear + " and "
				+ maxYear + "");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false
	}
	if (dtStr.indexOf(dtCh, pos2 + 1) != -1
			|| isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
		alert("Please enter a valid date ");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false
	}
	return true
}

function isDateHAL(dtStr, fieldId) {
	var daysInMonth = DaysArray(12)
	var pos1 = dtStr.indexOf(dtCh)
	var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
	// var strMonth=dtStr.substring(0,pos1)
	// var strDay=dtStr.substring(pos1+1,pos2)
	var strDay = dtStr.substring(0, pos1)
	var strMonth = dtStr.substring(pos1 + 1, pos2)
	// alert("strMonth--"+strMonth);
	// alert("strDay--"+strDay);
	var strYear = dtStr.substring(pos2 + 1)
	strYr = strYear
	if (strDay.charAt(0) == "0" && strDay.length > 1)
		strDay = strDay.substring(1)
	if (strMonth.charAt(0) == "0" && strMonth.length > 1)
		strMonth = strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0) == "0" && strYr.length > 1)
			strYr = strYr.substring(1)
	}
	month = parseInt(strMonth)
	day = parseInt(strDay)
	year = parseInt(strYr)
	if (pos1 == -1 || pos2 == -1) {
		alert("The date format should be : DD/MM/YYYY");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false;
	} else if (strMonth.length < 1 || month < 1 || month > 12) {
		alert("Please enter a valid month");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false;
	} else if (strDay.length < 1 || day < 1 || day > 31
			|| (month == 2 && day > daysInFebruary(year))
			|| day > daysInMonth[month]) {
		alert("Please enter a valid day");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false;
	} else if (strYear.length != 4 || year == 0 || year < minYear
			|| year > maxYear) {
		alert("Please enter a valid 4 digit year between " + minYear + " and "
				+ maxYear + "");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false;
	} else if (dtStr.indexOf(dtCh, pos2 + 1) != -1
			|| isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
		alert("Please enter a valid date ");
		document.getElementById(fieldId).value = "";
		document.getElementById(fieldId).focus();
		return false;
	} else {
		return true;
	}

}

function validateExpDate(dt, fieldId) {
	if (dt.value != "") {
		if (isDate(dt.value, fieldId) == false) {
			return false
		}
	}
	return true
}

function validateExpDateHAL(dt, fieldId) {
	if (dt.value != "") {

		return isDateHAL(dt.value, fieldId);

	}

}
function isInteger(s) {
	var i;
	for (i = 0; i < s.length; i++) {
		// Check that current character is number.
		var c = s.charAt(i);
		if (((c < "0") || (c > "9")))
			return false;
	}
	// All characters are numbers.
	return true;
}

function stripCharsInBag(s, bag) {
	var i;
	var returnString = "";
	// Search through string's characters one by one.
	// If character is not in bag, append to returnString.
	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (bag.indexOf(c) == -1)
			returnString += c;
	}
	return returnString;
}

function daysInFebruary(year) {
	// February has 29 days in any year evenly divisible by four,
	// EXCEPT for centurial years which are not also divisible by 400.
	return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29
			: 28);
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i == 4 || i == 6 || i == 9 || i == 11) {
			this[i] = 30
		}
		if (i == 2) {
			this[i] = 29
		}
	}
	return this
}

function checkDependencyDate(dependencyDateStr) {
	if (dependencyDateStr != '' && document.getElementById('dobId').value != '') {
		var dobStr = document.getElementById('dobId').value;
		var dob = new Date(dobStr.substring(6), (dobStr.substring(3, 5) - 1),
				dobStr.substring(0, 2))
		var dependencyDate = new Date(dependencyDateStr.substring(6),
				(dependencyDateStr.substring(3, 5) - 1), dependencyDateStr
						.substring(0, 2))
		if (dependencyDate < dob) {
			alert("Dependency Date can not be before DOB.");
			document.getElementById('depDate').value = '';
			return false;
		}
	}

}

function checkDosageValidation(obj, inc) {
	var dosageObj = document.getElementById('dosage' + inc);
	if (obj != "") {
		if (!validateNumeric(obj)) {
			alert("Dosage should be numeric value.");
			dosageObj.value = "";
			dosageObj.focus();
			return false;
		}
	}
	return true;
}


function checkDosageValidationMotherNBaby(objValue, objId) {
	var dosageObj = document.getElementById(objId);
	if (objValue != "") {
		if (!validateNumeric(objValue)) {
			alert("Dosage should be numeric value.");
			dosageObj.value = "";
			dosageObj.focus();
			return false;
		}
	}
	return true;
}


/*function fillValue(value, inc) {
	var dosage = document.getElementById('dosage' + inc).value
	var freq = document.getElementById('frequencyValue' + inc).value
	var dispenseQty = document.getElementById('actualDispensingQty' + inc).value;
	var total = freq * value * dosage;
	var finalQty;
	if (document.getElementById('actualDispensingQty' + inc).value != 0) {
		var totalQty = (total / parseFloat(dispenseQty)).toFixed(2)
		if (totalQty != 0) {
			finalQty = Math.ceil(totalQty);
		}
		document.getElementById('total' + inc).value = finalQty;

	} else {
		// alert("==in else==");
		document.getElementById('total' + inc).value = freq * value * dosage
	}
}*/
/*function fillValue(inc){
	  
	  
    var noOfDays = document.getElementById('noOfDays'+inc).value 
	  var dosage = document.getElementById('dosage'+inc).value
	  var freq=document.getElementById('frequencyValue'+inc).value
	  var dispenseQty = document.getElementById('actualDispensingQty'+inc).value;
	  var sosQty = document.getElementById('sosQty'+inc).value;
	  var total = freq*noOfDays*dosage;
	  
	  var finalQty;
	  
	  if(document.getElementById('frequency'+inc).value != 13 ){
	  if(document.getElementById('actualDispensingQty'+inc).value != 0){
		  var totalQty = (parseFloat(total)/parseFloat(dispenseQty)).toFixed(2)
		//  alert(totalQty);
		  if(totalQty != '0.00'){
			  finalQty = Math.ceil(totalQty);
		  }
		  else
			  {
			 	 finalQty = 1;
			  }
		  
		  document.getElementById('total'+inc).value=finalQty;
		 }else{
			  document.getElementById('total'+inc).value=freq*noOfDays*dosage
		  }
	 //	document.getElementById('noOfDays'+inc).disabled = false;
	// 	document.getElementById('sosQty'+inc).disabled = true;
	  }else{
		  if(document.getElementById('actualDispensingQty'+inc).value != 0){
			  var totalQty = (parseFloat(freq*sosQty*dosage)/parseFloat(dispenseQty)).toFixed(2)
			  if(totalQty != '0.00'){
				  finalQty = Math.ceil(totalQty);
			  }
			  document.getElementById('total'+inc).value=finalQty;
			 }else{
				  document.getElementById('total'+inc).value=freq*sosQty*dosage
			  }
	//	   document.getElementById('noOfDays'+inc).disabled = true;
	//	   document.getElementById('sosQty'+inc).disabled = false;

	  }
	  
	 }*/
/*function fillValueFromFrequency(value, inc) {
	var dosage = document.getElementById('dosage' + inc).value
	var noOfDays = document.getElementById('noOfDays' + inc).value
	var freq = document.getElementById('frequencyValue' + inc).value

	document.getElementById('total' + inc).value = noOfDays * freq * dosage
	var dispenseQty = document.getElementById('actualDispensingQty' + inc).value;
	var total = freq * noOfDays * dosage;
	var finalQty;
	if (document.getElementById('actualDispensingQty' + inc).value != 0) {
		var totalQty = (total / parseFloat(dispenseQty)).toFixed(2)
		if (totalQty != 0) {
			finalQty = Math.ceil(totalQty);
		}
		
		 * var arr = new Array(); arr = totalQty.split("."); var qtyA;var
		 * qtyB;var finalQty; if(arr[0] != "" && arr[0] != null){ qtyA =
		 * parseFloat(arr[0]); }else{ qtyA = 0; } if(arr[1] != "" && arr[1] !=
		 * null){ qtyB = parseFloat(arr[1]); }else{ qtyB = 0; } if(qtyA == 0){
		 * finalQty = 1; }else if(qtyB ==0){ finalQty = qtyA;
		 * 
		 * }else if(qtyB >0){ finalQty = qtyA+1; }
		 
		document.getElementById('total' + inc).value = finalQty;

	} else {
		document.getElementById('total' + inc).value = freq * noOfDays * dosage
	}
}*/

/*function  fillValueFromFrequency(value,inc){
 	  var dosage = document.getElementById('dosage'+inc).value
	  var noOfDays=document.getElementById('noOfDays'+inc).value
	  var freq=document.getElementById('frequencyValue'+inc).value
	  document.getElementById('total'+inc).value=noOfDays*freq*dosage
	  var dispenseQty = document.getElementById('actualDispensingQty'+inc).value;
 	  var sosQty = document.getElementById('sosQty'+inc).value;
	  var total = freq*noOfDays*dosage;
	  var finalQty;
	  if(document.getElementById('frequency'+inc).value != 13 ){
	  if(document.getElementById('actualDispensingQty'+inc).value != 0){
		  var totalQty = (parseFloat(total)/parseFloat(dispenseQty)).toFixed(2)
		  if(totalQty != '0.00'){
			  finalQty = Math.ceil(totalQty);
		  }
		  document.getElementById('total'+inc).value=finalQty;
	
		 }else{
			 
			  document.getElementById('total'+inc).value=noOfDays*freq*dosage
		  }
	 // document.getElementById('noOfDays'+inc).readOnly = false;
	 // document.getElementById('sosQty'+inc).readOnly = true;
	  }else{
		  if(document.getElementById('actualDispensingQty'+inc).value != 0){
			  var totalQty = (parseFloat(freq*sosQty*dosage)/parseFloat(dispenseQty)).toFixed(2)
			  if(totalQty != '0.00'){
				  finalQty = Math.ceil(totalQty);
			  }
			  document.getElementById('total'+inc).value=finalQty;
		
			 }else{
				  document.getElementById('total'+inc).value=sosQty*freq*dosage
			  }
		//  alert(document.getElementById('noOfDays'+inc).readOnly);
		 // document.getElementById('noOfDays'+inc).readOnly = true;
		 // document.getElementById('sosQty'+inc).readOnly = false;
	  }
	 }
*/

function  fillValueFromFrequency(value,inc){
 	/*  var dosage = document.getElementById('dosage'+inc).value
	  var noOfDays=document.getElementById('noOfDays'+inc).value
	  var freq=document.getElementById('frequencyValue'+inc).value
	  document.getElementById('total'+inc).value=noOfDays*freq*dosage
	  var dispenseQty = document.getElementById('actualDispensingQty'+inc).value;
 	  var sosQty = document.getElementById('sosQty'+inc).value;
	  var total = freq*noOfDays*dosage;
	  var finalQty;
	  if(document.getElementById('frequency'+inc).value != 13 ){
	  if(document.getElementById('actualDispensingQty'+inc).value != 0){
		  var totalQty = (parseFloat(total)/parseFloat(dispenseQty)).toFixed(2)
		  if(totalQty != '0.00'){
			  finalQty = Math.ceil(totalQty);
		  }
		  document.getElementById('total'+inc).value=finalQty;
	
		 }else{
			 
			  document.getElementById('total'+inc).value=noOfDays*freq*dosage
		  }
	 // document.getElementById('noOfDays'+inc).readOnly = false;
	 // document.getElementById('sosQty'+inc).readOnly = true;
	  }else{
		  if(document.getElementById('actualDispensingQty'+inc).value != 0){
			  var totalQty = (parseFloat(freq*sosQty*dosage)/parseFloat(dispenseQty)).toFixed(2)
			  if(totalQty != '0.00'){
				  finalQty = Math.ceil(totalQty);
			  }
			  document.getElementById('total'+inc).value=finalQty;
		
			 }else{
				  document.getElementById('total'+inc).value=sosQty*freq*dosage
			  }
		//  alert(document.getElementById('noOfDays'+inc).readOnly);
		 // document.getElementById('noOfDays'+inc).readOnly = true;
		 // document.getElementById('sosQty'+inc).readOnly = false;
	  }*/
	 }
function displayAu(val, inc, hinId) {
	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		if (pvmsNo == "") {
			document.getElementById('nomenclature' + inc).value = "";
			document.getElementById('pvmsNo' + inc).value = "";
			return;
		} else
			var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
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
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];

					var au = item.getElementsByTagName("au")[0];
					var actualDispensingQty = item
							.getElementsByTagName("actualDispensingQty")[0];
					var stock = item.getElementsByTagName("stock")[0];
					var dispensingUnit = item
					.getElementsByTagName("dispensingUnit")[0];
					var itemClassCode = item.getElementsByTagName("itemClassCode")[0];
					var itemClass = item.getElementsByTagName("itemClass")[0];
					

					if (document.getElementById('dispensingUnit' + inc)
							&& au.childNodes[0] != undefined) {
						document.getElementById('dispensingUnit' + inc).value = dispensingUnit.childNodes[0].nodeValue;
					}
					
					if (document.getElementById('itemConversionId' + inc)
							&& au.childNodes[0] != undefined) {
						document.getElementById('itemConversionId' + inc).value = au.childNodes[0].nodeValue;
					}
					if (document.getElementById('itemClassCode' + inc)
							&& au.childNodes[0] != undefined) {
						document.getElementById('itemClassCode' + inc).value = itemClassCode.childNodes[0].nodeValue;
					}
					if (document.getElementById('itemClass' + inc)
							&& au.childNodes[0] != undefined) {
						document.getElementById('itemClass' + inc).value = itemClass.childNodes[0].nodeValue;
					}
					
					if (document.getElementById('closingStock' + inc)
							&& stock.childNodes[0] != undefined) {
						document.getElementById('closingStock' + inc).value = stock.childNodes[0].nodeValue;
						if(inc<500){
						if (stock.childNodes[0].nodeValue == 0) {
							alert("Stock is not available...");
						}}
					} else {
					}
					if (document.getElementById('actualDispensingQty' + inc)) {
						if (actualDispensingQty.childNodes[0] != undefined) {
							document
									.getElementById('actualDispensingQty' + inc).value = actualDispensingQty.childNodes[0].nodeValue;
						} else {
							document
									.getElementById('actualDispensingQty' + inc).value = 0;

						}
					}
					
					if (document.getElementById('uomQty' + inc)) {
						if (actualDispensingQty.childNodes[0] != undefined) {
							document
									.getElementById('uomQty' + inc).value = actualDispensingQty.childNodes[0].nodeValue;
						} else {
							document
									.getElementById('uomQty' + inc).value = 0;

						}
					}
					
					   var dispQty = item.getElementsByTagName("dispQty")[0];
                       if(dispQty.childNodes[0]!=undefined && dispQty.childNodes[0].nodeValue == 'true'){
                               alert("No configuration of dispensary quantity for this medicine" +inc);
                    		   document.getElementById('nomenclature'+inc).value="";
                    		   document.getElementById('itemId'+inc).value="";
    						   if(document.getElementById('closingStock'+inc))
                    		   document.getElementById('closingStock'+inc).value="";
    						   document.getElementById('pvmsNo' + inc).value = "";
                       }
					
					var dangerousDrug = item
							.getElementsByTagName("dangerousDrug")[0];
					if (dangerousDrug.childNodes[0] != undefined
							&& dangerousDrug.childNodes[0].nodeValue == 'y') {
						alert("This drug is dangerous.");
					}

					var highValueMedicine = item
							.getElementsByTagName("highValueMedicine")[0];
					if (highValueMedicine.childNodes[0] != undefined
							&& highValueMedicine.childNodes[0].nodeValue == 'y') {
						document.getElementById('highValueMedicine' + inc).value = 'y';
						checkHighValueMedicine(pvmsNo, inc, hinId);
					} else {
						document.getElementById('highValueMedicine' + inc).value = 'n';
					}

				}
			}
		}
		var url = "/hms/hms/opd?method=displayAU&pvmsNo=" + pvmsNo;
		// var
		// url="/hms/hms/opd?method=displayAU&pvmsNo="+pvmsNo+"&"+&hinId=<%=visit.getHin().getId()%>";
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
	else
		{
		document.getElementById('itemId' + inc).value = '';
		}
}


function displayAuForLabor(val, inc, hinId) {
	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		if (pvmsNo == "") {
			document.getElementById('nomenclature' + inc).value = "";
			document.getElementById('pvmsNo' + inc).value = "";
			return;
		} else
			var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
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
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
				
					var stock = item.getElementsByTagName("stock")[0];
					var batchString = item.getElementsByTagName("batchString")[0];
//alert("ff "+stock +" "+stock.childNodes[0].nodeValue +" s "+batchString.childNodes[0].nodeValue);


if (batchString.childNodes[0] != undefined) {
	var options = '<select id="batch'+inc+'"name="batch'+inc+'"><option value="">Select</option>';
	var batchString = batchString.childNodes[0].nodeValue;
	var batchString1 = batchString.split('#');
	//alert(batchString);
	for (var i = 0; i < batchString1.length-1; i++) {
	    var s = batchString1[i]
		var s1 = s.split("@");
		//alert(s1[0]+"==="+s1[1]);
	    options = options+ "<option value='"+s1[1]+ "'>" + s1[1]+"</option>";
	   // alert(options);
	}
	document.getElementById( 'batch'+inc ).outerHTML = options;

}
				if (document.getElementById('closingStock' + inc)
							&& stock.childNodes[0] != undefined) {
						document.getElementById('closingStock' + inc).value = stock.childNodes[0].nodeValue;
						if (stock.childNodes[0].nodeValue == 0) {
							alert("Stock is not available...");
						}
					} else {
					}

				}
			}
		}
		var url = "/hms/hms/lr?method=displayAU&pvmsNo=" + pvmsNo;
		//var
		//url="/hms/hms/opd?method=displayAU&pvmsNo="+pvmsNo+"&"+&hinId=<%=visit.getHin().getId()%>";
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
	else
		{
		document.getElementById('itemId' + inc).value = "";
		}
}


function displayAuFoBaby(val, inc, babyno, hinId) {
	//alert("her ddde" +babyno);
	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		if (pvmsNo == "") {
			document.getElementById('baby' + babyno+ 'nomenclature' + inc).value = "";
			//document.getElementById('pvmsNo' + inc).value = "";
			return;
		} else
			var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
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
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
				
					var stock = item.getElementsByTagName("stock")[0];
					var batchString = item.getElementsByTagName("batchString")[0];
//alert("ff "+stock +" "+stock.childNodes[0].nodeValue +" s "+batchString.childNodes[0].nodeValue);


if (batchString.childNodes[0] != undefined) {
	
	var options = '<select id="baby' + babyno+ 'batch' + inc +'"name="baby' + babyno+ 'batch' + inc +'" ><option value="">Select</option>';
	var batchString = batchString.childNodes[0].nodeValue;
	var batchString1 = batchString.split('#');
	//alert(batchString);
	for (var i = 0; i < batchString1.length-1; i++) {
	    var s = batchString1[i]
		var s1 = s.split("@");
		//alert(s1[0]+"==="+s1[1]);
	    options = options+ "<option value='"+s1[1]+ "'>" + s1[1]+"</option>";
	   // alert(options);
	}
	
	document.getElementById( 'baby' + babyno+ 'batch' + inc).outerHTML = options;

}

				if (document.getElementById('baby' + babyno+ 'closingStock' + inc)
							&& stock.childNodes[0] != undefined) {
						document.getElementById('baby' + babyno+ 'closingStock' + inc).value = stock.childNodes[0].nodeValue;
						if (stock.childNodes[0].nodeValue == 0) {
							alert("Stock is not available...");
						}
					} else {
					}

				}
			}
		}
		var url = "/hms/hms/lr?method=displayAU&pvmsNo=" + pvmsNo;
		// var
		// url="/hms/hms/opd?method=displayAU&pvmsNo="+pvmsNo+"&"+&hinId=<%=visit.getHin().getId()%>";
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
}


function checkDuplicateOtherMedicine(val, inc) {
	if (val != "") {
		if (inc > 0) {
			for (i = 1; i <= inc; i++) {

				if (inc != i) {
					if (document.getElementById('otherMedicine' + i)
							&& document.getElementById('otherMedicine' + i).value == val) {
						alert("Other Drug Name already entered...!")
						document.getElementById('otherMedicine' + inc).value = ""
						var e = eval(document.getElementById('otherMedicine'
								+ inc));
						e.focus();
						return false;
					}
				}
			}
		}

		var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
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
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];

					var message = item.getElementsByTagName("message")[0];
					if (message.childNodes[0] != undefined) {
						alert(message.childNodes[0].nodeValue);
						document.getElementById('otherMedicine' + inc).value = "";
						document.getElementById('nomenclature' + inc).readOnly = false;
						document.getElementById('otherMedicine' + inc).readOnly = false;
					}
				}
			}
		}
		var url = "/hms/hms/opd?method=checkDuplicateForOtherMedicine&pvmsNo="
				+ val;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
}

function fillNok2Details() {
	if (document.getElementById('nok2NameId').value != '') {
		document.getElementById('nok2PoliceStation').value = document
				.getElementById('nok1PoliceStation').value;
		document.getElementById('nok2PinCode').value = document
				.getElementById('nok1PinCode').value;
	}
}
function checkForSystemDiagnosis(val) {
	// alert("val==="+val);
	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForChargeCode = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var diagId = val.substring(index1, index2);
		var indexForDiagCode = indexForDiagCode--;
		var diagCode = val.substring(0, indexForDiagCode);
		if (diagId == "") {
			document.getElementById('systemDiagnosis').value = "";
			return;
		}
	} else {
		document.getElementById('systemDiagnosis' + inc).value = "";

	}
}
function validateAVServiceNo(serviceNo) {

	if (trimAll(serviceNo) != '') {
		/*if (validateAlphaNumeric(serviceNo)) {*/
		if (true) {
			var serNo = trimAll(serviceNo);

			if (serNo != 0) {
				getServicePersonName('casualtyAirEvacuation',
						'aviationMedicine?method=getServicePersonName');
				// getHin();

			} else {
				alert("Employee No. can not be 0.")
				document.getElementById('serviceNoId').value = "";
			}
		} else {
			alert("Employee No is not valid.")
			document.getElementById('serviceNoId').value = "";
		}
	}
}

function checkDateLessThanEqualToCurrent(val, obj) {
	var dateToValidate = new Date(val.substring(6), (val.substring(3, 5) - 1),
			val.substring(0, 2));
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);

	if (dateToValidate > currentDate) {
		alert("Date should be less than or equal to current date.");
		obj.value = '';
		return false;
	}
	return true;

}

function checkDateGreaterEqualToCurrent(val, obj) {
	var dateToValidate = new Date(val.substring(6), (val.substring(3, 5) - 1),
			val.substring(0, 2));
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);

	if (dateToValidate < currentDate) {
		alert("Date should not be less than current date.");
		obj.value = '';
		return false;
	}
	return true;

}

function validateBpValue(obj) {
	var bpObj = document.getElementById('bp');
	var bool = validateBpWithSlash(obj)
	if (bool) {

		if (obj != "") {
			var index = obj.indexOf('/');

			var pairs2 = obj.substring(0, obj.length).split('/');
			if (pairs2.length != 2) {
				alert("Invalid  Format.BP should be in min/max Format.")
				return false;
			}
			val2 = eval(pairs2[0]);
			if (val2 < 60) {
				alert("Minimum BP should be greater than 60.")
				return false;
			}

			val3 = eval(pairs2[1]);
			if (val3 > 240) {
				alert("Maximum BP should be less than 240.")
				return false;
			}

		}
		return true;
	}
	bpObj.value = "";
	bpObj.focus();
	return false;
}

function chkLength(field, maxLimit) {
	if (field.value.length > maxLimit) {
		alert('Maximum Limit is ' + maxLimit + ' characters.');
		var val = field.value.substring(0, maxLimit);
		field.value = val;
	}

}

function checkFilledRow() {

	var msg = "";
	var flag = "";
	var count = document.getElementById('hiddenValueCharge').value;
	for (var i = 1; i <= count; i++) {
		if (document.getElementById('chargeCode' + i) != null) {
			if (document.getElementById('chargeCode' + i).value != "") {
				if (document.getElementById('qty' + i).value == "") {
					msg += "Quantity can not be blank.\n";
				}

				if (msg != "") {
					break;
				}
			}

		}
	}

	for (var i = 1; i <= count; i++) {
		if (document.getElementById('chargeCode' + i) != null) {
			if (document.getElementById('chargeCode' + i).value != "") {
				flag = "filled";
				break;
			} else {
				flag = "Not Filled";
			}
		}
	}
	if (flag == "Not Filled") {
		alert("Please fill atleast one charge to submit.");
		return false;
	}
	if (msg != "") {
		alert(msg)
		return false;
	} else {
		return true;
	}
}

function validateFieldsOnSubmit() {

	// var patientType = 0;
	// if(document.getElementById('patientTypeId'))
	// patientType = document.getElementById('patientTypeId').value;
	// if(patientType==13){
	// if(document.getElementById('authorizerId')!=null){
	// if(patientType != '8' && patientType != '2' && patientType != '1' &&
	// patientType != '4' ){
	// if(document.getElementById('authorizerId').disabled == false){
	// if(document.getElementById('authorizerId').value == "0"){
	// alert("Select Authorizer.");
	// document.getElementById('authorizerId').focus();
	// return false;
	// }
	//
	// }
	// }
	// }

	/*
	 * if(document.getElementById('advAdjCheckId')){
	 * if(document.getElementById('advAdjCheckId').checked){
	 * if(document.getElementById('advAdjId').value == "" &&
	 * document.getElementById('advAdjId').value == "0" ){ alert("Please enter
	 * Advance Adjustment Amount"); return false; } } }
	 */

	var flag = false;
	var cnt = document.getElementById("hiddenValueCharge").value;
	for (var i = 1; i <= cnt; i++) {
		if (document.getElementById("selectedCharge" + i).checked == true) {
			flag = true;
			break;
		}
	}

	if (!flag) {
		alert("Please select at least one chargecode");
		return false;
	}

	var payableAmt = 0;
	if (document.getElementById('payableAmtId'))
		payableAmt = document.getElementById('payableAmtId').value;

	var count = document.getElementById('hiddenValuePayment').value;
	var msg = "";
	var prevCNo = "";
	var prevPayMode = "";
	for (var i = 1; i <= count; i++) {
		var cNo;
		if (document.getElementById('cqeId' + i))
			cNo = document.getElementById('cqeId' + i).value;

		var payMode = "";
		if (document.getElementById('paymentModeId' + i))
			payMode = document.getElementById('paymentModeId' + i).value;

		if (document.getElementById("amt" + i).value.trim() == ""
				|| payMode == ""
				|| !document.getElementById("selectedPayMode").checked) {
			alert("Please Select Payment Mode.");
			return false;
		}
		if (payMode.trim() != "") {
			var amt = document.getElementById("amt" + i).value;
			if (amt == "") {
				msg += "Please enter amount in payment details.\n";
			}

			if (payMode == "Q" || payMode == "R") {
				if (document.getElementById('cqeId' + i).value == "") {
					msg += "Cheque/Credit Card No can not be blank for payment mode Cheque/Credit Card.\n";
				}
				if (document.getElementById('chqDate' + i).value == "") {
					msg += "Cheque/Credit Card Expiry Date can not be blank for payment mode Cheque/Credit Card.\n";
				}
				if (document.getElementById('bankId' + i).value == "0") {
					msg += "Bank can not be blank for payment mode Cheque/Credit Card.\n";
				}
			}
			if (parseFloat(amt) < 0) {
				msg += "Please enter valid amount value.\n";
				document.getElementById('amt' + i).value = "";
			}

			if (prevCNo != "" && cNo != "") {
				if (prevCNo == cNo) {
					msg += "Cheque/Credit Card No can not be duplicate.\n";
					document.getElementById('cqeId' + i).value = "";
				}
			}
			if (prevPayMode != "" && payMode != "") {
				if (prevPayMode == payMode) {
					msg += "Payment Mode Cash can not be more than one time.\n";
					document.getElementById('paymentModeId' + i).value = "";
					document.getElementById('amt' + i).value = "";
				}
			}

			if (msg != "") {
				break;
			}
			prevCNo = document.getElementById('cqeId' + i).value;

			if (document.getElementById('paymentModeId' + i).value == "C")
				prevPayMode = document.getElementById('paymentModeId' + i).value;
		}
	}
	if (msg != "") {
		alert(msg)
		return false;
	} else {
		return checkAmountToPay(1);
		/* return true; */
	}

	/* } */
	return true;
}

function validateFieldsOnSubmitForOtherPatients() {

	// var patientType = 0;
	// if(document.getElementById('patientTypeId'))
	// patientType = document.getElementById('patientTypeId').value;
	// if(patientType==13){
	// if(document.getElementById('authorizerId')!=null){
	// if(patientType != '8' && patientType != '2' && patientType != '1' &&
	// patientType != '4' ){
	// if(document.getElementById('authorizerId').disabled == false){
	// if(document.getElementById('authorizerId').value == "0"){
	// alert("Select Authorizer.");
	// document.getElementById('authorizerId').focus();
	// return false;
	// }
	//
	// }
	// }
	// }

	/*
	 * if(document.getElementById('advAdjCheckId')){
	 * if(document.getElementById('advAdjCheckId').checked){
	 * if(document.getElementById('advAdjId').value == "" &&
	 * document.getElementById('advAdjId').value == "0" ){ alert("Please enter
	 * Advance Adjustment Amount"); return false; } } }
	 */

	var flag = false;

	for (var i = 1; i <= document.getElementsByName("selectedChrage").length; i++) {
		if (document.getElementById("selectedCharge" + i).checked == true) {
			flag = true;
		}
	}
	if (!flag) {
		alert("Please select at least one chargecode");
		return false;
	}

	var payableAmt = 0;
	if (document.getElementById('payableAmtId'))
		payableAmt = document.getElementById('payableAmtId').value;

	var count = document.getElementById('hiddenValuePayment').value;
	var msg = "";
	var prevCNo = "";
	var prevPayMode = "";
	for (var i = 1; i <= count; i++) {
		var cNo;
		if (document.getElementById('cqeId' + i))
			cNo = document.getElementById('cqeId' + i).value;

		var payMode = "";
		if (document.getElementById('paymentModeId' + i))
			payMode = document.getElementById('paymentModeId' + i).value;

		if (document.getElementById("amt" + i).value.trim() == ""
				|| payMode == ""
				|| !document.getElementById("selectedPayMode").checked) {
			alert("Please Select Payment Mode.");
			return false;
		}
		if (payMode.trim() != "") {
			var amt = document.getElementById("amt" + i).value;
			if (amt == "") {
				msg += "Please enter amount in payment details.\n";
			}

			if (payMode == "Q" || payMode == "R") {
				if (document.getElementById('cqeId' + i).value == "") {
					msg += "Cheque/Credit Card No can not be blank for payment mode Cheque/Credit Card.\n";
				}
				if (document.getElementById('chqDate' + i).value == "") {
					msg += "Cheque/Credit Card Expiry Date can not be blank for payment mode Cheque/Credit Card.\n";
				}
				if (document.getElementById('bankId' + i).value == "0") {
					msg += "Bank can not be blank for payment mode Cheque/Credit Card.\n";
				}
			}
			if (parseFloat(amt) < 0) {
				msg += "Please enter valid amount value.\n";
				document.getElementById('amt' + i).value = "";
			}

			if (prevCNo != "" && cNo != "") {
				if (prevCNo == cNo) {
					msg += "Cheque/Credit Card No can not be duplicate.\n";
					document.getElementById('cqeId' + i).value = "";
				}
			}
			if (prevPayMode != "" && payMode != "") {
				if (prevPayMode == payMode) {
					msg += "Payment Mode Cash can not be more than one time.\n";
					document.getElementById('paymentModeId' + i).value = "";
					document.getElementById('amt' + i).value = "";
				}
			}

			if (msg != "") {
				break;
			}
			prevCNo = document.getElementById('cqeId' + i).value;

			if (document.getElementById('paymentModeId' + i).value == "C")
				prevPayMode = document.getElementById('paymentModeId' + i).value;
		}
	}
	if (msg != "") {
		alert(msg)
		return false;
	} else {
		return checkAmountToPay(1);
		/* return true; */
	}

	/* } */
	return true;
}

function checkCollectedAmt() {
	var patientType = 0;
	if (document.getElementById('patientTypeId'))
		patientType = document.getElementById('patientTypeId').value;
	if (document.getElementById('actualColAmtId') != null) {
		var os = "";
		if (document.getElementById('outstandingId')) {
			if (document.getElementById('outstandingId').value != "") {
				os = document.getElementById('outstandingId').value;
			}
		}

		if (patientType == 13 && (patientType == '3' || patientType == 0)
				&& (os == "" || parseFloat(os) == 0)) {
			if (document.getElementById('actualColAmtId').value == "") {
				alert("Please Enter Collected Amount.");
				document.getElementById('actualColAmtId').focus();
				return false;
			}
		}
	}
	return true;
}

function validatePaymentAmt() {
	var msg = "";
	/*
	 * var patientTypeId=document.getElementById('patientTypeId').value;
	 * if(patientTypeId==13){
	 */
	var payAmt = 0;

	var cnt = document.getElementById('hiddenValuePayment').value;
	var total = 0;
	// if(document.getElementById('advAdjCheckId')){
	// if(document.getElementById('advAdjCheckId').checked){
	// if(document.getElementById('advAdjId').value == ""){
	// msg += "Please enter Advance Adjustment Amount.\n";
	// document.getElementById('advAdjId').focus();
	// }
	// if(document.getElementById('advAdjId').value >
	// document.getElementById('totalNetId').value){
	// alert("Advance Adjustment amt should be less than or equal to Net
	// Amount.");
	// document.getElementById('advAdjId').value = "";
	// }
	// }
	// }

	for (var i = 1; i <= cnt; i++) {
		if (document.getElementById('amt' + i)) {
			if (document.getElementById('amt' + i).value != ""
					&& document.getElementById('amt' + i).value != "0") {
				total = parseFloat(total)
						+ parseFloat(document.getElementById('amt' + i).value);
				document.getElementById('amt' + i).readOnly = false;
			}
		}
	}
	if (total != 0) {
		if (parseFloat(total) < parseFloat(payAmt)) {
			msg += "Payment Amount should be equal to Payable Amount.\n";
		}
	} else if (payAmt != 0 && total <= 0) {
		msg += "Please enter Amount in Payment Details.\n";
	}

	if (msg != "") {
		alert(msg)
		return false;
	}
	// }
	return true;

}

function validateChequeAndCreditCardDate() {

	var currentDate = new Date();

	var year = 0;
	var month = 0;
	var day = 0;

	year = currentDate.getFullYear();

	month = (currentDate.getMonth() + 1) - 6;
	if (month <= 0) {
		month = month + 12
		year--;
	}
	month = (month < 10) ? "0" + month : month

	day = (currentDate.getDate())
	if (day < 0) {
		day = day + 30
		month--;
	}
	day = (day < 10) ? "0" + day : day

	if (year <= 0)
		year = currentDate.getFullYear() + year;
	if (month <= 0)
		month = (((currentDate.getMonth() + 1) + month) < 10) ? "0"
				+ ((currentDate.getMonth() + 1) + month) : ((currentDate
				.getMonth() + 1) + month);
	if (day == 0)
		day = (currentDate.getDate() < 10) ? "0" + currentDate.getDate()
				: currentDate.getDate();

	prevDate = new Date(month + "/" + day + "/" + year);

	var msg = "";

	var cnt = document.getElementById('hiddenValuePayment').value;
	for (var i = 1; i <= cnt; i++) {
		if (document.getElementById('paymentModeId' + i)) {
			if (document.getElementById('paymentModeId' + i).value == "Q") {
				var dateStr = document.getElementById('chqDate' + i).value;
				if (dateStr != "") {
					chqDate = new Date(dateStr.substring(6), (dateStr
							.substring(3, 5) - 1), dateStr.substring(0, 2));
					if (chqDate < prevDate) {
						msg += "Cheque Date is not valid.\n";
						document.getElementById('chqDate' + i).value = "";
					}
				}
			} else if (document.getElementById('paymentModeId' + i).value == "R") {
				var dateStr = document.getElementById('chqDate' + i).value;
				if (dateStr != "") {
					var curmonth = currentDate.getMonth() + 1;
					var curday = currentDate.getDate();
					var curyear = currentDate.getFullYear();
					var seperator = "/";
					currentDate = new Date(curmonth + seperator + curday
							+ seperator + curyear);
					crDate = new Date(dateStr.substring(6), (dateStr.substring(
							3, 5) - 1), dateStr.substring(0, 2));
					if (currentDate > crDate) {
						msg += "Credit card Date is not valid.\n";
						document.getElementById('chqDate' + i).value = "";
					}
				}
			}
		}
	}

	if (msg != "") {
		alert(msg);
		return false;
	}

	return true;

}

function validateAmount(val, inc) {
	if (val != "") {
		if (!validateFloat(val)) {
			alert("Please enter valid amount.");
			document.getElementById('amt' + inc).value = "";
			return false;
		} else {
			if (val <= 0) {
				alert("Please enter valid amount.");
				document.getElementById('amt' + inc).value = "";
				return false;
			}
			if (val.substring(0, 1) == "+" || val.substring(0, 1) == "-") {
				alert("Please enter valid amount.");
				document.getElementById('amt' + inc).value = "";
				return false;
			}
		}
	}
	if (document.getElementById('amtHidden' + inc)) {
		document.getElementById('amtHidden' + inc).value = val;
	}
	return true;
}

function validateAmount(val, inc) {
	if (val != "") {
		if (!validateFloat(val)) {
			alert("Please enter valid amount.");
			document.getElementById('amt' + inc).value = "";
			return false;
		} else {
			if (val <= 0) {
				alert("Please enter valid amount.");
				document.getElementById('amt' + inc).value = "";
				return false;
			}
			if (val.substring(0, 1) == "+" || val.substring(0, 1) == "-") {
				alert("Please enter valid amount.");
				document.getElementById('amt' + inc).value = "";
				return false;
			}
		}
	}
	if (document.getElementById('amtHidden' + inc)) {
		document.getElementById('amtHidden' + inc).value = val;
	}
	return true;
}


function setAge(dateString, id) {
	var today = new Date();
	var parts =dateString.split('/');	
	var birthDate = new Date(parts[2],parts[1]-1,parts[0]);
	var age = today.getFullYear() - birthDate.getFullYear();
	var m = today.getMonth() - birthDate.getMonth();
	flag = true;
/*	alert(birthDate);
	alert(birthDate.getMonth());
	alert(today.getMonth());
	alert(age);
	alert(m);*/
	if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
		age--;
	}
	if (age < 0) {
		alert("Date of birth can't be greator than current date");
		age = '';
		flag = false;
	} else if (age == 0) {
		age = 1;
	}

	document.getElementById(id).value = age;
	return flag;

}

function fnGetDoctorDepartment(departmentId, divName, loginDoctor) {
	
	// new Ajax.Request('opd?method=getDoctorDepartment&departmentId='+departmentId+'&'+csrfTokenName+'='+csrfTokenValue, {
	 var extraArg ='n';
	 if(loginDoctor!=null)
		 extraArg = loginDoctor;
	new Ajax.Request(
			'opd?method=getDoctorDetails&departmentId=' + departmentId+'&loginDoctor='+extraArg,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						document.getElementById(divName).innerHTML = response.responseText
								.trim();
					}
				}
			});
}

function fnGetPsyQuestionByHeading(headingId, divName, visitId, headingInc) {

	new Ajax.Request(
			'opd?method=getPsyQuestionByHeadingId&headingId=' + headingId+'&visitId='+visitId+'&headingInc='+headingInc,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						document.getElementById(divName).innerHTML = response.responseText
								.trim();
					}
				}
			});
}

function fnGetQuestionnaire(questionId, divName, extraArg) {
	
	
	new Ajax.Request(
			'opd?method=getQuestionnaire&questionId=' + questionId,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						document.getElementById(divName).innerHTML = response.responseText
								.trim();
					}
				}
			});
}

function fillCheckBoxValue(chkId)
{
	
	if(document.getElementById(chkId).checked) {
		document.getElementById(chkId).value =  'y';
    }
	else
		document.getElementById(chkId).value =  'n';
}
function auto_grow(element) {
    /* element.style.height = "5px"; */
    element.style.height = (element.scrollHeight)+"px";
}

function openWindow(url){

    newwindow=window.open(url,'name',"left=2,top=100,height=750,width=1000,status=1,scrollbars=1,resizable=0");
	
}

function openDynamicWindow(url,width){

    newwindow=window.open(url,'name',"left=2,top=100,height=750,width="+width+",status=1,scrollbars=1,resizable=0");
	
}