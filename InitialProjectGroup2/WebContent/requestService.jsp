<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>Request a Service</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<style type="text/css">
	html {height: 100%}
	body {height: 100%;margin: 0;padding: 0}
	#map_canvas {height: 100%}
</style>
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA94hmfvGHgxgYNdzO0tTWfk8haLWUopGo&sensor=false">
	
</script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.8.24/jquery-ui.min.js"></script>
<script type="text/javascript" src="javascript/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="javascript/jquery-ui-sliderAccess.js"></script>
<script
	src="http://xoxco.com/projects/code/tagsinput/jquery.tagsinput.js"></script>
<link rel="stylesheet" media="all" type="text/css"
	href="http://code.jquery.com/ui/1.8.23/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" media="all" type="text/css"
	href="css/jquery-ui-timepicker-addon.css" />

<link rel="stylesheet"
	href="http://xoxco.com/projects/code/tagsinput/jquery.tagsinput.css">
<script type="text/javascript">
	var map;
	var markersArray = [];
	var geocoder;
	function initialize() {
		geocoder = new google.maps.Geocoder();
		var myLatlng = new google.maps.LatLng(41.028607, 28.974838);
		var mapOptions = {
			zoom : 8,
			center : myLatlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map_canvas"),
				mapOptions);

		google.maps.event.addListener(map, 'click', function(event) {
			//clearOverlays();
			addMarker(event.latLng);
		});
	}

	function addMarker(location) {
		
		var radius;
		radius = prompt("Enter a radius in kilometers", "0");
		if(radius){
			var intRegex = /^\d+$/;
			if(!intRegex.test(radius)) {
			   alert("Radius must be a non-negative number!");
			  	return;
			}
		document.getElementById("gpsLocation").value += location.lat() + "-";
		document.getElementById("gpsLocation").value += location.lng() + "-";
		document.getElementById("gpsLocation").value += radius + ";";
		var marker = new google.maps.Marker({
			position : location,
			map : map
		});
		markersArray.push(marker);
		alert("New location info has been added!");
		}
	}
	function clearOverlays() {
		if (markersArray) {
			for (i in markersArray) {
				markersArray[i].setMap(null);
			}
		}
	}
	function codeAddress() {
		var address = document.getElementById('address').value;
		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				map.setCenter(results[0].geometry.location);
				map.setZoom(14);

				//clearOverlays();
				//addMarker(results[0].geometry.location);
			}
			; //else {
			//alert('Geocode was not successful for the following reason: ' + status);
			//}
		});
	}
</script>
</head>
<body onload="initialize()">
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class=""><a href="profile.jsp">Home</a></li>
              <li class=""><a href="createService.jsp">Offer a Service</a></li>
              <li class="active"><a href="requestService.jsp">Request a Service</a></li>
              <li class=""><a href="searchPage.jsp">Search for a Service</a></li>
            </ul>
            <ul class="nav pull-right">
                  <li><a href="Logout.jsp">Logout</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
<br><br><br>
	<div class="container"><h1>Request a Service</h1><hr>
	<form name="serviceDetails" action="insertRequest.jsp" method="post">
	<div class="searchTd">
		Service Title : <hr> <input type="text" id="title" name="title" size="42"> 
		<div id="description" class="searchTd">
		<hr> Service Description :<hr> 
		</div>
		<div id="tags_" class="searchTd">
		<textarea rows="5" cols="30" name="description"></textarea></div>
		<hr> Time Interval : <hr><input type="text" id="date_start" name="date_start" size="19">
		<input type="text" id="date_end" name="date_end" size="19"></div>
		
		<script type="text/javascript">
			var startDateTextBox = $('#date_start');
			var endDateTextBox = $('#date_end');

			startDateTextBox.datetimepicker({
				minDate: new Date(),
				dateFormat: "yy-mm-dd",
				onClose : function(dateText, inst) {
					if (endDateTextBox.val() != '') {
						var testStartDate = startDateTextBox
								.datetimepicker('getDate');
						var testEndDate = endDateTextBox
								.datetimepicker('getDate');
						if (testStartDate > testEndDate)
							endDateTextBox.datetimepicker('setDate',
									testStartDate);
					} else {
						endDateTextBox.val(dateText);
					}
				},
				onSelect : function(selectedDateTime) {
					endDateTextBox.datetimepicker('option', 'minDate',
							startDateTextBox.datetimepicker('getDate'));
				}
			});
			endDateTextBox.datetimepicker({
				minDate: new Date(),
				dateFormat: "yy-mm-dd",
				onClose : function(dateText, inst) {
					if (startDateTextBox.val() != '') {
						var testStartDate = startDateTextBox
								.datetimepicker('getDate');
						var testEndDate = endDateTextBox
								.datetimepicker('getDate');
						if (testStartDate > testEndDate)
							startDateTextBox.datetimepicker('setDate',
									testEndDate);
					} else {
						startDateTextBox.val(dateText);
					}
				},
				onSelect : function(selectedDateTime) {
					startDateTextBox.datetimepicker('option', 'maxDate',
							endDateTextBox.datetimepicker('getDate'));
				}
			});
		</script>
		<div id="element_tags" class="searchTd">

		<hr>Tags :<hr> <input id="tags" name="tags"/><br>

		<script type="text/javascript">
			$('#tags').tagsInput({
				'height' : '100px',
				'width' : '300px',
				'interactive' : true,
				'defaultText' : 'add a tag',
				'removeWithBackspace' : true,
				'minChars' : 0,
				'maxChars' : 20, //if not provided there is no limit,
				'placeholderColor' : '#666666'
			});
		</script>
		</div>
		<input type="hidden" id="gpsLocation" name="gpsLocation">
		<div id="submit" class="searchTd">
		<input type="submit" value="Submit" class="btn btn-primary">
		</div>
	
	</div></form>
	<div class="container"><hr>Select locations for your service from the map below:<hr><br></div>

	<div id="map_canvas" style="width: 50%; height: 30%; margin:auto"></div><br>
	<div class="container"><hr><div class="searchTd">
	Find an address :
	<input type="text" id="address">
	<input type="button" value="Find" id="addressFind"
		onClick="codeAddress()"></div><hr>
		
		<div id="footer"><p>Copyright � Boun Cmpe451 - Group 2</p></div></div>

</body>
</html>