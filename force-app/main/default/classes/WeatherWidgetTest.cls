@isTest
global with sharing class WeatherWidgetTest {
    
    @isTest 
    global static void getWeatherTest(){
        String cityName = 'Brest';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WeatherWidgetCalloutMock());
        WeatherWidget.WeatherData weather = WeatherWidget.getWeather(cityName);
        System.assertEquals(cityName, weather.name);
        Test.stopTest();
    }

    @isTest
    global static void getUserCityTest(){
        Test.startTest();
        String cityName = WeatherWidget.getUserCity();
        System.assert(cityName != null);
        Test.stopTest();
    }
}