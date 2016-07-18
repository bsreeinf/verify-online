$(document).on('turbolinks:load', function() {
	$(".update_verification_button").on('click',function(){
		currentDisplay = $(this).parent().parent().next("tr").css("display");
		if(currentDisplay == "none")
			$(this).closest("tr").next("tr").show();
		else
			$(this).closest("tr").next("tr").hide();
	});
	console.log("Initializing datepickers");
	// console.log($("#fromdate"));
	// console.log($("#todate"));
	$("#fromdate").datepicker();
	$("#todate").datepicker();

	Date.prototype.toDateInputValue = (function() {
	    var local = new Date(this);
	    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
	    return local.toJSON().slice(0,10);
	});

	$('#fromdate').attr("min", '2016-07-01');
	$('#todate').attr("min", '2016-07-01');
	$('#fromdate').attr("max", new Date().toDateInputValue());
	$('#todate').attr("max", new Date().toDateInputValue());
});