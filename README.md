# dcos-terraform-digitalocean
Terraform scripts for digitalocean.com, based on [packet-terraform](https://github.com/mesosphere/packet-terraform)

### This repo holds [Terraform](https://www.terraform.io/) scripts to create a
1, 3, or 5 master DCOS cluster on the [digitalocean.com](https://digitalocean.com/)
provider.

##### To use:

Clone or download repo: https://github.com/guydavis/dcos-terraform-digitalocean

Generate a DO Personal Access Token for Terraform and export in your shell as DO_PAT. 
https://cloud.digitalocean.com/settings/api/tokens

Generate a `do-key` keypair (with an empty passphrase):

```bash
ssh-keygen -t rsa -P '' -f ./do-key
```

Copy `sample.terraform.tfvars` to `terraform.tfvars` and insert your variables including SSH key fingerprint and DO access token.

By default, this will start four droplets (bootstrap, master, agent, and public agent).  Increase *_count settings in terraform.tvars to try with more droplets. NOTE: You may need to increase your droplet limit to 10 on the
[Digital Ocean profile page](https://cloud.digitalocean.com/settings/profile#).

Check `terraform plan`
Run `terraform apply`

##### Theory of Operation:

This script will start the infrastructure machines (bootstrap and masters),
then collect their IPs to build an installer package on the bootstrap machine
with a static master list. All masters wait for an installation script to be
generated on the localhost, then receive that script. This script, in turn,
pings the bootstrap machine whilst waiting for the web server to come online
and serve the install script itself.

When the install script is generated, the bootstrap completes and un-blocks
the cadre of agent nodes, which are  cut loose to provision metal and
eventually install software.
