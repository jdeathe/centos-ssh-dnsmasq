# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
DOCKER_USER := jdeathe
DOCKER_IMAGE_NAME := centos-ssh-dnsmasq
SHPEC_ROOT := test/shpec

# Tag validation patterns
DOCKER_IMAGE_TAG_PATTERN := ^(latest|1\.[0-9]+\.[0-9]+)$
DOCKER_IMAGE_RELEASE_TAG_PATTERN := ^1\.[0-9]+\.[0-9]+$

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

# Docker image/container settings
DOCKER_CONTAINER_OPTS ?=
DOCKER_IMAGE_TAG ?= latest
DOCKER_NAME ?= dnsmasq.pool-1.1.1
DOCKER_PORT_MAP_TCP_22 ?= NULL
DOCKER_PORT_MAP_TCP_53 ?= 53
DOCKER_PORT_MAP_UDP_53 ?= 53
DOCKER_PORT_MAP_UDP_67 ?= NULL
DOCKER_RESTART_POLICY ?= always

# Docker build --no-cache parameter
NO_CACHE ?= false

# Directory path for release packages
DIST_PATH ?= ./dist

# Number of seconds expected to complete container startup including bootstrap.
STARTUP_TIME ?= 2

# ------------------------------------------------------------------------------
# Application container configuration
# ------------------------------------------------------------------------------
SSH_AUTHORIZED_KEYS ?=
SSH_AUTOSTART_SSHD ?= false
SSH_AUTOSTART_SSHD_BOOTSTRAP ?= false
SSH_CHROOT_DIRECTORY ?= %h
SSH_INHERIT_ENVIRONMENT ?= false
SSH_SUDO ?= ALL=(ALL) ALL
SSH_USER ?= app-admin
SSH_USER_FORCE_SFTP ?= false
SSH_USER_HOME ?= /home/%u
SSH_USER_ID ?= 500:500
SSH_USER_PASSWORD ?=
SSH_USER_PASSWORD_HASHED ?= false
SSH_USER_SHELL ?= /bin/bash
# ------------------------------------------------------------------------------
DNSMASQ_DNSCRYPT_PROXY ?= false
DNSMASQ_RESOLVER_1 ?= 8.8.8.8
DNSMASQ_RESOLVER_2 ?= 8.8.4.4
DNSMASQ_CONFIG ?= /etc/dnsmasq.d/dnsmasq.conf
