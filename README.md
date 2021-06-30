# Weather
Simple weather with smooth UI and offline mode.

NOTE - Before using the app, do pod install 

# Design Pattern
Uses MVVM design pattern 

# Pods Used
Disk - Used to store the model for offline mode.

# Offline Usage
To give data presisitance, i have used coredata and disk. Used coredata to store the mandatory data like lat, long, cityname etc., Used Disk to store the model of the API response which will be return when there is any issue in network.

# Communication Patteren 
Used Protocol and delgate communication pattern to comunicate with each view controllers to update changes.

# Supported Version 
iOS 13.0 or greater

