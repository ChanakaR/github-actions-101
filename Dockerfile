
FROM centos/systemd
LABEL authors = "OrangeHRM TechOps <techops@orangehrm.com>"

WORKDIR /var/www/html

# -----------------------------------------------------------------------------
# Adding IUS repository and MariaDB GPG Keys
# -----------------------------------------------------------------------------

RUN yum install -y epel-release https://repo.ius.io/ius-release-el$(rpm -E '%{rhel}').rpm \
        && rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB

COPY ./repos/mariadb.repo /etc/yum.repos.d/

# Install Font group
RUN yum -y groupinstall "Font"

# -----------------------------------------------------------------------------
# Install Middlewares and modules
# -----------------------------------------------------------------------------

RUN yum -y install \
    httpd \
    gcc \
    MariaDB-client \
    libaio-devel \
    poppler-utils \
    supervisor \
    libreoffice-draw \
    libreoffice-writer \
    libmcrypt \
    libmcrypt-devel \
    cronie \
    libssh2 \
    libssh2-devel \
    memcached \
    libmemcached-devel \
    initscripts \
    ImageMagick \
    ImageMagick-devel \
    ImageMagick-perl \
    mod_ssl \
    mod_php72u \
   	php72u-cli \
   	php72u-ldap \
   	php72u-bcmath \
    php72u-imap \
   	php72u-devel \
   	php72u-mysqlnd \
   	php72u-pdo \
   	php72u-mbstring \
   	php72u-soap \
   	php72u-gd \
    php72u-gmp \
   	php72u-xml \
    php72u-tidy \
   	php72u-pecl-apcu \
   	php72u-pecl-memcached \
   	php72u-pecl-igbinary \
    zip \
    unzip \
    p7zip \
    urw-fonts.noarch \
    pear1.noarch \
    && yum -y update bash \
    && rm -rf /var/cache/yum/* \
    && yum clean all


# Install PECL modules
RUN yes | pecl install -f ssh2-1.2
RUN yes | pecl install -f mcrypt-1.0.3 