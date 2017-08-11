/**
 * 
 */
$(function() {
	window.history.forward();
	function noBack() { 
		window.history.forward();
	}
});

$('th').css('background-color', '#f2f2f2');

//common method for alert messages
(function($){
	$.fn.close = function() {
		var a = $(this).attr('title');
		$('#'+a).click(function(){
			$('#msgBlock').hide();
		});
	}
})(jQuery);