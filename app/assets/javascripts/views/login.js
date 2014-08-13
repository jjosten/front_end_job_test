// override jquery validate plugin defaults
$.validator.setDefaults({
    highlight: function(element) {
        $(element).closest('.input-group').addClass('field_with_errors');
    },
    unhighlight: function(element) {
        $(element).closest('.input-group').removeClass('field_with_errors');
    },
    errorElement: 'span',
    errorClass: 'has-error',
    errorPlacement: function(error, element) {
        if(element.parent('.input-group').length) {
            error.insertAfter(element.parent());
        } else {
            error.insertAfter(element);
        }
    }
});

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