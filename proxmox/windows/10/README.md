# Windows 10 22H2 Enterprise

## Configuration

1. Enter your credentials for Proxmox in [proxmox-credentials.json](../../proxmox-credentials.json).
2. Edit the options in [vm-config.json](vm-config.json) to the desired values. Check out the packer documentation for the Proxmox ISO builder [here](https://developer.hashicorp.com/packer/plugins/builders/proxmox/iso) for possible values.
3. Add any scripts you want to run at the bottom of [windows-10-22h2-enterprise.json](windows-10-22h2-enterprise.json). 

By default, the template will:
- Install SSH
- Set the powerplan to high performance
- Enable RDP
- Configure WinRM and PS Remoting

## Build Command

### Validate the config

```
packer validate -var-file ..\..\proxmox-credentials.json -var-file .\vm-config.json .\windows-10-22h2-enterprise.json
```

### Create the template

```
packer build -var-file ..\..\proxmox-credentials.json -var-file .\vm-config.json .\windows-10-22h2-enterprise.json
 ```
