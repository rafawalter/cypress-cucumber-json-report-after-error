FROM ubuntu:22.04

########### VARIAVEIS #############################
#ARG SHA256_PIPELINE_YML
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_HOME=/var/jenkins_home
ARG group_docker=docker
#ENV http_proxy=http://myproxy.local:8080
#ENV https_proxy=${http_proxy}
ENV no_proxy=.net
ENV DOCKER_GID_PRD=498
ENV DOCKER_GID=497
ENV DOCKER_VERSION=1.10.3
#ENV DOCKER_VERSION=18.09.9
ENV DEBIAN_FRONTEND=noninteractive
#ENV MAVEN_OPTS=-Duser.home=/var/jenkins_home
ENV JENKINS_HOME $JENKINS_HOME

############ USUARIO ROOT ##########################
USER root

############ PACOTES, LOCALES E TIMEZONE ###########
RUN apt-get update && apt-get install --no-install-recommends -y \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        lsb-release \
        wget \
        curl \
        jq \
        xz-utils \
        locales \
        git \
        fontconfig \
        bzip2 \
        ssh

#### PRE REQUISITOS CYPRESS
        libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    && echo "en_US.UTF-8    UTF-8\npt_BR.UTF-8    UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 pt_BR.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/Brazil/East /etc/localtime \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*


# Update package lists, install dependencies, add NodeSource repository, and install Node.js 18
RUN apt-get update && apt-get install -y \
    curl software-properties-common \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && corepack enable \
    && corepack prepare yarn@stable --activate \
    && rm -rf /var/lib/apt/lists/*

# Verify installation (optional)
RUN node -v && yarn -v




RUN groupadd -g ${DOCKER_GID_PRD} ${group_docker} \
    && useradd -u ${uid} -m -d /var/jenkins_home ${user} \
    && usermod -aG docker ${user} \
    && groupadd -g ${DOCKER_GID} dockerdsv \
    && usermod -a -G dockerdsv  ${user}

############ PERMISSAO ESCRITA APP #################
RUN	mkdir /opt/app \
    && chmod 777 /opt/app

WORKDIR /opt/app

############ CONFIGURACOES FINAIS ##################
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Prepare and cache node_modules
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn
RUN yarn cypress install

# Copy your application's files
COPY . .
RUN chmod +x ./run.sh

# Run Cypress tests
#CMD ["cat", "./package.json"]
#CMD ["yarn", "cypress", "run"]
#CMD ["cat", "./target/cucumber-reports/cucumber-report.json"]
CMD ["./run.sh"]
