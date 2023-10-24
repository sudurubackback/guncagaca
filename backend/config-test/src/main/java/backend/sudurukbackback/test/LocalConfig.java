package backend.sudurukbackback.test;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@RefreshScope       // Config.yml 파일 변경 시 변경된 내용을 actuator를 통해 변경값을 갱신
@Component
public class LocalConfig {
    // {application-profiles}.yml 에 정의한 내용을 해당 변수에 넣어줌
    @Value("${spring.username}")
    private String username;

    @Value("${spring.password}")
    private String password;

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public String toString() {
        return "LocalConfig{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}