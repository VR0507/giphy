# Giphy App with Login/Signup and Favorites

## Overview
This Flutter application allows users to search and view GIFs using the Giphy API. It also includes a user authentication system, enabling users to log in, sign up, and save their favorite GIFs.

## Features
1. **Search and Trending GIFs:**
   - Search bar for typing search terms.
   - Displays trending GIFs when the search bar is empty.
   
2. **Search Results:**
   - Dynamically updates search results as the user types.
   - Implements pagination or infinite scroll for seamless browsing.

3. **User Authentication:**
   - Login and Signup screens for user authentication.
   - Secure user account management via Firebase Authentication.

4. **Favorites Feature:**
   - Allows authenticated users to save their favorite GIFs.
   - Dedicated section to view favorite GIFs.

## App Requirements
- **Flutter SDK**: Version 3.2 or higher.
- **Dart SDK**: Version 3.4 or higher.
- **Firebase Authentication**: For managing user accounts.
- **Giphy API**: For fetching GIF data.
## Workflow Video


## Installation

### Prerequisites
- Ensure you have Flutter installed. If not, follow the [official installation guide](https://flutter.dev/docs/get-started/install).
- Set up Firebase for the project. You can refer to [Firebase setup documentation](https://firebase.google.com/docs/flutter/setup) to add Firebase to your Flutter project.
- Obtain a Giphy API key by signing up at the [Giphy Developers Portal](https://developers.giphy.com/).

### Steps to Run the App
1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/giphy-app.git
   cd giphy-app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Follow the Firebase setup guide to add Firebase to your Flutter app.
   - Replace the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the project with your Firebase configuration files.

4. **Set up Giphy API:**
   - Add your Giphy API key to the app. This can be done by configuring the API key in a `.env` file or directly in the code (not recommended for production).

5. **Run the App:**
   ```bash
   flutter run
   ```

## Tech Stack
- **Flutter**: UI toolkit for building natively compiled applications.
- **Firebase Authentication**: For secure user authentication and management.
- **Giphy API**: To fetch and display GIFs based on user search or trending data.

## Code Structure
- `lib/`: Contains the main Flutter code.
  - `screens/`: Holds the different screens (e.g., login, signup, search, favorites).
  - `widgets/`: Custom widgets used throughout the app.
  - `services/`: Services for handling Firebase Authentication and Giphy API interactions.
  - `models/`: Data models representing the GIFs and user data.
  - `controllers/`: GetX controllers for state management.
  
- `assets/`: Store static assets like images or fonts.
- `test/`: Unit and widget tests for ensuring code quality.

## Future Enhancements
- **Dark Mode**: Implement a dark theme for better user experience in low-light environments.
- **Social Sharing**: Allow users to share GIFs on social media platforms directly from the app.
- **Improved Pagination**: Optimize the infinite scroll/pagination for large datasets.

## Contributions
Feel free to submit issues or pull requests. Contributions to enhance the app or fix bugs are always welcome!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

