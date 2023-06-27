global with sharing class WeatherWidget {
    static String callUrl = 'https://api.openweathermap.org/data/2.5/weather?q=';
    static String apiKey = '6b6d9a4a80d494407a589a5a421e3745';

    global class WeatherData {
        @AuraEnabled public String timezone;
        @AuraEnabled public String name;
        @AuraEnabled public String weatherDescription;
        @AuraEnabled public String weatherIcon;
        @AuraEnabled public String country;
        @AuraEnabled public Decimal temp;
        @AuraEnabled public Decimal humidity;
        @AuraEnabled public Decimal windSpeed;
        @AuraEnabled public Decimal visibility;
        @AuraEnabled public Decimal pressure;
        @AuraEnabled public Decimal dt;
    }

    @AuraEnabled (cacheable=true)
    global static WeatherData getWeather(String cityName){
        String url = callUrl + cityName + '&appid=' + apiKey + '&units=metric';

        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET'); 
        req.setEndpoint(url);  
        try {
            HTTPResponse res = http.send(req);
            JSONParser parser = JSON.createParser(res.getBody());

            WeatherData weather = new WeatherData();
            while (parser.nextToken() != null){
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                    parser.nextValue();
                    if (parser.getCurrentName() == 'timezone') {
                        weather.timezone = parser.getText();
                    } else if (parser.getCurrentName() == 'name') {
                        weather.name = parser.getText();
                    } else if (parser.getCurrentName() == 'description') {
                        weather.weatherDescription = parser.getText();
                    } else if (parser.getCurrentName() == 'icon') {
                        weather.weatherIcon = parser.getText();
                    } else if (parser.getCurrentName() == 'temp') {
                        weather.temp = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'humidity') {
                        weather.humidity = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'speed') {
                        weather.windSpeed = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'visibility') {
                        weather.visibility = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'pressure') {
                        weather.pressure = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'dt') {
                        weather.dt = Decimal.valueOf(parser.getText());
                    } else if (parser.getCurrentName() == 'country') {
                        weather.country = parser.getText();
                    }
                }
            }
            return weather; 

        } catch(Exception ex){
            System.debug('{"error": "' + ex.getMessage() + '"}');
            return null;
        }
    }


    @AuraEnabled (cacheable=true)
    global static String getUserCity(){
        User usr = [SELECT City
                    FROM User
                    WHERE Id =: UserInfo.getUserId()];
        
        if(usr.City != null){
            return usr.City;
        }
        
        CityForWeatherWidget__mdt city = CityForWeatherWidget__mdt.getInstance('DefaultCity');
        return city.City_Name__c;
    }
}