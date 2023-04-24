# Launcher Scripts for Data Science Toolkit

This README provides instructions on how to use the launcher scripts for the Data Science Toolkit. These scripts work in conjunction with the [installers](../installers/README.md) to launch the installed software.

The launcher scripts are designed to be run using environment variables set by either the [systemd service](../systemd/README.md) files, the running shell, or from the command-line. It is not recommended to modify the default variables contained in these files directly.

## Systemd Service Usage

If you have already run the installer and reviewed the `/etc/systemd/system/<name_of_service>.service` file, follow these steps to start the service using systemd:

```bash
sudo systemctl daemon-reload
sudo systemctl start <name_of_service>.service
sudo systemctl enable <name_of_service>.service
```

Refer to the [Systemd Service README](../systemd/README.md) for more detailed instructions on installing and configuring the systemd service.

## Manual Usage (for testing or development)

To manually run the launcher script for testing or development purposes (without using the systemd service), follow these steps:

1. Ensure that you have run the installer for the desired data science tool.

2. Set the environment variables as needed, based on your requirements and understanding of the default values.

3. Run the launcher script:

   ```bash
   cd launchers
   bash <name_of_service>.sh
   ```

This method allows you to manually launch the data science tools without relying on the systemd service.