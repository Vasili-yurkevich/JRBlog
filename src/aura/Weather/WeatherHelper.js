({
	getCurrentWeather : function(component, helper, city) {
		var action = component.get('c.currentWeather');
		action.setParams({"city": city});
		action.setCallback(this, function(response) {
			var state = response.getState();

			if (state === "SUCCESS") {
				var result = response.getReturnValue();
				if(result != null){
					result = JSON.parse(result);
					component.set('v.weather', result);
				}else{
					helper.message('Error!', 'error', 'Some error occured while getting weather data');
				}
			}else if (state === "INCOMPLETE") {
			}else if (state === "ERROR") {
				var errors = response.getError();
				if (errors) {
					if (errors[0] && errors[0].message) {
							helper.message('Error!', 'error', errors[0].message);
					}
				} else {
					helper.message('Error!', 'error', 'Unknown Error');
				}
			}
		});
		$A.enqueueAction(action);
	},
	message: function(title, severity, message){
		var ele = component.find('message').getElement();
		$A.util.removeClass(ele, 'slds-hide');
		$A.util.addClass(ele, 'slds-show');
	}
})
