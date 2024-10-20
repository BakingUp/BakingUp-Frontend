# BakingUp-Frontend

Welcome to the BakingUp Frontend Repository!

## Technology Stacks
<b>Programming Languages:</b>
- Dart

<b>Development Tools:</b>
- <b>Mobile Application:</b> Flutter
- <b>3rd Party APIs:</b> Firebase Authentication, Firebase Cloud Messaging
- <b>CI/CD:</b> GitHub Actions

## Installation Guide
### 1. Clone the Repository
- For viewers on GitHub:
  
  ```bash
  git clone https://github.com/BakingUp/BakingUp-Frontend.git
  ```
- For viewers in CS GitLab:
  
  ```bash
  git clone https://csgit.sit.kmutt.ac.th/csc498-499-bakingup/bakingup-frontend.git
  ```
### 2. Install Necessary Packages
- Run the following command to install all required packages:
  
  ```bash
  flutter pub get
  ```
### 3. Setup Environment Variables
 - Create a .env file in the root directory of the project and add the following environment variables:
   
   ```env
   API_BASE_URL=https://{IP_ADDRESS}:8000
   ```
 - **Note:** Replace `{IP_ADDRESS}`, with your actual IP address, or use `localhost` for iOS, or `10.0.2.2` for Android.
### 4. Start the Application
 - Select an iOS or android device to start the simulator.
 - Run the application by choosing either `Start Debugging` or `Run Without Debugging` from your IDE.
