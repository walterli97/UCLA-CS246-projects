import java.net.*;
import java.io.*;

public class GetWebpage {
    public static void main(String args[]) throws Exception {
        // args[0] has the URL passed as the command parameter.
        // You need to retrieve the webpage corresponding to the URL and print it out on console
        // Here, we simply printout the URL
        BufferedReader br = new BufferedReader(new InputStreamReader(new URL(args[0]).openConnection().getInputStream()));
        StringBuffer sb = new StringBuffer();
        String temp = null;
        while ((temp = br.readLine()) != null) {
            sb.append(temp).append("\r\n");
        }
        System.out.print(sb.toString());
        /*
        URL url = new URL(args[0]);
        InputStream input = url.openStream();
        ByteArrayOutputStream result = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int length;
        while ((length = input.read(buffer)) != -1) {
            result.write(buffer, 0, length);
        }
        String output = result.toString("UTF-8");
        StringBuilder sb = new StringBuilder(output);
        sb.delete(sb.length()-1, sb.length());
        System.out.print(sb.toString());
        */
    }
}
