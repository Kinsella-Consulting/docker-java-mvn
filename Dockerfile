FROM opensuse/leap

FROM maven:3.6.3-jdk-8

RUN apt-get update
RUN apt-get install -qqy x11-apps

#RUN apt-get install libxext6
RUN apt-get install libxrender1
RUN apt-get install -y libxtst6
RUN apt-get install -y libxi6

ENV DISPLAY :0
CMD xeyes

WORKDIR /apps
COPY . /apps
RUN mvn clean install

# Don't forget to substitute the following with a real mainClass
CMD mvn exec:java -Dexec.mainClass="start.HelloWorldSwing"
