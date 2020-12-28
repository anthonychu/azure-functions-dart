# Azure Functions with Dart

Run Dart in Azure Functions as a custom handler.

## Quickstart

This repo comes with a devcontainer with the Azure Functions tooling and Dart SDK. You can use it locally by running the VS Code Remote Containers extension, or by forking this repo and opening it in GitHub Codespaces.

It's recommended that you use this devcontainer, as it allows you to develop and build your Dart app in a Linux environment. You can take the same binary and deploy it directly to an Azure Functions Linux consumption plan.

### Run it locally

> This should work in GitHub Codespaces as well, although I've had some trouble today.

1. Clone this repo from GitHub.

1. Make sure you have the VS Code with the [Remote Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed and Docker is running on your machine.

1. In the VS Code command pallete (<kbd>F1</kbd>), run the *Remote Containers: Reopen folder in container* command. VS Code will reopen in the development environment running in a Docker container.

1. Open a terminal in VS Code (<kbd>Ctrl+`</kbd>). Ensure Dart and Azure Functions Core Tools are installed. 

    ```bash
    dart --version
    func --version
    ```

1. Run the function app:

    ```bash
    func start
    ```

    This also starts the Dart custom handler at `handler/bin/handler.dart`.

1. With the function app still running, open it in a browser. Run the *Open port in browser* command. Select `7071`. A browser should open to the root of the function app.

1. Append `/api/hello` to the URL to hit one of the functions in the Dart custom handler.

### Deploy to Azure

1. Build the app for production:

    ```bash
    mkdir -p handler/build
    dart compile exe -o handler/build/handler handler/bin/handler.dart
    ```

1. In the VS Code command palette, run the *Azure Functions: Deploy to Function App...* command. Fill in the following info:

    - **Subscription** - choose your subscription
    - **Create new Function App in Azure (advanced)** - make sure you choose **advanced** to be able to select Linux later.
    - **Runtime stack** - select **Custom Handler**
    - **Select an OS** - select **Linux**
    - For the rest of the options, take the defaults.

1. When the app is deployed, the URL should be displayed in the output.

## How this works

In the *handler* folder is a Dart custom handler app. A custom handler is a process that can respond to HTTP requests.

*host.json* tells the Azure Functions host to start the compiled binary as a custom handler. When running locally, these settings are overridden in *local.settings.json* to start the handler without explicity compilation and allows a debugger to attach.

There's a single function defined in the *default* folder. It's an HTTP function that forwards all requests to `/api/*` to the custom handler. You can add other functions with other trigger types, but this is currently not covered in this sample.
