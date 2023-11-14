# Voting App

This repository contains the source code for the Voting App. The app allows users to vote on various options and view the results.

## Getting Started

Follow these steps to set up and run the Voting App:

### 1. Open the Code

```bash
# Clone the repository
git clone https://github.com/AB-Ynov/voting-app.git

# Change to the project directory
cd voting-app
```

### 2. Open in Codespace

Open the project in a GitHub Codespace by clicking the "Code" dropdown and selecting "Open with Codespaces." This provides a fully configured development environment.

### 3. Build Packer Image

Run the following command to build the Packer image:

```bash
packer build packer.json
```

### 4. Build Docker Image

Build the Docker image for the Voting App:

```bash
docker build -t abynov/voting-app:latest .
```

### 5. Push Docker Image

Push the Docker image to the Docker Hub repository:

```bash
docker push abynov/voting-app:latest
```

Now, the Voting App image is ready for deployment.

## Usage

After completing the setup, you can use the Docker image to deploy the Voting App in your preferred environment.

For more information on deploying and running the Voting App, refer to the documentation.

## Contributing

If you'd like to contribute to the development of the Voting App, please follow our [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).
