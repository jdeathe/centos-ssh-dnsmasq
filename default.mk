
# Common parameters of create and run targets
define DOCKER_CONTAINER_PARAMETERS
--name $(DOCKER_NAME) \
--restart $(DOCKER_RESTART_POLICY) \
--env "DNSMASQ_DNSCRYPT_PROXY=$(DNSMASQ_DNSCRYPT_PROXY)" \
--env "DNSMASQ_RESOLVER_1=$(DNSMASQ_RESOLVER_1)" \
--env "DNSMASQ_RESOLVER_2=$(DNSMASQ_RESOLVER_2)" \
--env "DNSMASQ_CONFIG=$(DNSMASQ_CONFIG)" \
--env "SSH_AUTOSTART_SSHD=$(SSH_AUTOSTART_SSHD)" \
--env "SSH_AUTOSTART_SSHD_BOOTSTRAP=$(SSH_AUTOSTART_SSHD_BOOTSTRAP)"
endef

DOCKER_PUBLISH := $(shell \
	if [[ $(DOCKER_PORT_MAP_TCP_53) != NULL ]]; then printf -- '--publish %s:53\n' $(DOCKER_PORT_MAP_TCP_53); fi; \
	if [[ $(DOCKER_PORT_MAP_UDP_53) != NULL ]]; then printf -- '--publish %s:53/udp\n' $(DOCKER_PORT_MAP_UDP_53); fi; \
	if [[ $(DOCKER_PORT_MAP_UDP_67) != NULL ]]; then printf -- '--publish %s:67/udp\n' $(DOCKER_PORT_MAP_UDP_67); fi; \
)
