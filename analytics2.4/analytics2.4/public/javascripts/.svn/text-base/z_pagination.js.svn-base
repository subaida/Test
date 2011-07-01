/*

*/

// JavaScript Document

// This code is a generic javascript for pagination

function zPagination(actn,url)
 {
	if (actn=='f')
	{
		var limit = 0;
		var offset = parseInt(document.getElementById('offset').value); 
	}
	else if (actn=='p')
	{
		var old_limit = parseInt(document.getElementById('limit').value);
		var offset = parseInt(document.getElementById('offset').value);
		var limit = (old_limit==0) ? 0 : ((offset > old_limit) ? 0 : (old_limit - offset));
	}
	else if (actn=='n')
	{
		var max_limit = parseInt(document.getElementById('max_limit').value);
		var old_limit = parseInt(document.getElementById('limit').value);
		var offset = parseInt(document.getElementById('offset').value);
		var limit = ((old_limit + offset) < max_limit) ? (old_limit + offset) : old_limit;			
	}
	else if (actn=='l')
	{
		var max_limit = parseInt(document.getElementById('max_limit').value);
		var offset = parseInt(document.getElementById('offset').value);
		var limit = max_limit - offset;			
	};
	var requestUrl = url+"&limit="+limit+"&offset="+offset;
	location.href = requestUrl;
 }