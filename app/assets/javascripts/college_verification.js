$(document).on('page:change', function() {
	$(".update_verification_button").on('click',function(){
		currentDisplay = $(this).parent().parent().next("tr").css("display");
		if(currentDisplay == "none")
			$(this).closest("tr").next("tr").show();
		else
			$(this).closest("tr").next("tr").hide();
	});

});