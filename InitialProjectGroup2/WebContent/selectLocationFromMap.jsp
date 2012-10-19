<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    <script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA94hmfvGHgxgYNdzO0tTWfk8haLWUopGo&sensor=false">
    </script>
    <script type="text/javascript">
    var map;
    var markersArray = [];
    var geocoder;
    function initialize() {
      geocoder = new google.maps.Geocoder();
      var myLatlng = new google.maps.LatLng(41.028607, 28.974838);
      var mapOptions = {
        zoom: 8,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

      google.maps.event.addListener(map, 'click', function(event) {
    	clearOverlays();  
        addMarker(event.latLng);
      });
    }

    function addMarker(location) {
      var marker = new google.maps.Marker({
          position: location,
          map: map
      });
      markersArray.push(marker);
      document.getElementById ("latitude").value = location.lat();
      document.getElementById("longtitude").value = location.lng();
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
        geocoder.geocode( { 'address': address}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            clearOverlays();
            addMarker(results[0].geometry.location);
          } //else {
            //alert('Geocode was not successful for the following reason: ' + status);
          //}
        });
      }

    </script>
  </head>
  <body onload="initialize()">
    	<form>
			Find an address  : <input type="text" id="address">
			<input type="button" value="Find" id="addressFind" onClick="codeAddress()">
		</form>
    <div id="map_canvas" style="width:50%; height:50%"></div>
    <div><form>
		Latitude  : <input type="text" id="latitude"><br>
		Longtitude: <input type="text" id="longtitude">
	</form></div>
  </body>

</html>