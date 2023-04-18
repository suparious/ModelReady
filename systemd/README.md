## Oobabooga systemd service

copy the ooba.service.example file to `/etc/systemd/system/ooba.service` and edit the `ExecStart` line to point to the correct path of the ooba executable. Also look at the Environment variables and change them to your liking.

```bash
sudo cp ooba.service.example /etc/systemd/system/ooba.service
sudo nano /etc/systemd/system/ooba.service
```

Then enable and start it with:

```bash
sudo systemctl daemon-reload
sudo systemctl enable ooba.service
sudo systemctl start ooba.service
```

Check the running status with:

```bash
sudo systemctl status ooba.service
```

To view the logs:

```bash
sudo journalctl -u ooba.service -f
```