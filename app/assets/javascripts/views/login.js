$(document).ready(function () {
	// Conditional Execution of Page-Specific JavaScript
	if($("form#new_user").length){
		// Validation rules
		$("form#new_user").validate({
			rules: {
				"user[password]": {required: true, minlength: 6},

			}
		});

	}
});