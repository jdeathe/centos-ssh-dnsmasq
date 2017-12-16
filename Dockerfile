# =============================================================================
# jdeathe/centos-ssh-dnsmasq
# =============================================================================
FROM jdeathe/centos-ssh:2.3.0

# -----------------------------------------------------------------------------
# Install Dnsmasq and DNSCrypt Proxy
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
	&& yum -y install \
			--setopt=tsflags=nodocs \
			--disableplugin=fastestmirror \
		bind-utils \
		dnscrypt-proxy \
		dnsmasq \
	&& yum clean all \
	&& curl -Lso \
		/usr/share/dnscrypt-proxy/dnscrypt-resolvers.csv \
		https://download.dnscrypt.org/dnscrypt-proxy/dnscrypt-resolvers.csv

# -----------------------------------------------------------------------------
# Copy files into place
# -----------------------------------------------------------------------------
ADD src/usr/sbin \
	/usr/sbin/
ADD src/etc/services-config/dnsmasq \
	/etc/services-config/dnsmasq/
ADD src/etc/services-config/dnsmasq.d \
	/etc/services-config/dnsmasq.d/
ADD src/etc/services-config/supervisor/supervisord.d \
	/etc/services-config/supervisor/supervisord.d/

RUN ln -sf \
		/etc/services-config/dnsmasq/dnsmasq-bootstrap.conf \
		/etc/dnsmasq-bootstrap.conf \
	&& ln -sf \
		/etc/services-config/dnsmasq.d/dnsmasq.conf \
		/etc/dnsmasq.d/dnsmasq.conf \
	&& ln -sf \
		/etc/services-config/supervisor/supervisord.d/dnscrypt-proxy-wrapper.conf \
		/etc/supervisord.d/dnscrypt-proxy-wrapper.conf \
	&& ln -sf \
		/etc/services-config/supervisor/supervisord.d/dnsmasq-wrapper.conf \
		/etc/supervisord.d/dnsmasq-wrapper.conf \
	&& ln -sf \
		/etc/services-config/supervisor/supervisord.d/dnsmasq-bootstrap.conf \
		/etc/supervisord.d/dnsmasq-bootstrap.conf \
	&& chmod 600 \
		/etc/services-config/dnsmasq.d/dnsmasq.conf \
	&& chmod 600 \
		/etc/services-config/supervisor/supervisord.d/{dnscrypt-proxy-wrapper,dnsmasq-bootstrap,dnsmasq-wrapper}.conf \
	&& chmod 700 \
		/usr/sbin/{dnscrypt-proxy-wrapper,dnsmasq-bootstrap,dnsmasq-wrapper}

EXPOSE 53 67

# -----------------------------------------------------------------------------
# Set default environment variables
# -----------------------------------------------------------------------------
ENV DNSMASQ_DNSCRYPT_PROXY=false \
	DNSMASQ_RESOLVER_1="8.8.8.8" \
	DNSMASQ_RESOLVER_2="8.8.4.4" \
	DNSMASQ_CONFIG="/etc/dnsmasq.d/dnsmasq.conf" \
	SSH_AUTOSTART_SSHD=false \
	SSH_AUTOSTART_SSHD_BOOTSTRAP=false

# -----------------------------------------------------------------------------
# Set image metadata
# -----------------------------------------------------------------------------
LABEL \
	maintainer="James Deathe <james.deathe@gmail.com>"

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]