## Oobabooga systemd service

put it in `/etc/systemd/system/ooba.service`

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
