package com.codecentric.boot.sample;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;

@RestController
public class IndexController {
    @RequestMapping("/")
    public String index() {
        ClassLoader loader = Thread.currentThread().getContextClassLoader();
        try (InputStream resourceStream = loader.getResourceAsStream("application.yml")) {
            StringBuilder sb = new StringBuilder();
            for (int ch; (ch = resourceStream.read()) != -1; ) {
                sb.append((char) ch);
            }
            return "<pre><code>" + sb + "</code></pre>";
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "";
    }
}