<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<style>
		#errorMessage{
			visibility: hidden;
		}
		.error{
			border: 2px solid red;
		}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="${contextPath}/resources/js/listValidator.js" type="application/javascript"></script>

	<meta name = "_csrf" content ="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>List</title>
	<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${contextPath}/resources/fullcalendar/fullcalendar.print.css" rel="stylesheet" />
	<link href="${contextPath}/resources/fullcalendar/fullcalendar.css" rel="stylesheet" />
	<link href="${contextPath}/resources/css/main.css" rel="stylesheet">


</head>
<mytags:navbar/>
<body>
<div class="container">

	<div class="row">
	<div class="col-md-10">

		<div class="row">
			<div class="col-lg-12">
				<h1>Welcome ${userName}!</h1>
				<br>
				<p id="todaysDate">Today is <strong>${today}</strong><br> What's on your to-do list?</p>
			</div>
		</div>

		<div class="row list-and-calendar">
			<div class="col-lg-8">
				<table id="listItems" class="table-striped">
					<thead>
					<tr>
						<th>Task</th>
						<th>Who to contact</th>
						<th>When to finish</th>
						<th>Actions</th>
					</tr>
					<tr>
						<th id="errorMessage" class="alert alert-danger" colspan="5">please correct the errors in red.</th>
					</tr>
					<tr>
						<td><input type="text" id="name" maxlength="50"></td>
						<td><input type="text" id="contact" maxlength="25"></td>
						<td><input type="time" id="finishTime"></td>
						<td><img src="${contextPath}/resources/images/addButton.png" alt="Add Button" id="addButton" /></td>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<button class="btn btn-primary" id="startOver">Start Over</button>
			</div>

			<div class="col-md-4">
				<!--  TODO: Calendar -->
				<div id="calendar"></div>

			</div>

		</div>

	</div>


	</div>
</div>

	<script src="${contextPath}/resources/fullcalendar/lib/jquery.min.js" type="application/javascript"></script>
	<script src="${contextPath}/resources/fullcalendar/lib/jquery-ui.min.js" type="application/javascript"></script>
	<script src="${contextPath}/resources/fullcalendar/lib/moment.min.js" type="application/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js" type="application/javascript"></script>
	<script type="text/javascript">
        $(document).ready(function() {
            var listItems = new Array();
            var date = new Date();
            var rowNum = 0;

            $.ajaxSetup({
                beforeSend: function(xhr, settings) {
                    var header = $("meta[name='_csrf_header']").attr("content");
                    var token = $("meta[name='_csrf']").attr("content");
                    if (!(/^http:.*/.test(settings.url) || /^https:.*/.test(settings.url))) {
                        // Only send the token to relative URLs i.e. locally.
                        xhr.setRequestHeader(header, token);
                    }
                }
            });

            //TODO: populate list with items on ToDoList for logged in user
            //update row number
            //add items to list

            $("#addButton").click(function(){
                if (validateFields($("#name"),$("#contact"),$("#finishTime"))){
                    //clear show error
                    document.getElementById("errorMessage").style.visibility = "hidden";
                    document.getElementById("errorMessage").innerHTML = "please correct the errors in red.";
                    var newRow = "<tr id="+rowNum+"><td>"+$("#name").val()+"</td>"+
                        "<td>"+$("#contact").val()+"</td>"+
                        "<td>"+$("#finishTime").val()+"</td>"+
                        "<td><img src='${contextPath}/resources/images/removeButton.png' alt='remove Button' id='removeButton' /></td>";
                    $("#listItems tbody").append(newRow);
                    var listItem={name:$("#name").val(),contact:$("#contact").val(),time:$("#finishTime").val()};
                    listItems.push(listItem);
                    listItemsPost(listItems, "addList", 1, date);
                    clearNewItem();
                    rowNum += 1;
                }else{
                    //display error
                    document.getElementById("errorMessage").style.visibility = "visible";
                }
            });

            $("#startOver").click(function(){
                $("#listItems tbody").html('');
                listItemsPost(listItems, "removeList", 1, date);
                listItems = new Array();
            });

            $('tbody').on('click', '#removeButton', function(){
                var indexToDelete =+ parseInt($(this).closest('tr').attr("id"));
                delete listItems[indexToDelete];
                listItems = listItems.filter(function(n){return n != undefined});
                $(this).closest('tr').remove();
                listItemsPost(listItems, "addList", 1, date);
            });

            // CALENDAR INITIALIZER
            jQuery(function() {
                // page is now ready, initialize the calendar...
                jQuery('div#calendar').fullCalendar({
                    // put your options and callbacks here
                    navLinks: true,
                    navLinkDayClick: function(date, jsEvent) {
                        console.log('day', date.format()); // date is a moment
                        console.log('coords', jsEvent.pageX, jsEvent.pageY);
                        startNewDayList(date.format());
                        $(this).css('background-color', '#d9d9d9');
                    }
                })
            });

            //function to select new day on calendar click
            function startNewDayList(newDate) {
                listItemsPost(listItems, "addList", 1, date); //Save/update existing day's items
                $("#listItems tbody").html(''); // clear list
                $("#todaysDate").html('<p id="todaysDate">Today is <strong>' + newDate +'</strong><br> What\'s on your to-do list?</p>'); // clear list
                listItems = new Array();
            }

        });

        function listItemsPost(listItems, uri, userId, date){
            var data={};
            data["listItems"]= JSON.stringify(listItems);
            data["userId"] = userId;
            data["date"] = new Date(date);
            $.ajax({
                type: "POST",
                url: uri,
                contentType:'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                error: function(e){
                }
            });
        }

        function clearNewItem(){
            $("#name").val("");
            $("#contact").val("");
            $("#finishTime").val("");
        }

	</script>
</body>
</html>