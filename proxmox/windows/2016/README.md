# Windows Server 2016

## Configuration

1. Enter your credentials for Proxmox in [proxmox-credentials.json](../../proxmox-credentials.json).
2. Edit the options in [vm-config.json](vm-config.json) to the desired values. Check out the packer documentation for the Proxmox ISO builder [here](https://developer.hashicorp.com/packer/plugins/builders/proxmox/iso) for possible values.
3. Add any scripts you want to run at the bottom of [windows-server-2016.json](windows-server-2016.json). By default, the template will:
   1. Install SSH
   2. Set the powerplan to high performance
   3. Enable RDP
   4. Configure WinRM and PS Remoting

## Build Command

### Validate the config

```
packer validate -var-file ..\..\credentials.json -var-file .\vm-config.json .\windows-server-2016.json
```

### Create the template

```
packer build -var-file ..\..\credentials.json -var-file .\vm-config.json .\windows-server-2016.json
 ```
