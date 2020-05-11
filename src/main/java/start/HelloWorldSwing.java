package start;

/*
 * HelloWorldSwing.java requires no other files.
 */
import java.awt.*;
import javax.swing.*;

public class HelloWorldSwing {
    /**
     * Create the GUI and show it.  For thread safety, this method should be
     * invoked from the event-dispatching thread.
     */
    private static void buildGUI() {
        // Create window
        JFrame frame = new JFrame("HelloWorldSwing");
        frame.setPreferredSize(new Dimension(125, 75));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Add "Hello World" label
        JLabel label = new JLabel("   Hello World");
        frame.getContentPane().add(label);

        // Display window
        frame.pack();
        frame.setVisible(true);
    }

    public static void main(String[] args) {
        // Schedule a job for the event-dispatching thread
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                buildGUI();
            }
        });
    }
}
