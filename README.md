# TumbleLog
This is the code for TumbleLog, an app designed to track power tumbling training sessions, focusing on the difficulty level of each session.

## Usage
To get started with the project, follow these steps:

### Prerequisites
1. **Flutter Version Management (FVM):** Ensure you have [FVM](https://fvm.app/) installed for managing Flutter versions.
2. **Supabase Account:** Create a Supabase account and set up your database if you don’t have one.

### Steps
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/tumblelog.git
   cd tumblelog
   ```

2. **Set Up FVM:**
   Install the Flutter version specified in the `.fvm/fvm_config.json` file:
   ```bash
   fvm install
   fvm use
   ```

3. **Configure Environment Variables:**
   - Create a `.env` file in the root of the project.
   - Add your Supabase configuration details:
     ```env
     SUPABASE_URL=your-supabase-url
     SUPABASE_KEY=your-supabase-key
     ```

4. **Run the App:**
   Use FVM to run the app:
   ```bash
   fvm flutter pub get
   fvm flutter run
   ```

## Features
- **Skill Tracking:** Log skills performed in a training session.
- **Difficulty Calculation:** Automatically calculate total difficulty per session.
- **Session History:** View completed sessions and their details.

## Contributing
Contributions are welcome! If you have ideas for features or improvements, feel free to fork the repository and create a pull request.

1. Fork the repository.
2. Create your feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact
For any questions or suggestions, please contact [your-email@example.com].
