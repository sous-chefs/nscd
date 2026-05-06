# Limitations

## Package Availability

`nscd` is distributed by operating system package repositories as part of, or alongside, glibc.
This cookbook does not configure third-party package repositories or build nscd from source.

### APT (Debian/Ubuntu)

* Ubuntu 22.04 and 24.04 provide `nscd` packages from the Ubuntu archive for common server architectures including amd64 and arm64.
* Debian 12 and 13 provide `nscd` packages from the Debian archive for common server architectures including amd64 and arm64.
* Older Debian and Ubuntu releases have been removed from the test matrix because they are EOL under normal distribution support.

### DNF/YUM (RHEL family)

* Red Hat Enterprise Linux 8 and 9 provide `nscd` packages.
* AlmaLinux 8 and 9, Rocky Linux 8 and 9, Oracle Linux 8 and 9, CentOS Stream 9, Amazon Linux 2, and Amazon Linux 2023 are supported as compatible RHEL-family package platforms.
* Fedora is not supported because Fedora removed the glibc `nscd` subpackage after Fedora 34.

### Zypper (SUSE)

* openSUSE Leap is not supported by this cookbook's current matrix. Leap 15.6 is EOL as of April 30, 2026, and the current Leap 16.0 line does not publish an official `nscd` package.

## Architecture Limitations

* The cookbook uses the platform package manager and inherits the architecture coverage of each distribution's native repositories.
* The Kitchen and CI baseline validate x86_64 container images.

## Source/Compiled Installation

Source installation is not supported. Use distribution packages or manage custom builds outside this cookbook before using `manage_package false`.

## Known Issues

* `netgroup` caching remains disabled by default because it has historically been unreliable on some distributions.
* `nscd` is deprecated or unavailable on some newer distribution families. Use SSSD or systemd-resolved where those platforms have replaced `nscd` for the caching use case.
