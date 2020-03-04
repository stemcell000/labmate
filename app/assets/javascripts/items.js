function disableFormInputs(c){
	    $('.form-control').prop("readonly", c);
	    $('.select').prop("disabled", c);
	    $('.select2-select').prop("disabled", c);
	    {console.log("form disabled");}
}