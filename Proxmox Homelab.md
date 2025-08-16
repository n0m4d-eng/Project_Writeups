I started looking into building a homelab to get into cyber security. This seemed like a good project to have in the long term, and also a decent portfolio piece.

# Equipment

What I have on hand is an old laptop. A late 2019 razer blade stealth with an Intel CPU that I'd repurposed into a dedicated CTF playing machine running Ubuntu, with containers for Kali, Bloodhound and other things. This helped me learn how to set up docker, images and forward ports among other things. Now that the battery was shot and some keys weren't working as they should, it was the ideal machine to build my proxmox homelab with.

This machine had 16GB of RAM, and a 512GB hard drive. This should be enough of a starting point to run some Vulnhub VMs. I don't know how this will hold up against an Active Directory lab. But I'm going to try anyway.

I also need a dongle with an ethernet jack to connect to my home router.

# Prepping the Laptop

## Getting Proxmox

This part was fairly straightforward. I go to Proxmox's [website](https://www.proxmox.com/en/downloads) and download the ISO installer.

![](assets/Pasted%20image%2020250713155320.png)

## Flashing it

The next part required the use of [Balena Etcher](https://etcher.balena.io/). I downloaded and installed it on my system. Then I had to create a live bootable disk with Proxmox on it, using a thumbdrive. 

--WIP-- 
Images
## Installing

The next part consisted of booting up the laptop into its BIOS, and choosing to boot from the USB drive. After which I install Proxmox.

# Notes

## Type 1 Hypervisors

- A hypervisor that is installed directly on the disk, obliterating whatever OS you had before. Has direct access to your machine's hardware, and all it does is deal with virtual machines, unlike a **Type 2 Hypervisor** which operates alongside your existing OS, with a layer of isolation from the hardware

# Future Plans

# Resources

- https://www.youtube.com/watch?v=_u8qTN3cCnQ
- https://benheater.com/proxmox-laptop-cybersecurity-lab/
- https://hackmd.io/RmB8dTZ-RbqSScQ8ILFmdQ?view
- https://loghunter.substack.com/p/ultimate-cyber-security-home-lab?utm_campaign=post&utm_medium=web
