/**
 * Validates list items prior to adding them to the list
 */
function validateFields(task,contact,time){
	var validate = true;
	validate = validateTask(task);
	//TODO: Should we do any error handling for contact does there have to be a contact?
	//validate = validateContact(contact);
	if (validate != false){
		validate = validateTime(time);
	}else{
		validateTime(time);
	}	
	return validate;
}

function validateTask(task){
	if (task.val() == null || task.val().length>50 || task.val() == ''){
		if (!task.hasClass("error"))
			showError(task,"\nTask must be 1-50 characters long.");
		return false;
	}
	showError(task,"");
	return true;
}

function validateTime(time){
	if (time.val() == null || time.val() == ''){
		if (!time.hasClass("error"))
			showError(time,"\nTime must be entered.");
		return false;
	}
	showError(time,"");
	return true;
}

function showError(element,msg){
	if (msg ==""){
		element.removeClass("error");
	}else{
		element.addClass("error");
		document.getElementById("errorMessage").append(msg);		
	}
}