# Stormy_iOS
The iOS version of the Stormy app from Team Treehouse

This is the iOS version of the Stormy app, a weather forecast app that is the basis for the [Build a Weather App WIth Swift](https://teamtreehouse.com/library/build-a-weather-app-with-swift-2) and [Enhance a Weather App With Table Views](https://teamtreehouse.com/library/enhance-a-weather-app-with-table-views) courses on Treehouse.

List of updates made to the final version of the app after taking the Treehouse courses:
+ Added CoreLocation to get real locations to pull weather data for
+ Used the ```CLGeocoder``` class to pull the location name from the real-time coordinates
+ Made the custom background views ```IBDesignable``` to be able to see the custom backgrounds right in Interface Builder
+ Created a Today extension for the app that shows location, temperature, weather summary, and weather icon right in Notification Center
+ In order to get that working, I had to move the weather model code to a new separate framework that could be shared between the app and the extension
