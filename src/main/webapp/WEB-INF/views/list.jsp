<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name = "_csrf" content ="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>List</title>
	<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${contextPath}/resources/css/main.css" rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
        $(document).ready(function() {
            var csrf_token = "{{ csrf_token() }}";
            var listItems = new Array();
            var date = new Date();

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

            $("#addButton").click(function(){
                var newRow = "<tr><td>"+$("#name").val()+"</td>"+
                    "<td>"+$("#contact").val()+"</td>"+
                    "<td>"+$("#finishTime").val()+"</td>"+
                    "<td><img src='${contextPath}/resources/images/removeButton.png' alt='remove Button' id='removeButton' /></td>";
                $("#listItems tbody").append(newRow);
                var listItem={name:$("#name").val(),contact:$("#contact").val(),time:$("#finishTime").val()};
                listItems.push(listItem);
                addItems(listItems, 1, date);
                clearNewItem();
            });

            $("#startOver").click(function(){
                $("#listItems tbody").remove();

                //TODO: ajax query to remove list
            });

            $('tbody').on('click', '#removeButton', function(){
                //TODO: need to get currentrow remove from listItems then call addItems again
                //to update the list
                $(this).closest('tr').remove();
            });

        });

        function addItems(listItems, userId, date){
            var data={};
            data["listItems"]= JSON.stringify(listItems);
            data["userId"] = userId;
            data["date"] = new Date(date);
            alert(JSON.stringify(data));
            $.ajax({
                type: "POST",
                url: "addList",
                contentType:'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                error: function(e){
                    alert(e);
                }
            });
        }

        function removeItems(listItems){

        }

        function clearNewItem(){
            $("#name").val("");
            $("#contact").val("");
            $("#finishTime").val("");
        }
	</script>
</head>
<mytags:navbar/>
<body>
	<div class="container">

		<div class="row">
			<div class="col-lg-12">
				<h1>Welcome ${name} !</h1>
				<br>
				<p>Today is ${today} <br> What's on your to-do list?</p>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<table id="listItems">
					<thead>
					<tr>
						<th>Task</th>
						<th>Who to contact</th>
						<th>When to finish</th>
						<th>Actions</th>
					</tr>
					<tr>
						<td><input type="text" id="name"></td>
						<td><input type="text" id="contact"></td>
						<td><input type="time" id="finishTime"></td>
						<td><img src="${contextPath}/resources/images/addButton.png" alt="Add Button" id="addButton" /></td>
					</tr>
					</thead>

					<tbody>
					</tbody>
				</table>
				<button class="btn btn-primary" id="startOver">Start Over</button>
			</div>
		</div>

	</div>
</body>
</html>