# Azure Functions with Dart

Run Dart in Azure Functions as a custom handler.

## Quickstart

This repo comes with a devcontainer with the Azure Functions tooling and Dart SDK. You can use it locally by running the VS Code Remote Containers extension, or by forking this repo and opening it in GitHub Codespaces.

It's recommended that you use this devcontainer, as it allows you to develop and build your Dart app in a Linux environment. You can take the same binary and deploy it directly to an Azure Functions Linux consumption plan.

### Run it locally

1. Fork this repo in GitHub.

1. In the forked repo's homepage, click the *Code* dropdown.

    * Select *Open in Codespaces*
    * Then click *+ New Codespace* to start a Codespace

    It might take a few minutes for the Codespace to start.

1. When the Codespace opens, open a terminal (<kbd>Ctrl+`</kbd>) and check that Dart and Azure Functions Core Tools are installed.

    ```bash
    dart --version
    func --version
    ```

1. Run the function app:

    ```bash
    func start
    ```

    This also starts the Dart custom handler at `handler/bin/handler.dart`.

1. 

### Deploy to Azure

1. Build the app for production:

    ```bash
    mkdir -p handler/build
    dart compile exe -o handler/build/handler handler/bin/handler.dart
    ```
