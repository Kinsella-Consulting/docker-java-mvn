# docker-java-mvn
HelloWorld Java Swing App Running in a Docker Container built by Maven

## Reference Articles that got me started:
1. https://medium.com/@learnwell/how-to-dockerize-a-java-gui-application-bce560abf62a
2. https://blog.rabin.io/linux/running-java-gui-application-in-docker

## Steps to run a Java Swing Application in a Docker container built by Maven
1. Build image:
  `docker build -t java-swing-app-mvn .`
2. In a separate terminal, run command to satisfy x11:
  `socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`
    * As needed, install socat:
      `brew install socat`
3. Run:
  `docker run -ti -v /tmp/.X11-unix -v /tmp/.docker.xauth -e XAUTHORITY=/tmp/.docker.xauth --net=host -e DISPLAY=$(ipconfig getifaddr en0):0 java-swing-app-mvn`

## Previous Errors & Steps to get to above

```
[WARNING] java.awt.AWTError: Can't connect to X11 window server using '10.0.0.210:0' as the value of the DISPLAY variable.
	at sun.awt.X11GraphicsEnvironment.initDisplay(Native Method)
	at sun.awt.X11GraphicsEnvironment.access$200(X11GraphicsEnvironment.java:65)
	at sun.awt.X11GraphicsEnvironment$1.run(X11GraphicsEnvironment.java:115)
	at java.security.AccessController.doPrivileged(Native Method)
	at sun.awt.X11GraphicsEnvironment.<clinit>(X11GraphicsEnvironment.java:74)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:264)
	at java.awt.GraphicsEnvironment.createGE(GraphicsEnvironment.java:103)
	at java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment(GraphicsEnvironment.java:82)
	at sun.awt.X11.XToolkit.<clinit>(XToolkit.java:126)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:264)
	at java.awt.Toolkit$2.run(Toolkit.java:860)
	at java.awt.Toolkit$2.run(Toolkit.java:855)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.awt.Toolkit.getDefaultToolkit(Toolkit.java:854)
	at java.awt.Toolkit.getEventQueue(Toolkit.java:1734)
	at java.awt.EventQueue.invokeLater(EventQueue.java:1266)
	at javax.swing.SwingUtilities.invokeLater(SwingUtilities.java:1290)
	at start.HelloWorldSwing.main(HelloWorldSwing.java:31)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.mojo.exec.ExecJavaMojo$1.run(ExecJavaMojo.java:282)
	at java.lang.Thread.run(Thread.java:748)
```

## Attempts tried that continued to have the same error:
* https://github.com/containers/libpod/issues/5226
* https://stackoverflow.com/questions/44429394/x11-forwarding-of-a-gui-app-running-in-docker
* https://answers.sap.com/questions/2459539/dbua-can%27t-connect-to-x11-window-server-using-%27102.html
* https://www.docker.com/blog/build-your-first-docker-windows-server-container/
* https://dev.to/darksmile92/run-gui-app-in-linux-docker-container-on-windows-host-4kde
* https://stackoverflow.com/questions/44444099/how-to-solve-docker-permission-error-when-trigger-by-jenkins
* https://stackoverflow.com/questions/50452860/error-response-from-daemon-no-build-stage-in-current-context

## Reports of similar errors but not necessarily Docker related
* http://www.dsxchange.com/viewtopic.php?p=477017&sid=16f4b646b12ecaa79cc78d9e74c9742a
* https://www.linuxquestions.org/questions/solaris-opensolaris-20/can%27t-connect-to-x11-window-server-using-%27-10-0%27-as-the-value-of-the-display-variable-4175581149/

## The following is the one that got me the furthest but I'm getting a new error (below).
https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container/25280523#25280523

```
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
docker run -ti -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH xeyes
```

## In which I've converted to the following and ran as Step 3 (above)
```
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -ti -v /tmp/.X11-unix -v /tmp/.docker.xauth -e XAUTHORITY=/tmp/.docker.xauth java-swing-app-mvn
```

## Current Error

```
[WARNING] java.lang.UnsatisfiedLinkError: /usr/local/openjdk-8/jre/lib/amd64/libawt_xawt.so: libXtst.so.6: cannot open shared object file: No such file or directory
    at java.lang.ClassLoader$NativeLibrary.load (Native Method)
    at java.lang.ClassLoader.loadLibrary0 (ClassLoader.java:1934)
    at java.lang.ClassLoader.loadLibrary (ClassLoader.java:1817)
    at java.lang.Runtime.load0 (Runtime.java:809)
    at java.lang.System.load (System.java:1088)
    at java.lang.ClassLoader$NativeLibrary.load (Native Method)
    at java.lang.ClassLoader.loadLibrary0 (ClassLoader.java:1934)
    at java.lang.ClassLoader.loadLibrary (ClassLoader.java:1838)
    at java.lang.Runtime.loadLibrary0 (Runtime.java:870)
    at java.lang.System.loadLibrary (System.java:1124)
    at java.awt.Toolkit$3.run (Toolkit.java:1636)
    at java.awt.Toolkit$3.run (Toolkit.java:1634)
    at java.security.AccessController.doPrivileged (Native Method)
    at java.awt.Toolkit.loadLibraries (Toolkit.java:1633)
    at java.awt.Toolkit.<clinit> (Toolkit.java:1670)
    at java.awt.EventQueue.invokeLater (EventQueue.java:1294)
    at javax.swing.SwingUtilities.invokeLater (SwingUtilities.java:1295)
    at start.HelloWorldSwing.main (HelloWorldSwing.java:31)
    at sun.reflect.NativeMethodAccessorImpl.invoke0 (Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke (NativeMethodAccessorImpl.java:62)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke (DelegatingMethodAccessorImpl.java:43)
    at java.lang.reflect.Method.invoke (Method.java:498)
    at org.codehaus.mojo.exec.ExecJavaMojo$1.run (ExecJavaMojo.java:282)
    at java.lang.Thread.run (Thread.java:748)
```

## Researching the above error
* https://askubuntu.com/questions/674579/libawt-xawt-so-libxext-so-6-cannot-open-shared-object-file-no-such-file-or-di
* https://www.ibm.com/support/pages/unsatisfiedlinkerror-cannot-open-shared-object-file-libxtstso6

## Needed to add -y to apt-get calls in Dockerfile
* https://askubuntu.com/questions/509852/why-does-apt-get-abort-by-itself-as-though-id-pressed-n

`docker run -ti -v /tmp/.X11-unix -v /tmp/.docker.xauth -e XAUTHORITY=/tmp/.docker.xauth --net=host -e -e DISPLAY=$(ipconfig getifaddr en0):0 java-swing-app-mvn`
