# Sound Place

An application to handle a user library of songs and videos retrieved from Spotify and Youtube.

## Prerequisites

If you're a **Linux** user, follow the steps bellow:

1. install [Docker for Linux][docker-linux].

If you're a **macOS** user, follow the steps bellow:

1. install [Docker for macOS][docker-macos];
2. install [VirtualBox][virtual-box];
3. install [Docker Machine][docker-machine];
4. run `docker-machine create default --driver virtualbox --virtualbox-memory "3072"`
5. you will need to `eval $(docker-machine env)` everytime, so you can configure that in the `.zshrc` or `.bashrc`;
6. install [NFS for Docker Machine][docker-machine-nfs] and follow its installation instructions.


If you're a **Windows** user, follow the steps bellow:

1. install [Docker for Windows][docker-windows];
2. install [VirtualBox][virtual-box];
3. install [Docker Machine][docker-machine];
4. run `docker-machine create default --driver virtualbox --virtualbox-memory "3072"`
5. you will need to `eval $(docker-machine env)` everytime, so you can configure that in the `.zshrc` or `.bashrc`;

## Set up GitHub

1. Make sure your SSH key is configured to your GitHub account;
2. If **not**, [follow this tutorial][gh-generating-ssh-keys].

## Starting locally

**Attention**

Some steps bellow does not apply to **Linux** or **Windows** users:

❌ Linux and Windows: 5 step

1. clone the repository: `git clone git@github.com:lucasmedeirosleite/sound_place.git`
2. `cd sound_place`
3. `cp .env.sample .env`
4. `docker-machine start`
5. activate NFS: `docker-machine-nfs default`
6. check your virtual machine ip with `docker-machine ip`. Copy it to accomplish the next step
13. open `/etc/hosts` and add a line with `#{the ip from previous step} dev`
14. `docker-compose up`
15. Sound Place is available at `http://dev:4000` or at `localhost://4000` for Linux users

## Deploy

- [ ] TODO: [Check phoenix deployment guides](http://www.phoenixframework.org/docs/deployment).

[docker-linux]: https://docker.github.io/engine/installation/
[docker-macos]: https://docs.docker.com/docker-for-mac/
[docker-windows]: https://docs.docker.com/docker-for-windows/

[virtual-box]: https://www.virtualbox.org/wiki/Downloads

[docker-machine]: https://docs.docker.com/machine/install-machine/
[docker-machine-nfs]: https://github.com/adlogix/docker-machine-nfs

[gh-generating-ssh-keys]: https://help.github.com/articles/generating-ssh-keys/
