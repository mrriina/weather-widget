import { LightningElement, track, wire } from 'lwc';
import getWeather from '@salesforce/apex/WeatherWidget.getWeather';
import getUserCity from '@salesforce/apex/WeatherWidget.getUserCity';

export default class WeatherWidget extends LightningElement {
    @track cityName;
    weather = [];
    localTime;

    @wire(getUserCity)
    wr1({ error, data }){
        if(data) {
            this.cityName = data;
        }
    }

    @wire(getWeather, {cityName: '$cityName'})
    wr2({ error, data }){
        if(data) {
            this.weather = data;
            this.path = 'https://openweathermap.org/img/w/' + this.weather.weatherIcon + '.png';
            this.localTime = (new Date(this.weather.dt*1000)).toUTCString();
        }
    }

    handleOnChangeCityName(event){
        this.cityName = event.target.value;
    }
}