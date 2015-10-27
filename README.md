This repository contain some script to create, build, tag, and push a Debian image for docker for armv7.
The scripts work and are tested under Arch Linux for arm.
They simple create a build environment, build a debian Jessie image for armv7, tag the image with the date and the latest image with the tag “latest” and pull the images to docker hub.

Simple download the repository, run setup.sh located in setup and run then build-debian-jessie-image.sh located in debian-jessie.
