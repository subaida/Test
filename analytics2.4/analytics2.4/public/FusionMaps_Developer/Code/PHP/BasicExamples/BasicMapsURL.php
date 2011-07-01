<HTML>
<HEAD>
	<TITLE>FusionMaps XML Data Show</TITLE>
    <?php
	/*
	We've included ../Includes/FusionMaps.js, which contains functions
	to help us easily embed the Maps.
	*/
	include("../Includes/FusionMaps.php");
	
	# We've included ../Includes/FusionMaps.js, which contains functions
	# to help us easily embed the maps.
	?>
    <script language="javascript" src="../JSClass/FusionMaps.js"></script>
	<style type="text/css">
	<!--
	body {
		font-family: Arial, Helvetica, sans-serif;
		font-size: 12px;
	}
	-->
	</style>
</HEAD>
<BODY>
<CENTER>
<h2><a href="http://www.fusioncharts.com" target="_blank">FusionMaps</a> - PHP Samples</h2>
<h4>Using dataURL method&nbsp; <br>
  Retrieving data stored in an Array </h4>

   <?php
   
   # We define a $dataURL that contains the name of the Data Provider Page.(getURLdata.php)
   $dataURL="getURLdata.php";
   # Finally Rendering the World8 Maps with renderMap() php function present in FusionMaps.php (include file)
	# Also, since we're using dataURL method, we provide a "" value for dataXML here
	#************************************************************************
	
	print renderMap("../../Maps/FCMap_World8.swf",$dataURL,"","UsaMaps", 750, 460,0,0);
	
	#************************************************************************
   
   ?>
    
<BR><BR>
<a href='../NoChart.html' target="_blank">Unable to see the chart above?</a>
<BR><H5 ><a href='../default.htm'>&laquo; Back to list of examples</a></h5>
</CENTER>
</BODY>
</HTML>