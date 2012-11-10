<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Search for a Service!</title>
	<style type="text/css">
		html { height: 100% }
		body { height: 100%; margin: 0; padding: 0 }
		#map_canvas { height: 100% }
	</style>
	<script type="text/javascript"
		src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA94hmfvGHgxgYNdzO0tTWfk8haLWUopGo&sensor=false">
	</script>
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-1.8.2.min.js">
	</script>
	<script type="text/javascript"
		src="http://code.jquery.com/ui/1.8.24/jquery-ui.min.js">
	</script>
	<script type="text/javascript" src="javascript/jquery-ui-timepicker-addon.js"></script>
	<script type="text/javascript" src="javascript/jquery-ui-sliderAccess.js"></script>
	<script	src="http://xoxco.com/projects/code/tagsinput/jquery.tagsinput.js"></script>
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
		var marker = new google.maps.Marker({
			position : location,
			map : map
		});
		markersArray.push(marker);
		var radius = 0;
		radius = prompt("Enter a radius in kilometers", "0");
		document.getElementById("gpsLocation").value += location.lat() + "-";
		document.getElementById("gpsLocation").value += location.lng() + "-";
		document.getElementById("gpsLocation").value += radius + ";";
		alert("New location info has been added!");
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
	<form name="searchPage" action="searchResult.jsp" method="post">
	<table border = "0">
	<tr>
	<td width="60%">
		Step 1: Enter Tags for Service <input id="tags" name="tags"/><br>
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
	</td>
	<td>
		Step 2: Enter Time Interval of Service 
		<br> <br> From <input type="text" id="date_start" name="date_start">
		Until <input type="text" id="date_end" name="date_end"><br>
		<script type="text/javascript">
			var startDateTextBox = $('#date_start');
			var endDateTextBox = $('#date_end');

			startDateTextBox.datetimepicker({
				dateFormat: "yy-mm-d",
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
				dateFormat: "yy-mm-d",
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
	</td>
	</tr>
	<tr>
	<td width="60%">
		<br> Step 3: Select location for Service <br>
		<input type="hidden" id="gpsLocation" name="gpsLocation">
	</td>
	<td>
		<br><input type="submit" value="Search">
	</td>
	</tr>
	</table>
	</form>
	<div id="map_canvas" style="width: 40%; height: 30%"></div>
		<br> Find an address :
		<input type="text" id="address">
		<input type="button" value="Find" id="addressFind"
		onClick="codeAddress()">
</body>
</html>