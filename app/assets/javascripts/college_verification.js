$(document).on('turbolinks:load', function() {
	$(".update_verification_button").on('click',function(){
		currentDisplay = $(this).parent().parent().next("tr").css("display");
		if(currentDisplay == "none")
			$(this).closest("tr").next("tr").show();
		else
			$(this).closest("tr").next("tr").hide();
	});
	console.log("Initializing datepickers");
	console.log($("#fromdate"));
	console.log($("#todate"));
	$("#fromdate").datepicker();
	$("#todate").datepicker();
});