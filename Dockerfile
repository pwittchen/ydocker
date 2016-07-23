FROM ubuntu:14.04
MAINTAINER pwittchen
USER root

# input arguments required to access artifactory
ARG SAP_USERNAME
ARG SAP_PASSWORD
ARG COMMERCE_SUITE_VERSION
ARG RECIPE

# install java
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install oracle-java8-installer -y
RUN apt-get install oracle-java8-set-default

# install tools
RUN apt-get install -y wget ant maven gradle

# download and extract hybris commerce suite
RUN mkdir -p /home/sap-hybris-cs
RUN wget --http-user=${SAP_USERNAME} --http-password=${SAP_PASSWORD} https://repository.hybris.com/hybris-release/de/hybris/platform/suite/commerce-suite/${COMMERCE_SUITE_VERSION}/commerce-suite-${COMMERCE_SUITE_VERSION}.zip
RUN unzip *.zip -d /home/sap-hybris-cs/
RUN rm *.zip

# set variable for hybris directory
ENV yHYBRIS_DIR="/home/sap-hybris-cs"

# install hybris recipe
RUN $yHYBRIS_DIR/installer/install.sh -r ${RECIPE}

# build and initialize the platform
RUN cd $yHYBRIS_DIR/hybris/bin/platform
RUN ant -f $yHYBRIS_DIR/hybris/bin/platform/build.xml clean all
RUN ant -f $yHYBRIS_DIR/hybris/bin/platform/build.xml initialize

# expose server port
EXPOSE 9002

# start the hybris platform
CMD cd $yHYBRIS_DIR/hybris/bin/platform/ && ./hybrisserver.sh
