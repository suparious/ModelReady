# Data Science Toolkit Systemd Service

This README provides instructions on how to install and configure the systemd service for the Data Science Toolkit.

## Automatic Installation

To automatically install the systemd service for your chosen tool, run the corresponding installer script located in the `../installers/` directory:

```bash
../installers/<name_of_service>.sh
```

Replace `<name_of_service>` with the name of the specific data science tool you are installing.

## Manual Installation

If you prefer to install the systemd service manually, follow these steps:

1. Copy the example service file to the systemd system directory:

   ```bash
   sudo cp <name_of_service>.service.example /etc/systemd/system/<name_of_service>.service
   ```

2. Edit the `/etc/systemd/system/<name_of_service>.service` file to update the `ExecStart` line with the correct path to the executable of the chosen data science tool.

3. Review the environment variables in the service file and adjust them as necessary to match your requirements.

## Configuration

To configure the service's environment variables and launch parameters, edit the service file:

```bash
sudo nano /etc/systemd/system/<name_of_service>.service
```

## Service Management

To enable and start the systemd service, run the following commands:

```bash
sudo systemctl daemon-reload
sudo systemctl enable <name_of_service>.service
sudo systemctl start <name_of_service>.service
```

You can check the running status of the service with:

```bash
sudo systemctl status <name_of_service>.service
```

To view the logs of the service, use:

```bash
sudo journalctl -u <name_of_service>.service -f
```

For more information on using and managing systemd services, consult the official systemd documentation.