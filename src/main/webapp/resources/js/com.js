/*
===========================
 **************** 공통 JS
===========================
 */

const com = {};

com.comma = function(num) {
	
	let len, point, str;
	
	console.log(num);
	
	point = num.length % 3;
	len = num.length;
	str = num.substring(0, point);
	
	while(point < len) {
		if(str != "") str += ",";
		str += num.substring(point, point + 3);
		point += 3;
	}	
	
	return str;

};