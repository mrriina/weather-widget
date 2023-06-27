@isTest
global class WeatherWidgetCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"coord":{"lon":23.7,"lat":52.1},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":4.78,"feels_like":0.7,"temp_min":4.78,"temp_max":4.78,"pressure":1026,"humidity":60,"sea_level":1026,"grnd_level":1009},"visibility":10000,"wind":{"speed":5.79,"deg":17,"gust":10.1},"clouds":{"all":73},"dt":1650127663,"sys":{"country":"BY","sunrise":1650079582,"sunset":1650129797},"timezone":10800,"id":629634,"name":"Brest","cod":200}');
        res.setStatusCode(200);
        return res;
    }
}