#  Heroes Database

iOS Showcase Application using the [Marvel API](https://developer.marvel.com) for listing and favoriting characters.

![Picture1](https://github.com/user-attachments/assets/9953bfbb-6599-4f9c-b55b-1351c28ddb2f)

##  📱 Running the App

1. Download this repository and open it in Xcode.
2. Obtain both your public and private keys for the MarvelAPI by accessing the Developer Portal (follow the instructions on the [Marvel API](https://developer.marvel.com) Page).
3. Open the AppSecrets.plist file inside the Infrastructure folder of the project and add both keys. (🚨 Do not push your private key to any public repositories.)
4. Build and run the application.

## 💼 Project Details

* The minimum target version is iOS 16 and Swift 5
* Built and tested using Xcode 15.4
* The project uses SPM for its dependencies.

* This project was implemented using the MVVM architectural pattern.
  - The Model layer contains any necessary data or business logic required to retrieve all the characters and their information. It's organization is as it follows:
    
    - Infrastructure: Contains the core implementations for the app
    - Network: Handles the API Calls generically
    - Service: Handles the specifics for the API Calls
    - Data: Has all information regarding data gathering
      
      - Model: Contains all the internal models
      - Entity: Contains all the database models
      - Repository: Handles all the data gathering, remote or local. Everything is centralized here

  - ViewModels handle all interactions and update the view with the requested information.     
  - Views were built using SwiftUI and are responsible for displaying all the data to the user.
 
### Implemented Features:
- [x] List of Characters
- [x] Search by Name
- [x] Character Details
- [x] Favorite characters
- [x] Image Sharing
- [x] Error/Empty Views
- [x] Unit Testing
- [x] UI Testing

## 📝 Notes
* The whole project was developed only using the main branch. GitFlow was not applied in order to keep it simple.
* The Favorites feature was built using Realm database. This was chosen istead of SwiftData due to previous familiarity.
* On the Favorites page, when you unfavorite a character, it still shows on the list and it is updated when you go back to the screen. This was a design choice, in order to enable the user to favorite it back, in case of a misclick.
  
  - Due to this, a pull to refresh funcionality was implemented. Also, the component for the CharacterListItem is prepared to recieve a performAfterAction() closure, where we could just tell the page to reload, if that sounds like a better experience.
    
* We have a Singleton in place for instantiating the core classes. In a production application, this would be injected.
* Previews are enabled and working
* The layout/visual identity was designed for this project by me
* Reusable components were built and used where applicable
* Magic Numbers were left in the Views, due to time constraints and the limited scope of this application
* I thought about implementing SwiftLint (as the package is listed in the dependencies), but this was cut due to time constraints
* The AppSecretsTests will fail if you try to execute it with your API Key in the AppSecrets. This was also by design, in order to prevent the commit of secret keys.
* UI Testing was fulfilled using SnapshotTesting, but it's placed in the Unit Tests suite, since we're not testing navigation.
* ChatGPT was heavily used as a debugging and factory tool. Its most extensive application were for generating boilerplate code and UI/Unit Tests, reviewed and adjusted by me where needed.
