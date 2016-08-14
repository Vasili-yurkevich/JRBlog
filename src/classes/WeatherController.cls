public with sharing class WeatherController {
	private static String apiURL = 'http://api.openweathermap.org/data/2.5/';
	private static String apiKey = 'xxxx';
	private static String pathCurrentWeather = 'weather?appid='+apiKey+'&units=metric&q=';

  // Pass in the endpoint to be used using the string url
  private static String getCalloutResponseContents(String url) {
		String result = null;
    // Instantiate a new http object
    Http h = new Http();

     // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('GET');

    // Send the request, and return a response
    HttpResponse res = h.send(req);
		if(res.getStatusCode() == 200){
			result = res.getBody();
		}
    return result;
  }

	@AuraEnabled
	public static Object currentWeather(String city) {
		String weatherUrl = apiURL + pathCurrentWeather + city;
		System.debug('weatherUrl::' + weatherUrl);

		String result = getCalloutResponseContents(weatherUrl);
		System.debug('result::' + result);

		return (result == null)?null:getCalloutResponseContents(weatherUrl);
	}
}
