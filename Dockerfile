FROM opensuse/leap

FROM maven:3.6.3-jdk-8

RUN apt-get update -y
RUN apt-get upgrade -y

# Get libraries to successfully execute for X11
RUN apt-get install -qqy x11-apps

RUN apt-get install libxext6
RUN apt-get install libxrender1
RUN apt-get install -y libxtst6
RUN apt-get install -y libxi6

ENV DISPLAY :0
CMD xeyes

WORKDIR /apps
COPY . /apps
RUN mvn clean install

# Execute the mainClass of the Swing application
CMD mvn exec:java -Dexec.mainClass="start.HelloWorldSwing"
